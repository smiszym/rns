        .global read_int128

        .text
read_int128:
        # %rdi - result address
        # %rsi - string address
        pushq %rbx

        # Zero out the result
        xorl %eax, %eax
        movl %eax, 0x0(%rdi)
        movl %eax, 0x4(%rdi)
        movl %eax, 0x8(%rdi)
        movl %eax, 0xc(%rdi)

read:
        # Copy a character
        xorl %ebx, %ebx
        movb (%rsi), %bl
        test %bl, %bl
        jz finished

        # Check that it's a digit
        subb $0x30, %bl
        jl error # not a digit
        cmp $9, %bl
        jg error # not a digit

        # Multiply x3 by 10
        movl $10, %ecx
        movl 0xc(%rdi), %eax
        mull %ecx
        movl %eax, 0xc(%rdi)

        # Multiply x2 by 10; push MSB of the result
        movl 0x8(%rdi), %eax
        mull %ecx
        movl %eax, 0x8(%rdi)
        pushq %rdx

        # Multiply x1 by 10; push MSB of the result
        movl 0x4(%rdi), %eax
        mull %ecx
        movl %eax, 0x4(%rdi)
        pushq %rdx

        # Multiply x0 by 10; push MSB of the result
        movl 0x0(%rdi), %eax
        mull %ecx
        movl %eax, 0x0(%rdi)
        pushq %rdx

        # Add the digit and more significant halves of results
        addl %ebx, 0x0(%rdi)
        popq %rdx
        adcl %edx, 0x4(%rdi) # add the carry flag and more significant byte
        popq %rdx
        adcl %edx, 0x8(%rdi)
        popq %rdx
        adcl %edx, 0xc(%rdi)

        # Advance in string
        inc %rsi
        jmp read

finished:
        popq %rbx
        xorq %rax, %rax
        ret
error:
        popq %rbx
        movq $1, %rax
        ret
