const focalLength 2567

const projectVertex_VertexNumber 2568
const projectVertex_X 2569
const projectVertex_Y 2570
const projectVertex_temp1 2571
const projectVertex_Exit 2572
mark projectVertex
    set w_addr getRotatedVertex_Number
    set r_addr projectVertex_VertexNumber
    copy r_out w_val
    pulse write

    set w_addr getRotatedVertex_Exit
    set w_val projectVertex_getVertexExit1
    pulse write

    set pc getRotatedVertex

    mark projectVertex_getVertexExit1

    # projectedX = ( X * FocalLength ) / ( Z + FocalLength )

    set r_addr getRotatedVertex_X
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr projectVertex_temp1
    pulse write

    set r_addr getRotatedVertex_Z
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op ADD
    copy alu_out alu_b

    set r_addr projectVertex_temp1
    copy r_out alu_a
    set alu_op DIV
    copy alu_out w_val
    set w_addr projectVertex_X
    pulse write

    set r_addr getRotatedVertex_Y
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr projectVertex_temp1
    pulse write

    set r_addr getRotatedVertex_Z
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op ADD
    copy alu_out alu_b

    set r_addr projectVertex_temp1
    copy r_out alu_a
    set alu_op DIV
    copy alu_out w_val
    set w_addr projectVertex_Y
    pulse write

    set r_addr projectVertex_Exit
    copy r_out pc

const proj_0_X 2573
const proj_0_Y 2574
const proj_1_X 2575
const proj_1_Y 2576
const proj_2_X 2577
const proj_2_Y 2578
const proj_3_X 2579
const proj_3_Y 2580
const proj_4_X 2581
const proj_4_Y 2582
const proj_5_X 2583
const proj_5_Y 2584
const proj_6_X 2585
const proj_6_Y 2586
const proj_7_X 2587
const proj_7_Y 2588

const project_currentVertex 2589
const project_Exit 2590
mark project
    set r_addr project_currentVertex
    copy r_out w_val
    set w_addr projectVertex_VertexNumber
    pulse write

    set w_addr projectVertex_Exit
    set w_val project_projectVertex_Exit1
    pulse write

    set pc projectVertex

    mark project_projectVertex_Exit1

    set r_addr project_currentVertex
    copy r_out alu_a
    set alu_b 2
    set alu_op MUL
    copy alu_out alu_a
    set r_addr proj_0_X
    copy r_out alu_b
    set alu_op ADD

    copy alu_out w_addr
    set r_addr projectVertex_X
    copy r_out w_val
    pulse write

    copy alu_out alu_a
    set alu_b 1
    set alu_op ADD

    copy alu_out w_addr
    set r_addr projectVertex_Y
    copy r_out w_val
    pulse write

    set r_addr project_currentVertex
    copy r_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out w_val
    set w_addr project_currentVertex
    pulse write

    set r_addr project_currentVertex
    copy r_out pc_value
    set pc_target 8
    set r_addr project_Exit
    copy r_out pc_jmp
    pulse jump

    set pc project