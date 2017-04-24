        .global load_r0_to_int128
        .global load_r1_to_int128
        .global load_r2_to_int128

        .text
load_r0_to_int128:
        movl 0x0(%rsi), %eax
        jmp load_int128
load_r1_to_int128:
        movl 0x4(%rsi), %eax
        jmp load_int128
load_r2_to_int128:
        movl 0x8(%rsi), %eax
        # passthrough
load_int128:
        # %rdi - dest address
        # %rsi - struct rns, from which to load
        movl %eax, 0x0(%rdi)
        xorl %eax, %eax
        movl %eax, 0x4(%rdi)
        movl %eax, 0x8(%rdi)
        movl %eax, 0xc(%rdi)
        ret
