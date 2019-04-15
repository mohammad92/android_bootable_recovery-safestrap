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

#ifndef SECOND_INIT_H
#define SECOND_INIT_H

#ifdef __aarch64__
/*========================================================
 * Signature of calling execve inside init
 * execve:
 *
 * D2801BA8	MOV	X8, #0xDD
 * D4000001	SVC	0
 * B140041F	CMN	X0, #1,LSL#12
 * DA809400	CINV	X0, X0, HI
 *========================================================*/

const int execve_code[] = { 0xD2801BA8, 0xD4000001, 0xB140041F, 0xDA809400 };
#else
/*========================================================
 * Signature of calling execve inside init
 * execve:
 *
 * 07C0A0E1	MOV	R12, R7
 * 0B70A0E3	LDR	R7, #0xB
 * 000000EF	SVC	0
 * 0C70A0E1	MOV	R7, R12
 *========================================================*/

const int execve_code[] = { 0x07C0A0E1, 0x0B70A0E3, 0x000000EF, 0x0C70A0E1 };
#endif

#endif //!SECOND_INIT_H
