nop
set pc main

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

const A1 2602
const A2 2603
const A3 2604
const A4 2605
const A5 2606
const A6 2607
const A7 2608
const A8 2609
const A9 2610
const A10 2611
const A11 2612
const A12 2613

const B1 2614
const B2 2615
const B3 2616
const B4 2617
const B5 2618
const B6 2619
const B7 2620
const B8 2621
const B9 2622
const B10 2623
const B11 2624
const B12 2625

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

mark loop
    pulse dsc_p1

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

    set w_addr drawLines_Number
    set w_val 0
    pulse write

    set pc drawLines

    mark loop_lineDrawer_Exit

    pulse dsc_p2

    set pc loop

mark main
    set dsc_device 0
    set w_addr initLines_Exit
    set w_val main_initLines_exit
    pulse write

    set pc initLines

    mark main_initLines_exit

    set w_addr focalLength
    set w_val 70
    pulse write

    set w_addr project_Exit
    set w_val loop_project_Exit
    pulse write

    set w_addr drawLine_Exit
    set w_val drawLines_drawLine_Exit
    pulse write

    set w_addr drawLines_Exit
    set w_val loop_lineDrawer_Exit
    pulse write

    set pc loop