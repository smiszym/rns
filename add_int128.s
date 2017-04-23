        .global add_int128

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
