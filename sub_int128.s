        .global sub_int128

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
