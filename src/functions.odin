package decoder8086

decode_instruction :: proc(input: byte) -> (instruction: string) {
    opcode: byte = input >> 2
    decoded: string = ""
    switch opcode {
        case 0b_100010:
            decoded = "mov"
    }
    return decoded
}

decode_register_field :: proc(register, w_flag: byte) -> (register_field: Register_Fields) {
        return cast(Register_Fields) ((register << 1) | w_flag)
    }