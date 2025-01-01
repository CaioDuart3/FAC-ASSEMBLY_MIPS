.text
main:
    li $v0, 5
    syscall
    move $a0, $v0

    li $v0, 5
    syscall
    move $a1, $v0

    jal divfac

mfhi $a1
mflo $a0

li $v0, 1
syscall

li $v0, 11
li $a0, 10
syscall

li $v0, 1
move $a0, $a1
syscall

li $v0, 11
li $a0, 10
syscall

li $v0,10
syscall

    divfac:
        slt $t0, $a0, $zero 
        slt $t1, $a1, $zero 

        beq $t0, $zero, verificarD
        nor $a0, $a0, $zero
        addi $a0, $a0, 1
    
    verificarD:
        beq $t1, $zero, passo1
        nor $a1, $a1, $zero
        addi $a1, $a1, 1

    passo1: 
        li $t9, 32
        move $s1, $zero
        move $s0, $a0 

    passo2:
        sll $s0, $s0, 1
        sll $s1, $s1, 1 

    passo3:
        sub $s1, $s1, $a1

    passo4:
        slt $t3, $s1, $zero
        bne $t3, $zero, passo4_1

        li $t5, 1
        sll $t5, $t5, 31
        and $t5, $s0, $t5
        sll $s0, $s0, 1
        sll $s1, $s1, 1
        srl $t5, $t5, 31 
        add $s1, $s1, $t5

        addi $s0, $s0, 1
        j passo5

    passo4_1:
        add $s1, $s1, $a1

        li $t5, 1
        sll $t5, $t5, 31
        and $t5, $s0, $t5
        sll $s0, $s0, 1
        sll $s1, $s1, 1 
        srl $t5, $t5, 31 
        add $s1, $s1, $t5

        j passo5

    passo5:
        addi $t9, $t9, -1
        beq $t9, $zero, passo6
        j passo3

    passo6:
        srl $s1, $s1, 1
        j verificarSinal

    verificarSinal:
        bne $t1, $t0, negativarQuociente
        bne $t0, $zero, negativarResto
        j fim

    negativarQuociente: 
        nor $s0, $s0, $zero
        addi $s0, $s0, 1
        bne $t0, $zero, negativarResto
        j fim

    negativarResto: 
        nor $s1, $s1, $zero
        addi $s1, $s1, 1
        j fim

    fim:
        mthi $s1
        mtlo $s0
        jr $ra
