.data
.text
main:

    # * ler N
    li $v0, 5 
    syscall
    move $a0, $v0 # encaixa no arguments do procedimento

    # * chama a função contaBits
    jal contaBits 

    move $a0, $v0
    li $v0,1 
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 10
    syscall

contaBits:
    # passa pra $t0 o arguments
    move $t0, $a0 
    # * contador de 1s:
    li $t2, 0 

    loop:
        # * se o N != continua   (N é decrementado a cada iteração com srl até virar 0)
        beq $t0, $zero, saida

        # * multiplica bit a bit do numero, todos zeram, menos o primeiro bit, resultando no menos significativo em $t1, sendo ele 0 ou 1
        andi $t1, $t0, 1

        # * se o bit for != 0, logo é 1 e conta.
        bne $t1, $zero, contador 

        # * passa os bits de N para direita de 1 em 1, reduzindo-o a zero quando o loop acabar
        srl $t0, $t0, 1 #10

        j loop

contador:
    # * contador++
    addi $t2, $t2, 1
    # passa os bits de N para direita de 1 em 1
    srl $t0, $t0, 1
    #volta o loop
    j loop

saida:
    # * conforme o solicitado pela atividade $v0 = contador
    move $v0, $t2
    # * volta pra main
    jr $ra