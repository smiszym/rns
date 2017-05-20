        .global int128_mod_M

        .text
int128_mod_M:
        subq $0x20, %rsp
        # Local variables:
        #  0x00(%rsp): int128 tmp
        #  0x10(%rsp): int128 argument address
        #  0x18(%rsp): loop counter

        # Copy argument address to 0x10(%rsp)
        movq %rdi, 0x10(%rsp)

        movq $36, %rcx
.L0:    decq %rcx
        movq %rcx, 0x18(%rsp)

# for (i = 35; i >= 0; --i) {

        # Copy M to tmp
        movq $2, %rcx
        leaq 0x00(%rsp), %rdi
        movq $M, %rsi
        rep movsq

        movq 0x18(%rsp), %rsi
        leaq 0x00(%rsp), %rdi
        call shl_int128

        # cmp_int128(argument, tmp)
        movq 0x10(%rsp), %rdi
        leaq 0x00(%rsp), %rsi
        call cmp_int128
        cmpq $0, %rax
        jl .L1
        call sub_int128
.L1:

# }
        movq 0x18(%rsp), %rcx
        inc %rcx
        loop .L0

        addq $0x20, %rsp
        ret
