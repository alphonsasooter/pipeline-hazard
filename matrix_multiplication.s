.text
.globl main
main:
    li x10, 5
    li x11, 3

    blt x10, x11, less   # ?? CONTROL HAZARD

    addi x12, x0, 1
    j end

less:
    addi x12, x0, 2
next
end:
    nop
