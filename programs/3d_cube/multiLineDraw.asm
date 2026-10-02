const drawLines_Number 2627
const drawLines_Exit 2628
mark drawLines
    set r_addr drawLines_Number
    copy r_out alu_a
    set alu_b A1
    set alu_op ADD
    copy alu_out r_addr

    copy r_out alu_a
    set alu_b 2
    set alu_op MUL
    copy alu_out alu_a
    set alu_b proj_0_X
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_x0

    copy alu_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_y0

    set r_addr drawLines_Number
    copy r_out alu_a
    set alu_b B1
    set alu_op ADD
    copy alu_out r_addr

    copy r_out alu_a
    set alu_b 2
    set alu_op MUL
    copy alu_out alu_a
    set alu_b proj_0_X
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_x1

    copy alu_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_y1

    set pc drawLine

    mark drawLines_drawLine_Exit

    set r_addr drawLines_Number
    copy r_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out w_val
    set w_addr drawLines_Number
    pulse write

    copy alu_out pc_value
    set pc_target 12
    set r_addr drawLines_Exit
    copy r_out pc_jmp
    pulse jump