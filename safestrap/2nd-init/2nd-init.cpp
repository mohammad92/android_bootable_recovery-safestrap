/*
 * Copyright (c) 2017 Mohammad Afaneh (mohammad.afaneh92@gmail.com)
 * Copyright (c) 2016 rbox
 * Copyright (C) 2010-2011 Skrilax_CZ (skrilax@gmail.com)
 * Using work done by Pradeep Padala (ptrace functions) (p_padala@yahoo.com)
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <fcntl.h>
#include <dirent.h>
#include <elf.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/ptrace.h>
#include <sys/sendfile.h>
#include <sys/wait.h>

#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <stdlib.h>
#include <string.h>

#include <2nd-init.h>

static void read_init_map(const char *wanted_dev, unsigned long *base)
{
    char line[128];

    FILE *fp = fopen("/proc/1/maps", "r");
    while (fgets(line, sizeof(line), fp) != NULL)
    {
        if (strstr(line, wanted_dev))
        {
            sscanf(line, "%lx", base);
            break;
        }
    }
    fclose(fp);
}

static unsigned long find_execve(unsigned long image_base)
{
    unsigned long i;

    for (i = 0; ; i += sizeof(*execve_code))
    {
        unsigned long buffer[2];

        /* Read the next 8 or 16 bytes */
        buffer[0] = ptrace(PTRACE_PEEKTEXT, 1, image_base + i, NULL);
        buffer[1] = ptrace(PTRACE_PEEKTEXT, 1, image_base + i + sizeof(*buffer), NULL);

        /* compare them to the execve instructions */
        if (memcmp(buffer, execve_code, sizeof(buffer)) == 0)
        {
            /* Found the address of execve */
            return image_base + i;
        }
    }

    /* execve not found */
    return 0;
}

static void replace_init(void)
{
    /* Attach to existing init and wait for an interrupt */
    ptrace(PTRACE_ATTACH, 1, NULL, NULL);
    wait(NULL);

    /* Get first free address to inject */
    unsigned long data_inject_address = 0;
    read_init_map("00:00", &data_inject_address);

    /* Get init text address */
    unsigned long text_base = 0;
    read_init_map("00:01", &text_base);

    /* Find the address of execve in the init text */
    unsigned long execve_address = find_execve(text_base);

    /*======================================
     * Inject the data
     *
     * argv[0]         - pointer to "/init"
     * argv[1]/envp[0] - NULL
     * "/init"
     *======================================*/
    ptrace(PTRACE_POKEDATA, 1, data_inject_address + (sizeof(void *) * 0), data_inject_address + 0x10);
    ptrace(PTRACE_POKEDATA, 1, data_inject_address + (sizeof(void *) * 1), 0);
#ifdef __aarch64__
    ptrace(PTRACE_POKEDATA, 1, data_inject_address + (sizeof(void *) * 2), *(unsigned long *)"/init\0\0\0");
#else
    ptrace(PTRACE_POKEDATA, 1, data_inject_address + (sizeof(void *) * 2), *(unsigned long *)"/ini");
    ptrace(PTRACE_POKEDATA, 1, data_inject_address + (sizeof(void *) * 3), *(unsigned long *)"t\0\0\0");
#endif

    /* Get inits current registers */
#ifdef __aarch64__
    struct iovec ioVec;
    struct user_pt_regs regs[1];
    ioVec.iov_base = regs;
    ioVec.iov_len = sizeof(*regs);
    ptrace(PTRACE_GETREGSET, 1, NT_PRSTATUS, &ioVec);
#else
    struct pt_regs regs;
    ptrace(PTRACE_GETREGS, 1, NULL, &regs);
#endif

    /* Change the registers to call execve("/init", argv, envp) */
#ifdef __aarch64__
    regs->regs[0] = data_inject_address + 0x10; /* char *filename */
    regs->regs[1] = data_inject_address + 0x00; /* char *argv[] */
    regs->regs[2] = data_inject_address + 0x08; /* char *envp[] */
    regs->pc = execve_address;
    ptrace(PTRACE_SETREGSET, 1, NT_PRSTATUS, &ioVec);
#else
    regs.ARM_r0 = data_inject_address + (sizeof(void *) * 2); /* char*  filename */
    regs.ARM_r1 = data_inject_address + (sizeof(void *) * 0); /* char** argp */
    regs.ARM_r2 = data_inject_address + (sizeof(void *) * 1); /* char** envp */
    regs.ARM_pc = execve_address;
    ptrace(PTRACE_SETREGS, 1, NULL, &regs);
#endif

    /* Detach the ptrace */
    ptrace(PTRACE_DETACH, 1, NULL, NULL);
}

int main()
{
    /* Use ptrace to replace init */
    replace_init();

    return -1;
}
