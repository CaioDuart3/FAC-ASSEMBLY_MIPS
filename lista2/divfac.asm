# *passo1: dividendo em R[31...0]
# *passo2: R << 1
# *passo3: R[63...32] = R[63...32] - divisor
# *passo4: 
#todo         4.1: se R >=0, R << 1 e R++
#todo         4.2: se R < 0, R[63...32] = R[63...32] + divisor e R << 1
# *passo5: se não rodou 31 vezes, volte para o passo 3 
# *passo6: R[63...31] >> 1

.text
main:
    #lê o dividendo (numerador)
    li $v0, 5
    syscall
    move $a0, $v0

    #lê o divisor (denominador)
    li $v0, 5
    syscall
    move $a1, $v0

    #chama a função que realiza o algoritimo de divisão
    jal divfac

#após a chamada da função realiza a impressão para testes:
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
        #se o dividendo < 0, t0=1
        slt $t0, $a0, $zero 
        #se o numerador < 0, t1=1
        slt $t1, $a1, $zero 

        #se dividendo>0, verifica o outro numero
        beq $t0, $zero, verificarD
        #se dividendo<0, torna-o positivo
        nor $a0, $a0, $zero
        addi $a0, $a0, 1
    
    verificarD:
        #se divisor>0, inicia a lógica
        beq $t1, $zero, passo1
        #se divisor<0, torna-o positivo
        nor $a1, $a1, $zero
        addi $a1, $a1, 1

    passo1: 
        # contador
        li $t9, 32
        move $s1, $zero #R[63...32] =0
        move $s0, $a0 #R[31...0] = dividendo

    passo2:
        #move R[63...0] << 1, logo R << 1
        sll $s0, $s0, 1
        sll $s1, $s1, 1 

    passo3:
        #R[63...32] = R[63...32] - divisor
        sub $s1, $s1, $a1

    passo4:
        #se R < 0, t3 = 0
        slt $t3, $s1, $zero
        # se t3 = 1, realiza passo 4.2, pois R<0
        bne $t3, $zero, passo4_2
        # se t3 = 0, realiza passo 4.1, pois R>=0

        # *passo4.1
        #lógica para verifica e realizar a troca de 1 de lo para hi
        li $t5, 1
        sll $t5, $t5, 31
        and $t5, $s0, $t5
        #faz o deslocamento R<<1 para realizar a troca corretamente
        sll $s0, $s0, 1
        sll $s1, $s1, 1
        srl $t5, $t5, 31
        add $s1, $s1, $t5

        # R[0] = 1 
        addi $s0, $s0, 1
        j passo5

    passo4_2:
        # R[63...32] = R[63...32] + divisor
        add $s1, $s1, $a1

        # R << 1
        #lógica para verifica e realizar a troca de 1 de lo para hi
        li $t5, 1
        sll $t5, $t5, 31
        and $t5, $s0, $t5
        sll $s0, $s0, 1
        sll $s1, $s1, 1 
        srl $t5, $t5, 31 
        add $s1, $s1, $t5

        j passo5

    passo5:
        addi $t9, $t9, -1 #contador --, se contador > 0, volte para o passo 3
        beq $t9, $zero, passo6
        j passo3

    passo6:
        # R[63...32] >> 1
        srl $s1, $s1, 1
        j verificarSinal

    verificarSinal:
        # se os sinais são diferentes, negativa o quociente
        bne $t1, $t0, negativarQuociente
        # se dividendo < 0, negativa resto
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
