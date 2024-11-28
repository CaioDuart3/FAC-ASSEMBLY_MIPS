.data

.text
main: 
    # * ler N
    li $v0,5 
    syscall
    move $s0, $v0

    loop:
        # * N == 0, sai do loop 
        beq $s0, $zero, saida 

        # * lê o i
        li $v0, 12
        syscall 
        move $t0 , $v0

        # * lê o ' '
        li $v0, 12
        syscall 

        # * lê o j
        li $v0, 12
        syscall 
        move $t1 , $v0

        # * lê o '\n'
        li $v0, 12
        syscall 
        
        # * se i == j : falso
        beq $t0, $t1, imprimeF
        # * se i != j : verdade
        bne $t0, $t1, imprimeV

imprimeF:
    li $v0, 1
    li $a0, 1 # ! 1 para falso
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    addi $s0, $s0, -1 
    j loop

imprimeV:
    li $v0, 1
    li $a0, 2 # ! 2 para verdade
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    addi $s0, $s0, -1 
    j loop

saida:
    li $v0, 10
    syscall

