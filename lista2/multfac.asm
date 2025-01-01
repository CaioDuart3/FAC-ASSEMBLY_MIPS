.text
main:
    li $v0,5
    syscall
    move $a0, $v0

    li $v0,5
    syscall
    move $a1, $v0

    jal multfac

    mfhi $a0
    mflo $a1

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

    multfac:

        li $t9, 32
        slt $t0, $a0, $zero
        slt $t1, $a1, $zero


        beq $t0, $zero, verificarM
        nor $a0, $a0, $zero
        addi $a0,$a0, 1

    verificarM:

        beq $t1, $zero, passo1
        nor $a1, $a1, $zero
        addi $a1,$a1, 1

    passo1: 
        move $s0, $zero
        move $s1, $a1

    passo2:
        andi $t3, $s1, 1 
        beq $t3, $zero, passo3
        add $s0, $s0, $a0

    passo3:
        andi $t2, $s0, 1 
        srl $s1, $s1, 1 
        srl $s0, $s0, 1

        sll $t2, $t2, 31
        add $s1, $s1, $t2 

        addi $t9, $t9, -1 
        beq $t9, $zero, verificarSinal
        j passo2

    verificarSinal: 
        beq $t0, $t1, fim 
        nor $s0, $s0, $zero 
        nor $s1, $s1, $zero
        addi $s1, $s1, 1
    
    fim: 
        mthi $s0
        mtlo $s1
        jr $ra
