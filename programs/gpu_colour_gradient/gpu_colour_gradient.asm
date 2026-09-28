    nop 0 0
mark pixel
    set dsc_d0 1
    SET R_ADDR 512
    COPY R_OUT DSC_D1
    SET R_ADDR 513
    COPY R_OUT DSC_D2

    # red
    set r_addr 514
    copy r_out dsc_d3

    # green
    set r_addr 515
    copy r_out dsc_d4

    # blue
    set dsc_d5 128

    pulse dsc_p0

    set pc loop

mark loop
    set r_addr 512
    copy r_out alu_a
    set alu_b 1
    set alu_op 0
    copy alu_out w_val
    set w_addr 512
    pulse write

    copy alu_out pc_value
    set pc_target 64
    set pc_jmp y_increment
    pulse jump
mark y_increment_return

    set r_addr 512
    copy r_out alu_a
    set alu_b 4
    set alu_op mul
    copy alu_out w_val
    set w_addr 514
    pulse write

    set r_addr 513
    copy r_out alu_a
    set alu_b 4
    set alu_op mul
    copy alu_out w_val
    set w_addr 515
    pulse write

    set pc pixel

mark y_increment
    set w_addr 512
    set w_val 0
    pulse write

    set r_addr 513
    copy r_out alu_a
    set alu_b 1
    set alu_op add
    copy alu_out w_val
    set w_addr 513
    pulse write

    set r_addr 513
    copy r_out pc_value
    set pc_target 64
    set pc_jmp exit
    pulse jump

    set pc y_increment_return

mark exit
    nop
    set pc exit