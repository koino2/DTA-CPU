const focalLength 0
const projectVertex_VertexX 0
const projectVertex_VertexY 0
const projectVertex_VertexZ 0
const projectVertex_X 0
const projectVertex_Y 0
const projectVertex_temp1 0
const projectVertex_Exit 0
mark projectVertex

    # projectedX = ( X * FocalLength ) / ( Z + FocalLength )

    set r_addr projectVertex_VertexX
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr projectVertex_temp1
    pulse write

    set r_addr projectVertex_VertexZ
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

    set r_addr projectVertex_VertexY
    copy r_out alu_a
    set r_addr focalLength
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr projectVertex_temp1
    pulse write

    set r_addr projectVertex_VertexZ
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

const project_currentVertex 0
const project_Exit 0
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