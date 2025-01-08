# *passo1: Inicialize com P[63 . . . 32] = 0, P[31 . . . 0] = Q
# *passo2: Se P[0] = 1, P[63 . . . 32] + = M
# *passo3: P >> 1
# *passo4: Se não exceder 32 iterações, volte ao passo 2.

#sistema que opera com signed positivo.

.text
main:
    #lê M
    li $v0,5
    syscall
    move $a0, $v0
    #lê Q
    li $v0,5
    syscall
    move $a1, $v0

    #chamada da função que inicia o algoritimo de multiplicação
    jal multfac

#após o retorno da função é realizado a impressão do resultado para testes:
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

        li $t9, 32 # contador 
        slt $t0, $a0, $zero  # M < 0
        slt $t1, $a1, $zero # Q < 0

        # se M>0, t0 = 0
        beq $t0, $zero, verificarM
        # se M<0, transforma em positivo
        nor $a0, $a0, $zero
        addi $a0,$a0, 1

    verificarM:
        # se Q>0, t1 = 0
        beq $t1, $zero, passo1
        # se Q<0, transforma em positivo
        nor $a1, $a1, $zero
        addi $a1,$a1, 1
    
    passo1: 
        move $s0, $zero # P[64...32] = Q
        move $s1, $a1 #P[31...0] = 0

    passo2:
        # extrai P[0]
        andi $t3, $s1, 1 
        # verifica se P[0] = 1, se sim, ele pula beq e soma, se não, pula pra P >> 1
        beq $t3, $zero, passo3
        # como P[0] = 1, P[63 . . . 32] + = M
        add $s0, $s0, $a0

    passo3:
        # lógica que verifica se o bit de hi vai pra lo, e faz a troca
        andi $t2, $s0, 1 
        srl $s1, $s1, 1 
        srl $s0, $s0, 1

        sll $t2, $t2, 31
        add $s1, $s1, $t2 

        # fim do passo 3
        addi $t9, $t9, -1  #contador--
        beq $t9, $zero, verificarSinal
        # passo4: Se não exceder 32 iterações, volte ao passo 2.
        j passo2

    verificarSinal: 
        #troca o sinal do produto caso necessário
        beq $t0, $t1, fim 
        nor $s0, $s0, $zero 
        nor $s1, $s1, $zero
        addi $s1, $s1, 1
    
    fim: 
        #armazena o produto em hi e lo
        mthi $s0
        mtlo $s1
        jr $ra
