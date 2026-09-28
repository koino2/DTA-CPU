nop
set pc, main

const functionOperand1 = 512
const functionOutput = 513
const functionReturnAddress = 514
mark function
    # do stuff
    set w_addr, functionOutput
    set w_val, something
    pulse write

    set r_addr, functionReturnAddress
    copy r_out, pc

mark main
    set w_addr, functionOperand1
    set w_val something
    pulse write
    copy pc, functionReturnAddress
    set pc, function
    copy functionOutput, something