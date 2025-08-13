	.file	"vec.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mfma -msse3 -mtune=generic -march=x86-64 -O2 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"usage: %s <dimension> <loops>\n"
	.align 8
.LC2:
	.string	"dimension %d > max dimension %ld\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"mmap"
.LC6:
	.string	"Dimensions: %d, Loops: %d \n"
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"Elapsed Time (Vector): %ld, Sum: %lf \n"
	.align 8
.LC8:
	.string	"Elapsed Time (Scalar): %ld, Sum: %lf \n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB51:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp	# tmp248, argv
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%edi, %ebx	# tmp247, argc
# vec.c:25:   int pagesz = sysconf(_SC_PAGESIZE);
	movl	$30, %edi	#,
# vec.c:17: {
	subq	$88, %rsp	#,
	.cfi_def_cfa_offset 144
# vec.c:17: {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp261
	movq	%rax, 72(%rsp)	# tmp261, D.4561
	xorl	%eax, %eax	# tmp261
# vec.c:25:   int pagesz = sysconf(_SC_PAGESIZE);
	call	sysconf@PLT	#
# vec.c:27:   if (argc != 3)
	cmpl	$3, %ebx	#, argc
	je	.L2	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	0(%rbp), %rdx	# *argv_60(D),
	movl	$1, %edi	#,
	leaq	.LC1(%rip), %rsi	#, tmp151
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# vec.c:30:     exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L2:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rbp), %rdi	# MEM[(char * *)argv_60(D) + 8B], MEM[(char * *)argv_60(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	strtol@PLT	#
	movq	16(%rbp), %rdi	# MEM[(char * *)argv_60(D) + 16B], MEM[(char * *)argv_60(D) + 16B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	movq	%rax, %rbx	# tmp249, _98
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %r15d	# _98, _99
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	call	strtol@PLT	#
	movq	%rax, (%rsp)	# tmp250, %sfp
# vec.c:36:   if (dimension > MAX_DIMENSION)
	cmpl	$268435456, %ebx	#, _98
	ja	.L22	#,
# vec.c:45:   s0 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);
	xorl	%r9d, %r9d	#
	xorl	%r8d, %r8d	#
	movl	$34, %ecx	#,
	movl	$3, %edx	#,
	movl	$1073741824, %esi	#,
	xorl	%edi, %edi	#
	call	mmap@PLT	#
# vec.c:46:   s1 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);
	xorl	%r9d, %r9d	#
	xorl	%r8d, %r8d	#
	movl	$34, %ecx	#,
	movl	$3, %edx	#,
	movl	$1073741824, %esi	#,
	xorl	%edi, %edi	#
# vec.c:45:   s0 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);
	movq	%rax, %rbp	# tmp251, s0
# vec.c:46:   s1 = (float *)mmap(0, MEMSZ, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,0,0);
	call	mmap@PLT	#
	movq	%rax, %r12	# tmp252, s1
# vec.c:48:   if (s0 == NULL || s1 == NULL)
	testq	%rbp, %rbp	# s0
	je	.L14	#,
	testq	%rax, %rax	# s1
	je	.L14	#,
# vec.c:54:   seedp = (long)s0 * getpid();
	call	getpid@PLT	#
# vec.c:57:   for (i=0; i<dimension; i++)
	movslq	%ebx, %rbx	# _98, _114
# vec.c:54:   seedp = (long)s0 * getpid();
	imull	%ebp, %eax	# s0, tmp160
	movl	%eax, 28(%rsp)	# tmp160, seedp
# vec.c:57:   for (i=0; i<dimension; i++)
	testq	%rbx, %rbx	# _114
	jle	.L6	#,
# vec.c:57:   for (i=0; i<dimension; i++)
	xorl	%r13d, %r13d	# i
	leaq	28(%rsp), %r14	#, tmp242
	.p2align 4,,10
	.p2align 3
.L7:
# vec.c:59:     s0[i] = (rand_r(&seedp) % 10) * 1.2345;
	movq	%r14, %rdi	# tmp242,
	call	rand_r@PLT	#
# vec.c:59:     s0[i] = (rand_r(&seedp) % 10) * 1.2345;
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp265
# vec.c:60:     s1[i] = (rand_r(&seedp) % 10) * 5.4321;
	movq	%r14, %rdi	# tmp242,
# vec.c:59:     s0[i] = (rand_r(&seedp) % 10) * 1.2345;
	movslq	%eax, %rdx	# _13, _13
	movl	%eax, %esi	# _13, tmp167
	imulq	$1717986919, %rdx, %rdx	#, _13, tmp164
	sarl	$31, %esi	#, tmp167
	sarq	$34, %rdx	#, tmp166
	subl	%esi, %edx	# tmp167, tmp162
	leal	(%rdx,%rdx,4), %edx	#, tmp170
	addl	%edx, %edx	# tmp171
	subl	%edx, %eax	# tmp171, tmp172
# vec.c:59:     s0[i] = (rand_r(&seedp) % 10) * 1.2345;
	vcvtsi2sdl	%eax, %xmm1, %xmm0	# tmp172, tmp265, tmp259
	vmulsd	.LC4(%rip), %xmm0, %xmm0	#, tmp173, tmp174
	vcvtsd2ss	%xmm0, %xmm0, %xmm0	# tmp174, tmp178
	vmovss	%xmm0, 0(%rbp,%r13,4)	# tmp178, MEM[(float *)s0_62 + _30 * 4]
# vec.c:60:     s1[i] = (rand_r(&seedp) % 10) * 5.4321;
	call	rand_r@PLT	#
# vec.c:60:     s1[i] = (rand_r(&seedp) % 10) * 5.4321;
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp267
# vec.c:60:     s1[i] = (rand_r(&seedp) % 10) * 5.4321;
	movslq	%eax, %rdx	# _21, _21
	movl	%eax, %esi	# _21, tmp185
	imulq	$1717986919, %rdx, %rdx	#, _21, tmp182
	sarl	$31, %esi	#, tmp185
	sarq	$34, %rdx	#, tmp184
	subl	%esi, %edx	# tmp185, tmp180
	leal	(%rdx,%rdx,4), %edx	#, tmp188
	addl	%edx, %edx	# tmp189
	subl	%edx, %eax	# tmp189, tmp190
# vec.c:60:     s1[i] = (rand_r(&seedp) % 10) * 5.4321;
	vcvtsi2sdl	%eax, %xmm1, %xmm0	# tmp190, tmp267, tmp260
	vmulsd	.LC5(%rip), %xmm0, %xmm0	#, tmp191, tmp192
	vcvtsd2ss	%xmm0, %xmm0, %xmm0	# tmp192, tmp196
	vmovss	%xmm0, (%r12,%r13,4)	# tmp196, MEM[(float *)s1_64 + _30 * 4]
# vec.c:57:   for (i=0; i<dimension; i++)
	addq	$1, %r13	#, i
# vec.c:57:   for (i=0; i<dimension; i++)
	cmpq	%rbx, %r13	# _114, i
	jne	.L7	#,
.L6:
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	(%rsp), %r13	# %sfp, _96
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	%r15d, %edx	# _99,
	leaq	.LC6(%rip), %rsi	#, tmp197
	xorl	%eax, %eax	#
	movl	$1, %edi	#,
# vec.c:65:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	leaq	32(%rsp), %r14	#, tmp245
# /usr/include/stdlib.h:364:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%r13d, %ecx	# _96, _97
# vec.c:68:   for (i=0; i<loops; i++)
	movslq	%r13d, %r13	# _96, _110
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# vec.c:65:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	movq	%r14, %rsi	# tmp245,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# vec.c:68:   for (i=0; i<loops; i++)
	testq	%r13, %r13	# _110
	jle	.L8	#,
# vec.c:23:   double sum = 0.0;
	movq	$0x000000000, (%rsp)	#, %sfp
# vec.c:68:   for (i=0; i<loops; i++)
	xorl	%r15d, %r15d	# i
	.p2align 4,,10
	.p2align 3
.L9:
# vec.c:69:     sum += euclid_scalar(s0, s1, dimension);
	movq	%rbx, %rdx	# _114,
	movq	%r12, %rsi	# s1,
	movq	%rbp, %rdi	# s0,
# vec.c:68:   for (i=0; i<loops; i++)
	addq	$1, %r15	#, i
# vec.c:69:     sum += euclid_scalar(s0, s1, dimension);
	call	euclid_scalar@PLT	#
# vec.c:69:     sum += euclid_scalar(s0, s1, dimension);
	vaddsd	(%rsp), %xmm0, %xmm2	# %sfp, tmp256, sum
	vmovsd	%xmm2, (%rsp)	# sum, %sfp
# vec.c:68:   for (i=0; i<loops; i++)
	cmpq	%r13, %r15	# _110, i
	jne	.L9	#,
# vec.c:71:   clock_gettime(CLOCK_MONOTONIC, &ts1);
	leaq	48(%rsp), %rax	#, tmp246
	movl	$1, %edi	#,
# vec.c:80:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	xorl	%r15d, %r15d	# i
# vec.c:71:   clock_gettime(CLOCK_MONOTONIC, &ts1);
	movq	%rax, %rsi	# tmp246,
	movq	%rax, 8(%rsp)	# tmp246, %sfp
	call	clock_gettime@PLT	#
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	movq	48(%rsp), %rax	# ts1.tv_sec, ts1.tv_sec
	subq	32(%rsp), %rax	# ts0.tv_sec, tmp228
# vec.c:76:   printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	movl	$1000000, %ecx	#, tmp237
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	imulq	$1000000000, %rax, %rax	#, tmp228, tmp230
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	addq	56(%rsp), %rax	# ts1.tv_nsec, tmp231
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	subq	40(%rsp), %rax	# ts0.tv_nsec, elapsed
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$1, %edi	#,
# vec.c:76:   printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	cqto
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	(%rsp), %xmm0	# %sfp,
	leaq	.LC8(%rip), %rsi	#, tmp238
# vec.c:76:   printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	idivq	%rcx	# tmp237
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	%rax, %rdx	# tmp235,
	movl	$1, %eax	#,
	call	__printf_chk@PLT	#
# vec.c:80:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	movq	%r14, %rsi	# tmp245,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
	movq	$0x000000000, (%rsp)	#, %sfp
	.p2align 4,,10
	.p2align 3
.L11:
# vec.c:84:     sum += euclid_vector(s0, s1, dimension);
	movq	%rbx, %rdx	# _114,
	movq	%r12, %rsi	# s1,
	movq	%rbp, %rdi	# s0,
# vec.c:83:   for (i=0; i<loops; i++)
	addq	$1, %r15	#, i
# vec.c:84:     sum += euclid_vector(s0, s1, dimension);
	call	euclid_vector@PLT	#
# vec.c:84:     sum += euclid_vector(s0, s1, dimension);
	vaddsd	(%rsp), %xmm0, %xmm4	# %sfp, tmp257, sum
	vmovsd	%xmm4, (%rsp)	# sum, %sfp
# vec.c:83:   for (i=0; i<loops; i++)
	cmpq	%r13, %r15	# _110, i
	jne	.L11	#,
.L12:
# vec.c:86:   clock_gettime(CLOCK_MONOTONIC, &ts1);
	movq	8(%rsp), %rsi	# %sfp,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# vec.c:88:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	movq	48(%rsp), %rax	# ts1.tv_sec, ts1.tv_sec
	subq	32(%rsp), %rax	# ts0.tv_sec, tmp200
# vec.c:90:   printf("Elapsed Time (Vector): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	movl	$1000000, %ecx	#, tmp209
# vec.c:88:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	imulq	$1000000000, %rax, %rax	#, tmp200, tmp202
# vec.c:88:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	addq	56(%rsp), %rax	# ts1.tv_nsec, tmp203
# vec.c:88:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	subq	40(%rsp), %rax	# ts0.tv_nsec, elapsed
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$1, %edi	#,
# vec.c:90:   printf("Elapsed Time (Vector): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	cqto
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	(%rsp), %xmm0	# %sfp,
	leaq	.LC7(%rip), %rsi	#, tmp210
# vec.c:90:   printf("Elapsed Time (Vector): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	idivq	%rcx	# tmp209
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	%rax, %rdx	# tmp207,
	movl	$1, %eax	#,
	call	__printf_chk@PLT	#
# vec.c:94:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	movq	%r14, %rsi	# tmp245,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# vec.c:108:   munmap(s0, MEMSZ);
	movl	$1073741824, %esi	#,
	movq	%rbp, %rdi	# s0,
	call	munmap@PLT	#
# vec.c:109:   munmap(s1, MEMSZ);
	movl	$1073741824, %esi	#,
	movq	%r12, %rdi	# s1,
	call	munmap@PLT	#
# vec.c:112: }
	movq	72(%rsp), %rax	# D.4561, tmp262
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp262
	jne	.L23	#,
	addq	$88, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax	#
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L22:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$1, %edi	#,
	movl	$268435456, %ecx	#,
	movl	%ebx, %edx	# _99,
	xorl	%eax, %eax	#
	leaq	.LC2(%rip), %rsi	#, tmp154
	call	__printf_chk@PLT	#
# vec.c:39:     exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L14:
# vec.c:50:     perror("mmap");
	leaq	.LC3(%rip), %rdi	#, tmp159
	call	perror@PLT	#
# vec.c:51:     exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L8:
# vec.c:71:   clock_gettime(CLOCK_MONOTONIC, &ts1);
	leaq	48(%rsp), %rax	#, tmp246
	movl	$1, %edi	#,
	movq	%rax, %rsi	# tmp246,
	movq	%rax, 8(%rsp)	# tmp246, %sfp
	call	clock_gettime@PLT	#
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	movq	48(%rsp), %rax	# ts1.tv_sec, ts1.tv_sec
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vxorpd	%xmm0, %xmm0, %xmm0	#
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	subq	32(%rsp), %rax	# ts0.tv_sec, tmp214
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	imulq	$1000000000, %rax, %rax	#, tmp214, tmp216
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	addq	56(%rsp), %rax	# ts1.tv_nsec, tmp217
# vec.c:73:   elapsed = (ts1.tv_sec - ts0.tv_sec) * 1000000000 + (ts1.tv_nsec - ts0.tv_nsec);
	subq	40(%rsp), %rax	# ts0.tv_nsec, elapsed
# vec.c:76:   printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	movl	$1000000, %ecx	#, tmp223
	cqto
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC8(%rip), %rsi	#, tmp225
	movl	$1, %edi	#,
# vec.c:76:   printf("Elapsed Time (Scalar): %ld, Sum: %lf \n", elapsed/(1000*1000), sum);
	idivq	%rcx	# tmp223
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:112:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	%rax, %rdx	# tmp221,
	movl	$1, %eax	#,
	call	__printf_chk@PLT	#
# vec.c:80:   clock_gettime(CLOCK_MONOTONIC, &ts0);
	movq	%r14, %rsi	# tmp245,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# vec.c:78:   sum = 0.0;
	movq	$0x000000000, (%rsp)	#, %sfp
	jmp	.L12	#
.L23:
# vec.c:112: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE51:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	309237645
	.long	1072939139
	.align 8
.LC5:
	.long	1814194186
	.long	1075165816
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
