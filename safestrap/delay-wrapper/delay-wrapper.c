/*
**
** Copyright 2010, The Android Open Source Project
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
*/

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#define LOG_TAG   "DELAY-WRAPPER"

static void
userlog(const char* format, ...) {
    va_list args;

    fprintf(stdout, "%s: ", LOG_TAG);
    va_start(args, format);
    vfprintf(stdout, format, args);
    va_end(args);
}

int main(int argc, char **argv)
{
    struct stat to_stat;
    int r;
    char *newenv[] =
    {
        "HOME=/",
        "PATH=/vendor/bin:/system/bin:/system/xbin:/sbin:/xbin",
	"LD_LIBRARY_PATH=/vendor/lib:/system/lib",
        0
    };

    r = stat(SS_DELAY_WRAPPER_SKIP_FILE, &to_stat);
    if (r > -1) {
        /* User specified command for exec. */
        if (argc >= 1 ) {
            userlog("exec: %s ...\n", SS_DELAY_WRAPPER_BINARY);
            if (execve(SS_DELAY_WRAPPER_BINARY, argv, newenv) < 0) {
                userlog("exec failed for %s Error:%s\n", SS_DELAY_WRAPPER_BINARY, strerror(errno));
                return -errno;
            }
            userlog("exec success for %s.\n", SS_DELAY_WRAPPER_BINARY);
        }
        else {
            userlog("not enough arguments\n");
        }
    }
    else {
        userlog("Skipping exec file: %s (%s not found)\n", SS_DELAY_WRAPPER_BINARY, SS_DELAY_WRAPPER_SKIP_FILE);
    }
    return 0;
}