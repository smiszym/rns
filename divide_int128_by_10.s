        .global divide_int128_by_10

        .text
divide_int128_by_10:
        # %rdi - value address
        
        movl $10, %ecx

        # Start with no remainder from previous division
        xorq %rdx, %rdx

        movl 0xc(%rdi), %eax
        div %ecx
        movl %eax, 0xc(%rdi)

        movl 0x8(%rdi), %eax
        div %ecx
        movl %eax, 0x8(%rdi)

        movl 0x4(%rdi), %eax
        div %ecx
        movl %eax, 0x4(%rdi)

        movl 0x0(%rdi), %eax
        div %ecx
        movl %eax, 0x0(%rdi)

        # Return the remainder
        movq %rdx, %rax
        ret
