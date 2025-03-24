package decoder8086

import "core:fmt"

effective_address_calculation :: proc(instruction: []byte) {
    first_byte: byte = instruction[0]
    second_byte: byte = instruction[1]
    op_code: OP_CODE = decodeMoveInstruction(first_byte)

    #partial switch op_code {
        case .mov_mem_reg:
            d_flag, w_flag := flags(first_byte)
            mode: MODE = mode(second_byte)
            #partial switch mode {
                case .reg_mode:
                    r_m: REG_MEM = reg_mem_field((second_byte & 0b_111), w_flag)
                    reg: REG_MEM = reg_mem_field(((second_byte >> 3) & 0b_111), w_flag)
                    
                    destination, source := reg, r_m
                    if (d_flag == 0) {
                        destination, source = r_m, reg
                    }
                    fmt.printf("%v %v %v %v", op_code, mode, destination, source)
                    fmt.println(" ")
                case .mem_mode_16_disp:
                    reg: REG_MEM = reg_mem_field(second_byte & 0b_111, w_flag)
                    r_m: MEM_16BIT_DISP = reg_mem_mode_16_disp(((second_byte >> 3) & 0b_111))

                    fmt.printf("%v %v %v %v", op_code, mode, reg, r_m)
                    fmt.println(" ")
                case .mem_mode_8_disp:
                    reg: REG_MEM = reg_mem_field(second_byte & 0b_111, w_flag)
                    r_m: MEM_8BIT_DISP = reg_mem_mode_8_disp(((second_byte >> 3) & 0b_111))

                    fmt.printf("%v %v %v %v", op_code, mode, reg, r_m)
                    fmt.println(" ")

            }

    }
    

    // first we figure out what operation we are requested to perform
    


}

flags :: proc(input: byte) -> (d_flag, w_flag: byte) {
    return (input >> 1) & 1, input & 1
}

mode :: proc(second_byte: byte) -> (MODE) {
    return cast(MODE)((second_byte >> 6) & 0b_11)
}
