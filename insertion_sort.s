.data
arr: .word 9,4,7,1,3
n:   .word 5

.text
.globl main
main:
    la x10, arr
    lw x11, n

    li x12, 1        # i = 1

outer_loop:
    bge x12, x11, exit   # ?? CONTROL HAZARD

    slli x13, x12, 2
    add x14, x10, x13
    lw x15, 0(x14)       # ?? LOAD

    addi x16, x12, -1    # j = i-1

inner_loop:
    blt x16, x0, insert  # ?? CONTROL HAZARD

    slli x17, x16, 2
    add x18, x10, x17
    lw x19, 0(x18)       # ?? LOAD

    ble x19, x15, insert # ?? LOAD-USE HAZARD

    sw x19, 4(x18)

    addi x16, x16, -1
    j inner_loop

insert:
    slli x17, x16, 2
    add x18, x10, x17
    sw x15, 4(x18)

    addi x12, x12, 1
    j outer_loop

exit:
    nop
