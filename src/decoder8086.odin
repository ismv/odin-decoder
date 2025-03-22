package decoder8086

import "core:fmt"
import "core:os"
import "core:mem"

main :: proc() {
    
    if len(os.args) < 2 {
        fmt.println("No arguments provided. Please specify the path to the binary file.")
        return
    }
    file_path := os.args[1]

    file, err_open := os.open(file_path, os.O_RDONLY, 0)
    if err_open != nil {
        fmt.eprintln("Error opening file:", err_open)
    }

    defer os.close(file)

    file_info, err_stat := os.fstat(file)
    if err_stat != nil {
        fmt.eprintln("Error getting file info:", err_stat)
        return
    }

    file_size := file_info.size

    buffer := make([]byte, file_size)

    bytes_read, err_read := os.read(file, buffer[:])
    if err_read != nil {
        fmt.eprintln("Error reading file:", err_read)
        return
    }

    if i64(bytes_read) != file_size {
        fmt.eprintln("Warning: Could not read the entire file. Read", bytes_read, "bytes out of", file_size)
    }

    fmt.println("Successfully loaded", len(buffer), "bytes from", file_path)

    index: byte = 0
    chunk_size : byte : 2
    buffer_len : byte = cast(byte) (len(buffer))

    for index < buffer_len {
        remaining: byte = buffer_len - index
        current_chunk_len := chunk_size

        if remaining < chunk_size {
            current_chunk_len = remaining
        }

        if current_chunk_len == 0 {
            break
        }

        current_chunk := buffer[index : index + current_chunk_len]

        if len(current_chunk) == 2 {
            d_flag: byte = (current_chunk[0] >> 1) & 1
            w_flag: byte = current_chunk[0] & 1
            reg: byte = (current_chunk[1] >> 3) & 0b_111
            rm: byte = current_chunk[1] & 0b_111
    
            destination, source: byte = reg, rm
            if d_flag == 0 {
                destination, source = rm, reg
            }
    
            fmt.printf("%v %v, %v", decode_instruction(current_chunk[0]), decode_register_field(destination, w_flag), decode_register_field(source, w_flag))
            fmt.println(" ")
        } else {
            fmt.eprintln("Warning: Incomplete chunk at the end of the file.")
            break
        }

        index += current_chunk_len

    }
}