.data
    msg: .asciiz "overflow"
.text
    main:
        # se for 0, opera sem sinal, se for 1, opera com sinal
        li $v0, 5
        syscall
        move $t0, $v0

        #primeiro inteiro
        li $v0, 5
        syscall
        move $t1, $v0

        #segundo inteiro
        li $v0, 5
        syscall
        move $t2, $v0

        # verifica se os sinais são diferentes
        xor $t3, $t1, $t2
        # se  0>t3, portanto os sinais são diferentes e não há overflow  
        bgt $zero , $t3, diferentes

        j verificarOverflow
        
    diferentes:
        #soma os numeros, tendo sinal ou não dará certo, pois usamos addu
        addu $a0, $t1, $t2
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall

        #se t3>0, então os sinais são iguais
    verificarOverflow:
        # soma os numeros se os sinais são iguais, mesmo que seja unsigned ou não
        addu $a0, $t1, $t2

        #verifica se o resultado e o operador tem sinais diferentes, se sim são diferentes e houve overflow
        xor $t3, $a0, $t1

        # xor < 0, sinais diferentes: overflow
        bgt $zero, $t3, overflow

        #se xor>0, sinais iguais, não houve overflow, e imprime
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall
    
    overflow:
        la $a0,msg
        li $v0, 4
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall