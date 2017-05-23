        .global sub_int128
        .global sub_r1_from_int128
        .global sub_r2_from_int128
        .global sub_r3_from_int128

        .text
sub_int128:
        # %rdi - dest address
        # %rsi - src address

        movq $16, %rcx
        clc
calculating:
        movb (%rsi), %dl
        movb (%rdi), %al
        sbbb %dl, %al
        movb %al, (%rdi)
        inc %rsi
        inc %rdi
        loop calculating

        ret


sub_r1_from_int128:
        movl 0x0(%rsi), %eax
        jmp sub_r_from_int128
sub_r2_from_int128:
        movl 0x4(%rsi), %eax
        jmp sub_r_from_int128
sub_r3_from_int128:
        movl 0x8(%rsi), %eax
        # passthrough
sub_r_from_int128:
        # %rdi - dest address
        # %rsi - struct rns, from which to subtract
        xorl %edx, %edx
        subl %eax, 0x0(%rdi)
        sbbl %edx, 0x4(%rdi)
        sbbl %edx, 0x8(%rdi)
        sbbl %edx, 0xc(%rdi)
        ret
