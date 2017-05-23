        .global rns_to_int

        .text
rns_to_int:
        # %rdi - int128 dest
        # %rsi - rns src

        # Save %rsi
        pushq %rbx
        movq %rsi, %rbx

        call load_r2_to_int128
        movw $1, %si
        call shl_int128

        movq %rbx, %rsi
        call add_r1_to_int128
        call add_r3_to_int128
        movw $30, %si
        call shl_int128

        movq %rbx, %rsi
        call sub_r2_from_int128
        call add_r3_to_int128
        movw $1, %si
        call shl_int128

        movq %rbx, %rsi
        call add_r1_to_int128
        call sub_r3_from_int128
        movw $30, %si
        call shl_int128

        movq %rbx, %rsi
        call sub_r2_from_int128
        call sub_r3_from_int128
        movw $31, %si
        call shl_int128

        movq %rbx, %rsi
        call add_r2_to_int128

        call int128_mod_M

        popq %rbx
        ret
