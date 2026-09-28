nop
set pc, main

# DATA

# Original vertex coordinates
# 512 - 519   X
# 520 - 527   Y
# 528 - 535   Z

# Rotation / transformation data
# 540 - 551   A
# 552 - 563   B
# 564         X rot
# 565         Y rot
# 566         Z rot

# Rotated coordinates
# 567 - 574   rX
# 575 - 582   rY
# 583 - 590   rZ

# Projected coordinates
# 591 - 598   pX
# 599 - 606   pY

# scratch 607 - 620
# 607 rotation loop 'x' index
# 608 projection address
# 609 projection numerator

# Line drawing state
# 621         line X
# 622         line Y

mark rotate
set w_addr 607
set w_val 512

mark project
set w_addr 608
set w_Val 512
pulse write
mark projectionLoop
    set r_addr 608
    copy r_out alu_a
    set alu_b

mark main