package decoder8086

Register_Fields :: enum u8 {
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
    di = 0b_111_1
}