        .global rns_add

        .text
rns_add:
        # %rdi - result address
        # %rsi - first operand address
        # %rdx - second operand address
        # %rbx - rns_base address
        pushq %rbx
        movq $rns_base, %rbx

        # r0
        xorq %rax, %rax
        movl 0x0(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x0(%rdx), %ecx

        addq %rcx, %rax

        movl 0x0(%rbx), %ecx
        # There will be at most one above
        cmpq %rcx, %rax
        jl .L0
        subq %rcx, %rax
.L0:
        movl %eax, 0x0(%rdi)

        # r1
        xorq %rax, %rax
        movl 0x4(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x4(%rdx), %ecx

        addq %rcx, %rax

        movl 0x4(%rbx), %ecx
        # There will be at most one above
        cmpq %rcx, %rax
        jl .L1
        subq %rcx, %rax
.L1:
        movl %eax, 0x4(%rdi)

        # r2
        xorq %rax, %rax
        movl 0x8(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x8(%rdx), %ecx

        addq %rcx, %rax

        movl 0x8(%rbx), %ecx
        # There will be at most one above
        cmpq %rcx, %rax
        jl .L2
        subq %rcx, %rax
.L2:
        movl %eax, 0x8(%rdi)

        # r3
        xorq %rax, %rax
        movl 0xc(%rsi), %eax

        xorq %rcx, %rcx
        movl 0xc(%rdx), %ecx

        addq %rcx, %rax

        movl 0xc(%rbx), %ecx
        # There will be at most one above
        cmpq %rcx, %rax
        jl .L3
        subq %rcx, %rax
.L3:
        movl %eax, 0xc(%rdi)

        popq %rbx
        ret
