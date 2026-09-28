nop
set pc main

# 512 - 532 -> return addresses
#

mark return
    set r_addr 512
    copy r_out pc

mark function
    # do things
    set pc return

mark main
    set w_addr 512
    copy pc w_val
    write
    set pc function