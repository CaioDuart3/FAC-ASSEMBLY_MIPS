.data 
    d273: .float  273.15
    i32: .float 32.0
    d0_55: .float 0.5555555
    d1_8: .float 1.8000

.text
main:
    li $v0, 12 
    syscall
    move $t0, $v0

    buffer1: 
        li $v0, 12
        syscall
        beqz $v0, buffer1
        bne $v0, 10, buffer1
    
    li $v0, 12
    syscall
    move $t1, $v0

    buffer2:
        li $v0, 12
        syscall
        beqz $v0, buffer2
        bne $v0, 10, buffer2

    li $v0, 6
    syscall

    lwc1 $f1, d273
    lwc1 $f2, i32
    lwc1 $f3, d0_55
    lwc1 $f4, d1_8

    li $t2, 'C'
    li $t3, 'K'
    li $t4, 'F'

    beq $t0, $t2, celsius
    beq $t0, $t3, kelvin 
    beq $t0, $t4, fahrenheit

    celsius:
        beq $t1, $t3, c_p_k
        beq $t1, $t4, c_p_f

    kelvin:
        beq $t1, $t2,  k_p_c
        beq $t1, $t4,  k_p_f

    fahrenheit:
        beq $t1, $t2,  f_p_c
        beq $t1, $t3,  f_p_k

    c_p_k:
        add.s $f12, $f1, $f0
        j exit
    c_p_f:
        mul.s $f12, $f4 ,$f0
        add.s $f12, $f12, $f2
        j exit

    k_p_c:
        sub.s $f12, $f0, $f1
        j exit
    k_p_f:
        sub.s $f12, $f0, $f1
        mul.s $f12, $f12, $f4
        add.s $f12, $f12, $f2
        j exit

    f_p_c:
        sub.s $f12, $f0, $f2
        mul.s $f12, $f12,$f3
        j exit
    f_p_k:
        sub.s $f12, $f0, $f2
        mul.s $f12, $f12,$f3
        add.s $f12, $f12, $f1
        j exit

    exit:
        li, $v0, 2
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall








#$f0 - leitura
#$f12 - imprimir


