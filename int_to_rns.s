        .global int_to_rns

        .text
int_to_rns:
        # %rdi - result address
        # %rsi - address of int128_t to convert
        pushq %rbx

        # Zero out the result
        xorl %eax, %eax
        movl %eax, 0x0(%rdi)
        movl %eax, 0x4(%rdi)
        movl %eax, 0x8(%rdi)
        movl %eax, 0xc(%rdi)

finished:
        popq %rbx
        xorq %rax, %rax
        ret
error:
        popq %rbx
        movq $1, %rax
        ret
