mark cube_0_X
    set w_val -20
    set pc getVertexReturn
mark cube_0_Y
    set w_val -20
    set pc getVertexReturn
mark cube_0_Z
    set w_val -20
    set pc getVertexReturn

mark cube_1_X
    set w_val 20
    set pc getVertexReturn
mark cube_1_Y
    set w_val -20
    set pc getVertexReturn
mark cube_1_Z
    set w_val -20
    set pc getVertexReturn

mark cube_2_X
    set w_val -20
    set pc getVertexReturn
mark cube_2_Y
    set w_val 20
    set pc getVertexReturn
mark cube_2_Z
    set w_val -20
    set pc getVertexReturn

mark cube_3_X
    set w_val 20
    set pc getVertexReturn
mark cube_3_Y
    set w_val 20
    set pc getVertexReturn
mark cube_3_Z
    set w_val -20
    set pc getVertexReturn

mark cube_4_X
    set w_val -20
    set pc getVertexReturn
mark cube_4_Y
    set w_val -20
    set pc getVertexReturn
mark cube_4_Z
    set w_val 20
    set pc getVertexReturn

mark cube_5_X
    set w_val 20
    set pc getVertexReturn
mark cube_5_Y
    set w_val -20
    set pc getVertexReturn
mark cube_5_Z
    set w_val 20
    set pc getVertexReturn

mark cube_6_X
    set w_val -20
    set pc getVertexReturn
mark cube_6_Y
    set w_val 20
    set pc getVertexReturn
mark cube_6_Z
    set w_val 20
    set pc getVertexReturn

mark cube_7_X
    set w_val 20
    set pc getVertexReturn
mark cube_7_Y
    set w_val 20
    set pc getVertexReturn
mark cube_7_Z
    set w_val 20
    set pc getVertexReturn

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
const orgSine = 517
mark get_sin
    set r_addr sin

    set w_addr orgSine
    copy r_out w_val
    pulse write

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
    pulse jump

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

    set r_addr orgSine
    copy r_out alu_a
    set alu_b 18
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 2
    set pc_jmp sin_comp2out
    pulse jump

    set r_addr sin90Out
    copy r_out alu_a
    set alu_b -1
    set alu_op MUL
    copy alu_out w_val
    set w_addr sin90Out
    pulse write

    mark sin_comp2out

    set r_addr sin90Out
    copy r_out w_val
    set w_addr sinOut
    pulse write

    set r_addr sinExit
    copy r_out pc

const sinExit 518

const rot_0_X 519
const rot_0_Y 520
const rot_0_Z 521

const rot_1_X 522
const rot_1_Y 523
const rot_1_Z 524

const rot_2_X 525
const rot_2_Y 526
const rot_2_Z 527

const rot_3_X 528
const rot_3_Y 529
const rot_3_Z 530

const rot_4_X 531
const rot_4_Y 532
const rot_4_Z 533

const rot_5_X 534
const rot_5_Y 535
const rot_5_Z 536

const rot_6_X 537
const rot_6_Y 538
const rot_6_Z 539

const rot_7_X 540
const rot_7_Y 541
const rot_7_Z 542

const rotX 543
const rotY 544
const rotZ 545

const rotateVertex_SinTheta 546 # value
const rotateVertex_CosTheta 547 # value
const rotateVertex_X 548 # value
const rotateVertex_Y 549 # value
const rotateVertex_Z 550 # value
const rotateVertex_SaveX 551 # address
const rotateVertex_SaveY 552 # address
const rotateVertex_SaveZ 553 # address
const rotateVertex_temp1 554 # address
const rotateVertex_return 555
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
    set w_addr rotateVertex_SaveX
    pulse write

    set r_addr rotateVertex_Y
    copy r_out w_val
    set w_addr rotateVertex_SaveY
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
    set w_addr rotateVertex_SaveZ
    pulse write

    set r_addr rotateVertex_return
    copy r_out pc

const getVertex_number 556
const getVertex_X 557
const getVertex_Y 558
const getVertex_Z 559
const getVertexReturnNumber 560
const getVertex_Exit 561
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

const rotate_currentVertex = 556
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

const getRotatedVertex_Number 562
const getRotatedVertex_X 563
const getRotatedVertex_Y 564
const getRotatedVertex_Z 565
const getRotatedVertex_Exit 566
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

const focalLength = 567

const projectVertex_VertexNumber 568
const projectVertex_X 569
const projectVertex_Y 570
const projectVertex_temp1 571
const projectVertex_Exit 572
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
    copy alu_out w_addr
    set w_val projectVertex_Y
    pulse write

    set r_addr projectVertex_Exit
    copy r_out pc

const proj_0_X 573
const proj_0_Y 574
const proj_1_X 575
const proj_1_Y 576
const proj_2_X 577
const proj_2_Y 578
const proj_3_X 579
const proj_3_Y 580
const proj_4_X 581
const proj_4_Y 582
const proj_5_X 583
const proj_5_Y 584
const proj_6_X 585
const proj_6_Y 586
const proj_7_X 587
const proj_7_Y 588

const project_currentVertex 589
const project_Exit 590
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

    copy alu_out w_val
    set r_addr projectVertex_Y
    copy r_out w_addr
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

const drawLine_x0 591
const drawLine_y0 592
const drawLine_x1 593
const drawLine_y1 594
const drawLine_dx 595
const drawLine_dy 596
const drawLine_sx 597
const drawLine_sy 598
const drawLine_err 599
const drawLine_e2 600
const drawLine_Exit 601
mark drawLine
    set r_addr drawLine_x1
    copy r_out alu_a
    set r_addr drawLine_x0
    copy r_out alu_b
    set alu_op SUB
    copy alu_out alu_a
    set alu_b -1
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 1
    set pc_jmp drawLine_dx_init_plus
    set alu_op MUL
    mark drawLine_dx_init_plus
    copy alu_out w_val
    set w_addr drawLine_dx
    pulse write

    set r_addr drawLine_y1
    copy r_out alu_a
    set r_addr drawLine_y0
    copy r_out alu_b
    set alu_op SUB
    copy alu_out alu_a
    set alu_b -1
    set alu_op COMP
    copy alu_out pc_value
    set pc_target 1
    set pc_jmp drawLine_dy_init_plus
    set alu_op MUL
    mark drawLine_dy_init_plus
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
        copy r_out pc_value
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
        copy r_out pc_value
        set pc_target 1
        set pc_jmp drawLine_loop_condition1fail
        pulse jump
        set pc_target 2
        set pc_jmp drawLine_loop_condition1fail
        pulse jump

        set pc drawLine_Exit

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
        copy alu_out alu_b
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

mark drawLines


mark loop
    set r_addr rotY
    copy r_out alu_a
    set alu_b 1
    set alu_op ADD
    copy alu_out alu_a
    set alu_b 36
    set alu_op MOD
    copy alu_out w_val
    set w_addr rotY
    pulse write

    set w_addr rotate_currentVertex
    set w_val 0
    pulse write

    set w_addr project_currentVertex
    set w_val 0
    pulse write

    set pc rotate

    mark loop_project_Exit

    # todo: line drawing here!!!!

    set pc lineDrawer

    mark loop_lineDrawer_Exit

    set pc loop

mark main
    set w_addr project_Exit
    set w_val loop_project_Exit
    pulse write