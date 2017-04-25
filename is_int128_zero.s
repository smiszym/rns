        .global is_int128_zero

        .text
is_int128_zero:
        # %rdi - value address
        cmpl $0, 0x0(%rdi)
        jnz not_zero
        cmpl $0, 0x4(%rdi)
        jnz not_zero
        cmpl $0, 0x8(%rdi)
        jnz not_zero
        cmpl $0, 0xc(%rdi)
        jnz not_zero
        movq $1, %rax
        ret
    not_zero:
        xorq %rax, %rax
        ret
