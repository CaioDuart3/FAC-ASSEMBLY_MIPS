.data

.text
main:
    # * ler a
    li $v0, 5
    syscall 
    move $t0, $v0 

    # * ler b
    li $v0, 5
    syscall
    move $t1, $v0

    # * c=a-b
    sub $a0, $t0, $t1

    # * imprime c
    li $v0, 1
    syscall

    # * encerra programa
    li $v0 , 10
    syscall

    
