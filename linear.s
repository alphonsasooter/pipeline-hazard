.data
array:      .word 5, 3, 8, 2, 9, 1   # sample array
n:          .word 6                  # size of array
key:        .word 2                  # element to search

.text
.globl main

main:
    la x10, array      # x10 = base address of array
    lw x11, n          # x11 = number of elements
    lw x12, key        # x12 = key to search

    li x13, 0          # x13 = index i = 0

loop:
    beq x13, x11, not_found   # if i == n → not found

    slli x14, x13, 2          # offset = i * 4
    add x15, x10, x14         # address of array[i]

    lw x16, 0(x15)            # load array[i]

    # 🔥 Load-Use Hazard here
    beq x16, x12, found       # immediately using loaded value

    addi x13, x13, 1          # i++
    j loop

found:
    # x13 contains index of found element
    li x17, 1                 # success flag
    j end

not_found:
    li x17, 0                 # failure flag

end:
    # Program ends here
    nop
