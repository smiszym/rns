        .global rns_mul

        .text
rns_mul:
        # %rdi - result address
        # %rsi - first operand address
        # %rdx - second operand address
        # %rbx - rns_base address
        pushq %rbx
        movq $rns_base, %rbx


        # === r0 ===
        xorq %rax, %rax
        movl 0x0(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x0(%rdx), %ecx

        # push %rdx, because it will be destroyed
        # by multiplication and division
        push %rdx

        # 1. multiplication
        # rdx:rax = rax * rcx
        mulq %rcx

        # 2. modulo
        # rdx = rdx:rax % rcx
        xorq %rcx, %rcx
        movl 0x0(%rbx), %ecx
        divq %rcx

        # store the result
        movl %edx, 0x0(%rdi)

        # restore %rdx
        pop %rdx


        # === r1 ===
        xorq %rax, %rax
        movl 0x4(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x4(%rdx), %ecx

        # push %rdx, because it will be destroyed
        # by multiplication and division
        push %rdx

        # 1. multiplication
        # rdx:rax = rax * rcx
        mulq %rcx

        # 2. modulo
        # rdx = rdx:rax % rcx
        xorq %rcx, %rcx
        movl 0x4(%rbx), %ecx
        divq %rcx

        # store the result
        movl %edx, 0x4(%rdi)

        # restore %rdx
        pop %rdx


        # === r2 ===
        xorq %rax, %rax
        movl 0x8(%rsi), %eax

        xorq %rcx, %rcx
        movl 0x8(%rdx), %ecx

        # push %rdx, because it will be destroyed
        # by multiplication and division
        push %rdx

        # 1. multiplication
        # rdx:rax = rax * rcx
        mulq %rcx

        # 2. modulo
        # rdx = rdx:rax % rcx
        xorq %rcx, %rcx
        movl 0x8(%rbx), %ecx
        divq %rcx

        # store the result
        movl %edx, 0x8(%rdi)

        # restore %rdx
        pop %rdx


        # === r3 ===
        xorq %rax, %rax
        movl 0xc(%rsi), %eax

        xorq %rcx, %rcx
        movl 0xc(%rdx), %ecx

        # push %rdx, because it will be destroyed
        # by multiplication and division
        push %rdx

        # 1. multiplication
        # rdx:rax = rax * rcx
        mulq %rcx

        # 2. modulo
        # rdx = rdx:rax % rcx
        xorq %rcx, %rcx
        movl 0xc(%rbx), %ecx
        divq %rcx

        # store the result
        movl %edx, 0xc(%rdi)

        # restore %rdx
        pop %rdx


        popq %rbx
        ret
