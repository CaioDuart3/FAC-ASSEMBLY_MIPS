    # * ler inteiro i
    li, $v0, 5 
    syscall
    move $t0, $v0 

    mul $t0, $t0, 4  # multiplica o i pela quantidade de bytes do endereço
    add $t1, $s0, $t0  # soma o i em bytes para achar o endereço de A[i]
    lw $t0, 0($t1) #passa o valor do endereço de A[i]

    # * ler inteiro j
    
    li, $v0, 5 
    syscall
    move $t2, $v0

    mul $t2, $t2, 4
    add $t3, $s0, $t2 
    lw $t2, 0($t3)

    # * ler inteiro N
    li, $v0, 5 #N
    syscall
    move $t4, $v0


    # * soma resultado 
    add $t0, $t2, $t4 # A[i] = A[j] + N 


    # * armazena o valor da soma no endereço
    sw $t0, 0($t1)
