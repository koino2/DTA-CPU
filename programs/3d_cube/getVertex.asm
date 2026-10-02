const getVertex_number 0
const getVertex_X 0
const getVertex_Y 0
const getVertex_Z 0
const getVertexReturnNumber 0
const getVertex_Exit 0
mark getVertex
    set w_addr getVertexReturnNumber
    set w_val 0
    pulse write

    set r_addr getVertex_number
    copy r_out pc_value

    set w_addr getVertex_X

    set pc_target 0
    set pc_jmp cube_0_X
    pulse jump
    set pc_target 1
    set pc_jmp cube_1_X
    pulse jump
    set pc_target 2
    set pc_jmp cube_2_X
    pulse jump
    set pc_target 3
    set pc_jmp cube_3_X
    pulse jump
    set pc_target 4
    set pc_jmp cube_4_X
    pulse jump
    set pc_target 5
    set pc_jmp cube_5_X
    pulse jump
    set pc_target 6
    set pc_jmp cube_6_X
    pulse jump
    set pc_target 7
    set pc_jmp cube_7_X
    pulse jump

    mark getVertexReturn0

    set w_addr getVertexReturnNumber
    set w_val 1
    pulse write

    set w_addr getVertex_Y

    set pc_target 0
    set pc_jmp cube_0_Y
    pulse jump
    set pc_target 1
    set pc_jmp cube_1_Y
    pulse jump
    set pc_target 2
    set pc_jmp cube_2_Y
    pulse jump
    set pc_target 3
    set pc_jmp cube_3_Y
    pulse jump
    set pc_target 4
    set pc_jmp cube_4_Y
    pulse jump
    set pc_target 5
    set pc_jmp cube_5_Y
    pulse jump
    set pc_target 6
    set pc_jmp cube_6_Y
    pulse jump
    set pc_target 7
    set pc_jmp cube_7_Y
    pulse jump

    mark getVertexReturn1

    set w_addr getVertexReturnNumber
    set w_val 2
    pulse write

    set w_addr getVertex_Z

    set pc_target 0
    set pc_jmp cube_0_Z
    pulse jump
    set pc_target 1
    set pc_jmp cube_1_Z
    pulse jump
    set pc_target 2
    set pc_jmp cube_2_Z
    pulse jump
    set pc_target 3
    set pc_jmp cube_3_Z
    pulse jump
    set pc_target 4
    set pc_jmp cube_4_Z
    pulse jump
    set pc_target 5
    set pc_jmp cube_5_Z
    pulse jump
    set pc_target 6
    set pc_jmp cube_6_Z
    pulse jump
    set pc_target 7
    set pc_jmp cube_7_Z
    pulse jump

    mark getVertexReturn2

    set r_addr getVertex_Exit
    copy r_out pc

mark getVertexReturn
    set r_addr getVertexReturnNumber
    copy r_out pc_value
    set pc_target 0
    set pc_jmp getVertexReturn0
    pulse jump
    set pc_target 1
    set pc_jmp getVertexReturn1
    pulse jump
    set pc_target 2
    set pc_jmp getVertexReturn2
    pulse jump