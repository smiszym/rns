        .global int128_to_dec

        .text
int128_to_dec:
        # Local variables:
        #  0x00(%rsp): copy of the number
        #
        # Arguments:
        #  %rdi - address of output buffer
        #  %rsi - address of number

        pushq %rbx
        subq $0x10, %rsp

        movq %rdi, %rbx

        # Make a copy of the number
        movq %rsp, %rdi
        movq $2, %rcx
        rep movsq

        leaq 0x00(%rsp), %rdi
        movq %rbx, %rsi

        call is_int128_zero
        test %rax, %rax
        jnz is_zero

.L1:
        call is_int128_zero
        test %rax, %rax
        jnz .L0
        call divide_int128_by_10
        orb $0x30, %al
        movb %al, (%rsi)
        inc %rsi
        jmp .L1

.L0:
        movb $0x00, (%rsi)

        # Reverse digit order
        decq %rsi
        movq %rbx, %rdi

.L2:
        # Exchange (%rsi) and (%rdi)
        movb (%rsi), %al
        xchgb (%rdi), %al
        movb %al, (%rsi)

        decq %rsi
        incq %rdi
        cmpq %rdi, %rsi
        jg .L2

        addq $0x10, %rsp
        popq %rbx
        ret
is_zero:
        movw $0x0030, (%rsi) # zero followed by NUL
        addq $0x10, %rsp
        popq %rbx
        ret
