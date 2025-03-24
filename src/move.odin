package decoder8086


Move_Instruction :: struct {
    opcode: OP_CODE,
    length: u8,
}

_instructions : []Move_Instruction = {
    { opcode = OP_CODE.mov_regmem_segmreg, length = 8 },
    { opcode = OP_CODE.mov_segmreg_regmem, length = 8 },
    { opcode = OP_CODE.mov_imm_regmem, length = 7 },
    { opcode = OP_CODE.mov_mem_acc, length = 7 },
    { opcode = OP_CODE.mov_acc_mem, length = 7 },
    { opcode = OP_CODE.mov_mem_reg, length = 6 },
    { opcode = OP_CODE.mov_imm_reg, length = 4},

}

decodeMoveInstruction :: proc(instruction_byte: byte) -> (OP_CODE) {
    instr : OP_CODE = OP_CODE.unknown

    for instruction in _instructions {
        mask: u8 = (1 << instruction.length) -1
        mask <<= (8 - instruction.length)

        instruction_bits: u8 = instruction_byte & mask

        shifted_instruction_bits := instruction_bits >> (8 - instruction.length)
        shifted_opcode := cast(u8)instruction.opcode

        if shifted_instruction_bits == shifted_opcode {
            instr = instruction.opcode
            break
        }
    }

    return instr
}