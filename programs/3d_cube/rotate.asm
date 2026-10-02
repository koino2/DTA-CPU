const rot_0_X 0
const rot_0_Y 0
const rot_0_Z 0

const rot_1_X 0
const rot_1_Y 0
const rot_1_Z 0

const rot_2_X 0
const rot_2_Y 0
const rot_2_Z 0

const rot_3_X 0
const rot_3_Y 0
const rot_3_Z 0

const rot_4_X 0
const rot_4_Y 0
const rot_4_Z 0

const rot_5_X 0
const rot_5_Y 0
const rot_5_Z 0

const rot_6_X 0
const rot_6_Y 0
const rot_6_Z 0

const rot_7_X 0
const rot_7_Y 0
const rot_7_Z 0

const rotX 0
const rotY 0
const rotZ 0

const rotateVertex_SinTheta 0 # value
const rotateVertex_CosTheta 0 # value
const rotateVertex_X 0 # value
const rotateVertex_Y 0 # value
const rotateVertex_Z 0 # value
const rotateVertex_SaveX 0 # address
const rotateVertex_SaveY 0 # address
const rotateVertex_SaveZ 0 # address
const rotateVertex_temp1 0 # address
const rotateVertex_return 0
mark rotateVertex
    set r_addr rotateVertex_X
    copy r_out alu_a
    set r_addr rotateVertex_CosTheta
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr rotateVertex_temp1
    pulse write

    set r_addr rotateVertex_Z
    copy r_out alu_a
    set r_addr rotateVertex_SinTheta
    copy r_out alu_b
    set alu_op MUL
    copy alu_out alu_b

    set r_addr rotateVertex_temp1
    copy r_out alu_a
    set alu_op ADD

    copy alu_out alu_a
    set alu_b 127
    set alu_op DIV
    copy alu_out w_val
    set r_addr rotateVertex_SaveX
    copy r_out w_addr
    pulse write

    set r_addr rotateVertex_Y
    copy r_out w_val
    set r_addr rotateVertex_SaveY
    copy r_out w_addr
    pulse write

    set r_addr rotateVertex_X
    copy r_out alu_a
    set alu_b -1
    set alu_op MUL
    copy alu_out alu_a
    set r_addr rotateVertex_SinTheta
    copy r_out alu_b
    set alu_op MUL
    copy alu_out w_val
    set w_addr rotateVertex_temp1
    pulse write

    set r_addr rotateVertex_Z
    copy r_out alu_a
    set r_addr rotateVertex_CosTheta
    copy r_out alu_b
    set alu_op MUL
    copy alu_out alu_b

    set r_addr rotateVertex_temp1
    copy r_out alu_a
    set alu_op ADD

    copy alu_out alu_a
    set alu_b 127
    set alu_op DIV
    copy alu_out w_val
    set r_addr rotateVertex_SaveZ
    copy r_out w_addr
    pulse write

    set r_addr rotateVertex_return
    copy r_out pc

const rotate_currentVertex 2557
mark rotate
#    set r_addr rotate_currentVertex
#    copy r_out alu_a
#    set alu_b 3
#    set alu_op MUL
#    copy alu_out alu_a
#    set alu_b cube_0_X
#    set alu_op ADD
#    copy alu_out r_addr
#    copy r_out rotateVertex_X
#
#    copy alu_out alu_a
#    set alu_b 1
#    copy alu_out r_addr
#    copy r_out rotateVertex_Y
#
#    copy alu_out alu_a
#    set alu_b 1
#    copy alu_out r_addr
#    copy r_out rotateVertex_Z

    set w_addr getVertex_Exit
    set w_val getVertex_Exit1
    pulse write

    set r_addr rotate_currentVertex
    copy r_out w_val
    set w_addr getVertex_number
    pulse write

    set pc, getVertex

    mark getVertex_Exit1

    set r_addr getVertex_X
    copy r_out w_val
    set w_addr rotateVertex_X
    pulse write

    set r_addr getVertex_Y
    copy r_out w_val
    set w_addr rotateVertex_Y
    pulse write

    set r_addr getVertex_Z
    copy r_out w_val
    set w_addr rotateVertex_Z
    pulse write

    set r_addr rotate_currentVertex
    copy r_out alu_a
    set alu_b 3
    set alu_op MUL
    copy alu_out alu_a
    set alu_b rot_0_X
    set alu_op ADD
    copy alu_out w_val
    set w_addr rotateVertex_SaveX
    pulse write

    copy alu_out alu_a
    set alu_b 1
    copy alu_out w_val
    set w_addr rotateVertex_SaveY
    pulse write

    copy alu_out alu_a
    set alu_b 1
    copy alu_out w_val
    set w_addr rotateVertex_SaveZ
    pulse write

    set w_addr sin
    set r_addr rotY
    copy r_out w_val
    pulse write

    set w_addr sinExit
    set w_val sinExit1
    pulse write

    set pc, get_sin

    mark sinExit1

    set r_addr sinOut
    copy r_out w_val
    set w_addr rotateVertex_SinTheta
    pulse write

    set r_addr rotY
    copy r_out alu_a
    set alu_b 9
    set alu_op ADD
    copy alu_out alu_a
    set alu_b 36
    set alu_op MOD

    copy alu_out w_val
    set w_addr sin
    pulse write

    set w_addr sinExit
    set w_val sinExit2
    pulse write

    set pc, get_sin

    mark sinExit2

    set r_addr sinOut
    copy r_out w_val
    set w_addr rotateVertex_CosTheta
    pulse write

    set w_addr rotateVertex_return
    set w_val rotateVertex_return1
    pulse write

    set pc rotateVertex

    mark rotateVertex_return1

    set r_addr rotate_currentVertex
    copy r_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out w_val
    set w_addr rotate_currentVertex
    pulse write

    copy alu_out pc_value
    set pc_target 8
    set pc_jmp project
    pulse jump

    set pc rotate

const getRotatedVertex_Number 2562
const getRotatedVertex_X 2563
const getRotatedVertex_Y 2564
const getRotatedVertex_Z 2565
const getRotatedVertex_Exit 2566
mark getRotatedVertex
    set r_addr getRotatedVertex_Number
    copy r_out alu_a
    set alu_b 3
    set alu_op MUL
    copy alu_out alu_a
    set alu_b rot_0_X
    set alu_op ADD
    copy alu_out w_val
    set w_addr getRotatedVertex_X
    pulse write

    copy alu_out alu_a
    set alu_b 1
    copy alu_out w_val
    set w_addr getRotatedVertex_Y
    pulse write

    copy alu_out alu_a
    set alu_b 1
    copy alu_out w_val
    set w_addr getRotatedVertex_Z
    pulse write

    set r_addr getRotatedVertex_Exit
    copy r_out pc