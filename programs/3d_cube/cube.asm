const cube_0_X -20
const cube_0_Y -20
const cube_0_Z -20

const cube_1_X 20
const cube_1_Y -20
const cube_1_Z -20

const cube_2_X -20
const cube_2_Y 20
const cube_2_Z -20

const cube_3_X 20
const cube_3_Y 20
const cube_3_Z -20

const cube_4_X -20
const cube_4_Y -20
const cube_4_Z 20

const cube_5_X 20
const cube_5_Y -20
const cube_5_Z 20

const cube_6_X -20
const cube_6_Y 20
const cube_6_Z 20

const cube_7_X 20
const cube_7_Y 20
const cube_7_Z 20

const focalLength = 70

const constSin0    0
const constSin10  22
const constSin20  43
const constSin30  64
const constSin40  82
const constSin50  97
const constSin60 110
const constSin70 119
const constSin80 125
const constSin90 127

mark sin0
    set w_val constSin0
    set pc return_sine
mark sin1
    set w_val constSin10
    set pc return_sine
mark sin2
    set w_val constSin20
    set pc return_sine
mark sin3
    set w_val constSin30
    set pc return_sine
mark sin4
    set w_val constSin40
    set pc return_sine
mark sin5
    set w_val constSin50
    set pc return_sine
mark sin6
    set w_val constSin60
    set pc return_sine
mark sin7
    set w_val constSin70
    set pc return_sine
mark sin8
    set w_val constSin80
    set pc return_sine
mark sin9
    set w_val constSin90
    set pc return_sine

const sinAddress = 512
const sin90Out = 513

mark get_sin90
    set r_addr sinAddress
    copy r_out pc_value

    set w_addr sin90Out

    set pc_target 0
    set pc_jmp sin0
    pulse jump
    set pc_target 1
    set pc_jmp sin1
    pulse jump
    set pc_target 2
    set pc_jmp sin2
    pulse jump
    set pc_target 3
    set pc_jmp sin3
    pulse jump
    set pc_target 4
    set pc_jmp sin4
    pulse jump
    set pc_target 5
    set pc_jmp sin5
    pulse jump
    set pc_target 6
    set pc_jmp sin6
    pulse jump
    set pc_target 7
    set pc_jmp sin7
    pulse jump
    set pc_target 8
    set pc_jmp sin8
    pulse jump
    set pc_target 9
    set pc_jmp sin9
    pulse jump

    mark return_sine

    pulse write

    set pc sine90Return

const sin 514
const sinOut 515
const sinHalf = 516
mark get_sin
    set r_addr sin
    copy r_out alu_a
    set alu_b 18
    set alu_op MOD
    copy alu_out w_val
    set w_addr sinHalf
    pulse write

    copy alu_out alu_a
    set alu_b 9
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 1
    set pc_jmp sinCase1

    set r_addr sinHalf
    copy r_out w_val
    set w_addr sinAddress
    pulse write
    set pc sinCaseReturn

    mark sinCase1
    set r_addr sinHalf
    copy r_out alu_b
    set alu_a 18
    set alu_op SUB
    copy alu_out w_val
    set w_addr sinAddress
    pulse write

    mark sinCaseReturn

    set pc get_sin90

    mark sine90Return

    set r_addr sin90Out
    copy r_out alu_a
    set alu_b 18
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 2
    set pc_jmp sin_comp2out

    set alu_b -1
    set alu_op MUL
    copy alu_out w_val
    set w_addr sin90Out
    pulse write

    mark sin_comp2out

    copy r_out w_val
    set w_addr sinOut
    pulse write

    set pc sinExit