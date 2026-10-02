nop
set pc main

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

#mark main
#    set dsc_device 0
#
#    set w_addr drawLine_x0
#    set w_val 5
#    pulse write
#    set w_addr drawLine_y0
#    set w_val 5
#    pulse write
#    set w_addr drawLine_x1
#    set w_val 50
#    pulse write
#    set w_addr drawLine_y1
#    set w_val 50
#    pulse write
#
#    set w_addr drawLine_Exit
#    set w_val main_drawLine_Exit1
#    pulse write
#
#    set pc drawLine
#
#    mark main_drawLine_Exit1
#
#    set dsc_device 0
#
#    set w_addr drawLine_x0
#    set w_val 40
#    pulse write
#    set w_addr drawLine_y0
#    set w_val 60
#    pulse write
#    set w_addr drawLine_x1
#    set w_val 48
#    pulse write
#    set w_addr drawLine_y1
#    set w_val 18
#    pulse write
#
#    set w_addr drawLine_Exit
#    set w_val main_drawLine_Exit2
#    pulse write
#
#    set pc drawLine
#
#    mark main_drawLine_Exit2
#
#    set w_addr drawLine_x0
#    set w_val 3
#    pulse write
#    set w_addr drawLine_y0
#    set w_val 30
#    pulse write
#    set w_addr drawLine_x1
#    set w_val 60
#    pulse write
#    set w_addr drawLine_y1
#    set w_val 5
#    pulse write
#
#    set w_addr drawLine_Exit
#    set w_val main_drawLine_Exit3
#    pulse write
#
#    set pc drawLine
#
#    mark main_drawLine_Exit3
#
#    pulse dsc_p2