package decoder8086

MODE :: enum byte {
    reg_mode = 0b_11,
    mem_mode_16_disp = 0b_10,
    mem_mode_8_disp = 0b_01,
    mem_mode_no_disp = 0b_00,
}

OP_CODE :: enum byte {
    unknown = 0b_00000000,
    mov_mem_reg = 0b_100010,
    mov_imm_regmem = 0b_1100011,
    mov_imm_reg = 0b_1011,
    mov_mem_acc = 0b_1010000,
    mov_acc_mem = 0b_1010001,
    mov_regmem_segmreg = 0b_10001110,
    mov_segmreg_regmem = 0b_10001100,
}

reg_mem_field :: proc(register, w_flag: byte) -> (REG_MEM) {
    return cast(REG_MEM) ((register << 1) | w_flag)
}
REG_MEM :: enum byte {
    al = 0b_000_0,
    cl = 0b_001_0,
    dl = 0b_010_0,
    bl = 0b_011_0,
    ah = 0b_100_0,
    ch = 0b_101_0,
    dh = 0b_110_0,
    bh = 0b_111_0,

    ax = 0b_000_1,
    cx = 0b_001_1,
    dx = 0b_010_1,
    bx = 0b_011_1,
    sp = 0b_100_1,
    bp = 0b_101_1,
    si = 0b_110_1,
    di = 0b_111_1,
}

reg_mem_no_disp :: proc(register: byte) -> (MEM_NO_DISP) {
    return cast(MEM_NO_DISP) register
}
MEM_NO_DISP :: enum byte {
    bx_si = 0b_000,
    bx_di = 0b_001,
    bp_si = 0b_010,
    bp_di = 0b_011,
    si = 0b_100,
    di = 0b_101,
    dir_addr = 0b_110,
    bx = 0b_111,
}

reg_mem_mode_8_disp :: proc(register: byte) -> (MEM_8BIT_DISP) {
    return cast(MEM_8BIT_DISP) register
}
MEM_8BIT_DISP :: enum byte {
    bx_si_d8 = 0b_000,
    bx_di_d8 = 0b_001,
    bp_si_d8 = 0b_010,
    bp_di_d8 = 0b_011,
    si_d8 = 0b_100,
    di_d8 = 0b_101,
    bp_d8 = 0b_110,
    bx_d8 = 0b_111,
}

reg_mem_mode_16_disp :: proc(register: byte) -> (MEM_16BIT_DISP) {
    return cast(MEM_16BIT_DISP) register
}
MEM_16BIT_DISP :: enum byte {
    bx_si_d16 = 0b_000,
    bx_di_d16 = 0b_001,
    bp_si_d16 = 0b_010,
    bp_di_d16 = 0b_011,
    si_d16 = 0b_100,
    di_d16 = 0b_101,
    bp_d16 = 0b_110,
    bx_d16 = 0b_111,
}