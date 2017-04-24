        .global add_int128
        .global add_r0_to_int128
        .global add_r1_to_int128
        .global add_r2_to_int128

        .text
add_int128:
        # %rdi - dest address
        # %rsi - src address

        movq $128, %rcx
        clc
calculating:
        movb (%rsi), %al
        movb (%rdi), %dl
        adc %dl, %al
        movb %al, (%rdi)
        inc %rsi
        inc %rdi
        loop calculating

        ret


add_r0_to_int128:
        movl 0x0(%rsi), %eax
        jmp add_r_to_int128
add_r1_to_int128:
        movl 0x4(%rsi), %eax
        jmp add_r_to_int128
add_r2_to_int128:
        movl 0x8(%rsi), %eax
        # passthrough
add_r_to_int128:
        # %rdi - dest address
        # %rsi - struct rns, from which to load
        xorl %edx, %edx
        addl %eax, 0x0(%rdi)
        adcl %edx, 0x4(%rdi)
        adcl %edx, 0x8(%rdi)
        adcl %edx, 0xc(%rdi)
        ret
