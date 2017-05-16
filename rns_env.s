        .global rns_base, M

        .data
rns_base:
.int    0x7fffffff, 0x80000000, 0x80000001, 0x00000000

M:
.int    0x80000000, 0xffffffff, 0x1fffffff, 0x00000000
