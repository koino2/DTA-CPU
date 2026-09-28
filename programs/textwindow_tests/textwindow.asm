nop
set pc main

# functions
mark return
    set r_addr 512
    copy r_out pc

mark char
    nop
    set dsc_device 0
    set dsc_d0 1
    set dsc_d1 0
    set dsc_d2 0
    set dsc_d3 97
    pulse dsc_p0
    set pc return

mark main
    set w_addr 512
    copy pc w_val
    write
    set pc char