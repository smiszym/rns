        .global rns_sub

        .text
rns_sub:
        # %rdi - result address
        # %rsi - first operand address
        # %rdx - second operand address
        # %rbx - rns_base address
        pushq %rbx
        movq $rns_base, %rbx


        # === r1 ===
        xorq %rax, %rax
        movl 0x0(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x0(%rdx), %ecx

        subq %rcx, %rax
        jge .L01 # Result is not negative; skip correction
        movl 0x0(%rbx), %ecx
        addq %rcx, %rax
.L01:
        # There will be at most one above
        movl 0x0(%rbx), %ecx
        cmpq %rcx, %rax
        jl .L02 # Result is in bounds; skip correction
        subq %rcx, %rax
.L02:
        movl %eax, 0x0(%rdi)


        # === r2 ===
        xorq %rax, %rax
        movl 0x4(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x4(%rdx), %ecx

        subq %rcx, %rax
        jge .L11 # Result is not negative; skip correction
        movl 0x4(%rbx), %ecx
        addq %rcx, %rax
.L11:
        # There will be at most one above
        movl 0x4(%rbx), %ecx
        cmpq %rcx, %rax
        jl .L12 # Result is in bounds; skip correction
        subq %rcx, %rax
.L12:
        movl %eax, 0x4(%rdi)


        # === r3 ===
        xorq %rax, %rax
        movl 0x8(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x8(%rdx), %ecx

        subq %rcx, %rax
        jge .L21 # Result is not negative; skip correction
        movl 0x8(%rbx), %ecx
        addq %rcx, %rax
.L21:
        # There will be at most one above
        movl 0x8(%rbx), %ecx
        cmpq %rcx, %rax
        jl .L22 # Result is in bounds; skip correction
        subq %rcx, %rax
.L22:
        movl %eax, 0x8(%rdi)


        popq %rbx
        ret
