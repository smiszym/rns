        .global load_int128

        .text
load_int128:
        # %rdi - dest address
        # %esi - number to load
        movl %esi, 0x0(%rdi)
        xorl %eax, %eax
        movl %eax, 0x4(%rdi)
        movl %eax, 0x8(%rdi)
        movl %eax, 0xc(%rdi)
        ret
