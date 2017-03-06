        .global fib

        .text
fib:
        movq %rdi, %rcx

        # Case when argument is 1 or 2
        subq $2, %rcx
        jg .L2
        movq $1, %rax
        ret
.L2:
        # %rax contains current Fibonacci number
        # %rdx contains previous Fibonacci number
        movq $1, %rax
        movq $1, %rdx
.L1:
        pushq %rax
        addq %rdx, %rax
        popq %rdx
        loop .L1

        ret
