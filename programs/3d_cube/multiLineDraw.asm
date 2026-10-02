nop
set pc main

const drawLines_Number 0
const drawLines_Exit 0
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
    pulse write

    copy alu_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_y0
    pulse write

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
    pulse write

    copy alu_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out r_addr
    copy r_out w_val
    set w_addr drawLine_y1
    pulse write

    set w_addr drawLine_Exit
    set w_val drawLines_drawLine_Exit
    pulse write

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

    set pc drawLines

#todo===================================================================================================================

const drawLine_x0 0
const drawLine_y0 0
const drawLine_x1 0
const drawLine_y1 0
const drawLine_dx 0
const drawLine_dy 0
const drawLine_sx 0
const drawLine_sy 0
const drawLine_err 0
const drawLine_e2 0
const drawLine_Exit 0
const drawLine_temp1 0
mark drawLine
    set r_addr drawLine_x1
    copy r_out alu_a
    set r_addr drawLine_x0
    copy r_out alu_b
    set alu_op SUB
    copy alu_out w_val
    set w_addr drawLine_temp1
    pulse write

    copy alu_out alu_a
    set alu_b -1
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 1
    set pc_jmp drawLine_dx_init_plus
    set r_addr drawLine_temp1
    copy r_out alu_a
    pulse jump
    set pc drawLine_dx_init_exit
    mark drawLine_dx_init_plus
    set alu_b 1
    mark drawLine_dx_init_exit
    set alu_op MUL
    copy alu_out w_val
    set w_addr drawLine_dx
    pulse write

    set r_addr drawLine_y1
    copy r_out alu_a
    set r_addr drawLine_y0
    copy r_out alu_b
    set alu_op SUB
    copy alu_out w_val
    set w_addr drawLine_temp1
    pulse write

    copy alu_out alu_a
    set alu_b -1
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 1
    set pc_jmp drawLine_dy_init_plus
    set r_addr drawLine_temp1
    copy r_out alu_a
    pulse jump
    set pc drawLine_dy_init_exit
    mark drawLine_dy_init_plus
    set alu_b 1
    mark drawLine_dy_init_exit
    set alu_op MUL
    copy alu_out w_val
    set w_addr drawLine_dy
    pulse write

    set r_addr drawLine_x0
    copy r_out alu_a
    set r_addr drawLine_x1
    copy r_out alu_b
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 2
    set pc_jmp drawLine_sx_ret1
    pulse jump
    set w_val -1
    set pc drawLine_sx_exit
    mark drawLine_sx_ret1
    set w_val 1
    mark drawLine_sx_exit
    set w_addr drawLine_sx
    pulse write

    set r_addr drawLine_y0
    copy r_out alu_a
    set r_addr drawLine_y1
    copy r_out alu_b
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 2
    set pc_jmp drawLine_sy_ret1
    pulse jump
    set w_val -1
    set pc drawLine_sy_exit
    mark drawLine_sy_ret1
    set w_val 1
    mark drawLine_sy_exit
    set w_addr drawLine_sy
    pulse write

    set r_addr drawLine_dx
    copy r_out alu_a
    set r_addr drawLine_dy
    copy r_out alu_b
    set alu_op SUB
    copy alu_out w_val
    set w_addr drawLine_err
    pulse write

    mark drawLine_loop
        set dsc_d0 1
        set r_addr drawLine_x0
        copy r_out dsc_d1
        set r_addr drawLine_y0
        copy r_out dsc_d2
        set dsc_d3 255
        set dsc_d4 255
        set dsc_d5 255
        pulse dsc_p0

        set r_addr drawLine_x0
        copy r_out alu_a
        set r_addr drawLine_x1
        copy r_out alu_b
        set alu_op COMP
        copy alu_out pc_value
        set pc_target 1
        set pc_jmp drawLine_loop_condition1fail
        pulse jump
        set pc_target 2
        set pc_jmp drawLine_loop_condition1fail
        pulse jump

        set r_addr drawLine_y0
        copy r_out alu_a
        set r_addr drawLine_y1
        copy r_out alu_b
        set alu_op COMP
        copy alu_out pc_value
        set pc_target 1
        set pc_jmp drawLine_loop_condition1fail
        pulse jump
        set pc_target 2
        set pc_jmp drawLine_loop_condition1fail
        pulse jump

        set r_addr drawLine_Exit
        copy r_out pc

        mark drawLine_loop_condition1fail

        set r_addr drawLine_err
        copy r_out alu_a
        set alu_b 2
        set alu_op MUL
        copy alu_out w_val
        set w_addr drawLine_e2
        pulse write

        set r_addr drawLine_dy
        copy r_out alu_a
        set alu_b -1
        set alu_op MUL
        copy alu_out alu_b
        set r_addr drawLine_e2
        copy r_out alu_a
        set alu_op COMP
        copy alu_out pc_value
        set pc_target 0
        set pc_jmp drawLine_loop_condition2fail
        pulse jump
        set pc_target 2
        set pc_jmp drawLine_loop_condition2fail
        pulse jump

        set r_addr drawLine_err
        copy r_out alu_a
        set r_addr drawLine_dy
        copy r_out alu_b
        set alu_op SUB
        copy alu_out w_val
        set w_addr drawLine_err
        pulse write

        set r_addr drawLine_x0
        copy r_out alu_a
        set r_addr drawLine_sx
        copy r_out alu_b
        set alu_op ADD
        copy alu_out w_val
        set w_addr drawLine_x0
        pulse write

        mark drawLine_loop_condition2fail

        set r_addr drawLine_dx
        copy r_out alu_b
        set r_addr drawLine_e2
        copy r_out alu_a
        set alu_op COMP
        copy alu_out pc_value
        set pc_target 0
        set pc_jmp drawLine_loop_condition3fail
        pulse jump
        set pc_target 1
        set pc_jmp drawLine_loop_condition3fail
        pulse jump

        set r_addr drawLine_err
        copy r_out alu_a
        set r_addr drawLine_dx
        copy r_out alu_b
        set alu_op ADD
        copy alu_out w_val
        set w_addr drawLine_err
        pulse write

        set r_addr drawLine_y0
        copy r_out alu_a
        set r_addr drawLine_sy
        copy r_out alu_b
        set alu_op ADD
        copy alu_out w_val
        set w_addr drawLine_y0
        pulse write

        mark drawLine_loop_condition3fail

        set pc drawLine_loop


const proj_0_X 0
const proj_0_Y 0
const proj_1_X 0
const proj_1_Y 0
const proj_2_X 0
const proj_2_Y 0
const proj_3_X 0
const proj_3_Y 0
const proj_4_X 0
const proj_4_Y 0
const proj_5_X 0
const proj_5_Y 0
const proj_6_X 0
const proj_6_Y 0
const proj_7_X 0
const proj_7_Y 0

const A1 0
const A2 0
const A3 0
const A4 0
const A5 0
const A6 0
const A7 0
const A8 0
const A9 0
const A10 0
const A11 0
const A12 0

const B1 0
const B2 0
const B3 0
const B4 0
const B5 0
const B6 0
const B7 0
const B8 0
const B9 0
const B10 0
const B11 0
const B12 0

const initLines_Exit 2626
mark initLines
    set w_addr A1
    set w_val 0
    pulse write
    set w_addr B1
    set w_val 1
    pulse write

    set w_addr A2
    set w_val 0
    pulse write
    set w_addr B2
    set w_val 2
    pulse write

    set w_addr A3
    set w_val 1
    pulse write
    set w_addr B3
    set w_val 3
    pulse write

    set w_addr A4
    set w_val 2
    pulse write
    set w_addr B4
    set w_val 3
    pulse write

    set w_addr A5
    set w_val 4
    pulse write
    set w_addr B5
    set w_val 5
    pulse write

    set w_addr A6
    set w_val 4
    pulse write
    set w_addr B6
    set w_val 6
    pulse write

    set w_addr A7
    set w_val 5
    pulse write
    set w_addr B7
    set w_val 7
    pulse write

    set w_addr A8
    set w_val 6
    pulse write
    set w_addr B8
    set w_val 7
    pulse write

    set w_addr A9
    set w_val 0
    pulse write
    set w_addr B9
    set w_val 4
    pulse write

    set w_addr A10
    set w_val 2
    pulse write
    set w_addr B10
    set w_val 6
    pulse write

    set w_addr A11
    set w_val 3
    pulse write
    set w_addr B11
    set w_val 7
    pulse write

    set w_addr A12
    set w_val 1
    pulse write
    set w_addr B12
    set w_val 5
    pulse write

    set r_addr initLines_Exit
    copy r_out pc

mark main
    set w_addr initLines_Exit
    set w_val main_initLines_Exit
    pulse write

    set pc initLines

    mark main_initLines_Exit

    set w_addr proj_0_X
    set w_val 5
    pulse write
    set w_addr proj_0_Y
    set w_val 5
    pulse write
    set w_addr proj_1_X
    set w_val 45
    pulse write
    set w_addr proj_1_Y
    set w_val 5
    pulse write
    set w_addr proj_2_X
    set w_val 5
    pulse write
    set w_addr proj_2_Y
    set w_val 45
    pulse write
    set w_addr proj_3_X
    set w_val 45
    pulse write
    set w_addr proj_3_Y
    set w_val 45
    pulse write

    set w_addr proj_4_X
    set w_val 15
    pulse write
    set w_addr proj_4_Y
    set w_val 15
    pulse write
    set w_addr proj_5_X
    set w_val 35
    pulse write
    set w_addr proj_5_Y
    set w_val 15
    pulse write
    set w_addr proj_6_X
    set w_val 15
    pulse write
    set w_addr proj_6_Y
    set w_val 35
    pulse write
    set w_addr proj_7_X
    set w_val 35
    pulse write
    set w_addr proj_7_Y
    set w_val 35
    pulse write

    set w_addr drawLines_Exit
    set w_val main_drawLines_exit
    pulse write

    set pc drawLines

    mark main_drawLines_exit

    pulse dsc_p2

    set r_addr proj_0_X
    copy r_out w_val
    set w_addr drawLine_x0
    pulse write
    set r_addr proj_0_Y
    copy r_out w_val
    set w_addr drawLine_y0
    pulse write
    set r_addr proj_1_X
    copy r_out w_val
    set w_addr drawLine_x1
    pulse write
    set r_addr proj_1_Y
    copy r_out w_val
    set w_addr drawLine_y1
    pulse write

#    set w_addr drawLine_Exit
#    set w_val greg
#    pulse write
#
#    set pc drawLine
#
#    mark greg
#
#    pulse dsc_p2