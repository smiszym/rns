        .global int_to_rns

        .text
int_to_rns:
        # %rdi - result address
        # %rsi - address of int128_t to convert
        # %rbx - address of rns_base
        #
        # The integer to convert will be divided into
        # three parts, 31 bits each. The least and the most
        # significant parts will be summed and stored
        # in %r8. The remaining part will be stored in %r9.
        #
        # Meanwhile, after we retrieved the least significant
        # 31 bits, we store it as r1.
        #
        # Then, we can calculate modules as:
        #   r0 = %r8 + %r9
        #   r2 = %r8 - %r9
        #
        # (*) Because it may be confusing, here are
        #     meanings of the symbols:
        #       r0, r1, r2 - modules in RNS representation
        #                    of the input value
        #       %r8, %r9 - two 64-bit processor registers

        pushq %rbx
        movq $rns_base, %rbx

        # Check if the value is in bounds
        pushq %rdi
        movq $M, %rdi
        call cmp_int128
        cmpq $0, %rax
        popq %rdi
        jle out_of_bounds

        # === Calculate %r8 and %r9 ===
        xorq %rax, %rax
        xorq %rdx, %rdx

        # bits 0-30 -> %r8[0-30]
        movl 0x0(%rsi), %eax
        andl $0x7fffffff, %eax
        movl %eax, 0x4(%rdi) # store as r1
        movq %rax, %r8

        # bits 64-92 -> %r8[2-30]
        movl 0x8(%rsi), %eax
        andl $0x1fffffff, %eax
        shl $2, %eax
        addq %rax, %r8

        # bits 62-63 -> %r8[0-1]
        movl 0x4(%rsi), %eax
        shr $30, %eax
        addq %rax, %r8

        # bits 32-61 -> %r9[1-30]
        movl 0x4(%rsi), %eax
        andl $0x3fffffff, %eax
        shl $1, %eax
        movq %rax, %r9

        # bit 31 -> %r9[0]
        movl 0x0(%rsi), %eax
        andl $0x80000000, %eax
        shr $31, %eax
        addq %rax, %r9



        # === r0 ===
        movq %r8, %rax
        addq %r9, %rax

        movl 0x0(%rbx), %edx
.L01:   # There will be at most two above
        cmpq %rdx, %rax
        jl .L00
        subq %rdx, %rax
        jmp .L01
.L00:
        movl %eax, 0x0(%rdi)

        # === r2 ===
        movl 0x8(%rbx), %edx
        movq %r8, %rax
        subq %r9, %rax
        jge .L11 # Result is not negative; skip correction
        addq %rdx, %rax
.L11:   # There will be at most two above
        cmpq %rdx, %rax
        jl .L10
        subq %rdx, %rax
        jmp .L11
.L10:
        movl %eax, 0x8(%rdi)

finished:
        popq %rbx
        xorq %rax, %rax
        ret
out_of_bounds:
        # Argument's value too big
        popq %rbx
        movq $1, %rax
        ret
