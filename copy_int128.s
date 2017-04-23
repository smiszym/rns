        .global copy_int128

        .text
copy_int128:
        # %rdi - dest address
        # %rsi - src address
        movl 0x0(%rsi), %eax
        movl %eax, 0x0(%rdi)
        movl 0x4(%rsi), %eax
        movl %eax, 0x4(%rdi)
        movl 0x8(%rsi), %eax
        movl %eax, 0x8(%rdi)
        movl 0xc(%rsi), %eax
        movl %eax, 0xc(%rdi)
        ret
