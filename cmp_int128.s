        .global cmp_int128

        .text
cmp_int128:
        # %rdi - a address
        # %rsi - b address
        #
        #   a > b   +1
        #   a = b    0
        #   a < b   -1

        movl 0xc(%rdi), %eax
        cmpl 0xc(%rsi), %eax
        ja greater
        jb less

        movl 0x8(%rdi), %eax
        cmpl 0x8(%rsi), %eax
        ja greater
        jb less

        movl 0x4(%rdi), %eax
        cmpl 0x4(%rsi), %eax
        ja greater
        jb less

        movl 0x0(%rdi), %eax
        cmpl 0x0(%rsi), %eax
        ja greater
        jb less

    equal:
        xorq %rax, %rax
        ret
    greater:
        movq $1, %rax
        ret
    less:
        movq $-1, %rax
        ret
