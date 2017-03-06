        .global rns_add

        .text
rns_add:
        # %rdi - result address
        # %rsi - first operand address
        # %rdx - second operand address

        # TODO modulo

        # r0
        xorq %rax, %rax
        movl 0x0(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x0(%rdx), %ecx

        addq 0x0(%rdx), %rax
        movl %eax, 0x0(%rdi)

        # r1
        xorq %rax, %rax
        movl 0x4(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x4(%rdx), %ecx

        addq 0x4(%rdx), %rax
        movl %eax, 0x4(%rdi)

        # r2
        xorq %rax, %rax
        movl 0x8(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x8(%rdx), %ecx

        addq 0x8(%rdx), %rax
        movl %eax, 0x8(%rdi)

        # r3
        xorq %rax, %rax
        movl 0xc(%rsi), %eax

        xorq %rcx, %rcx
        movl 0xc(%rdx), %ecx

        addq 0xc(%rdx), %rax
        movl %eax, 0xc(%rdi)

        ret
