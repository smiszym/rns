        .global shl_int128

        .text
# Utility routine that shifts the number
# left by 32 bits and decreases %rsi by 32.
shift_bytes:
        # %rdi - int128 address
        movl 0x8(%rdi), %eax
        movl %eax, 0xc(%rdi)
        movl 0x4(%rdi), %eax
        movl %eax, 0x8(%rdi)
        movl 0x0(%rdi), %eax
        movl %eax, 0x4(%rdi)
        xorl %eax, %eax
        movl %eax, 0x0(%rdi)
        sub $32, %rsi

shl_int128:
        # %rdi - int128 address
        # %rsi - number of shifts
        andq $0xff, %rsi # only take one byte into account
        cmp $32, %rsi
        jge shift_bytes

        mov %rsi, %rcx
        xor %rdx, %rdx

        # x3
        mov 0xc(%rdi), %eax
        shl %cl, %eax
        mov 0x8(%rdi), %edx
        shl %cl, %rdx
        shr $32, %rdx
        add %edx, %eax
        mov %eax, 0xc(%rdi)

        # x2
        mov 0x8(%rdi), %eax
        shl %cl, %eax
        mov 0x4(%rdi), %edx
        shl %cl, %rdx
        shr $32, %rdx
        add %edx, %eax
        mov %eax, 0x8(%rdi)

        # x1
        mov 0x4(%rdi), %eax
        shl %cl, %eax
        mov 0x0(%rdi), %edx
        shl %cl, %rdx
        shr $32, %rdx
        add %edx, %eax
        mov %eax, 0x4(%rdi)

        # x0
        mov 0x0(%rdi), %eax
        shl %cl, %eax
        mov %eax, 0x0(%rdi)

        ret
