        .global int_to_rns

        .text
int_to_rns:
        # %rdi - result address
        # %rsi - address of int128_t to convert
        pushq %rbx

        # === r1 ===
        movl 0x0(%rsi), %eax
        andl $0x7fffffff, %eax
        movl %eax, 0x4(%rdi)

finished:
        popq %rbx
        xorq %rax, %rax
        ret
error:
        # Argument's value too big
        popq %rbx
        movq $1, %rax
        ret
