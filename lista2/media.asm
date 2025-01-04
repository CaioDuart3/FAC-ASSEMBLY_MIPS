.text
main:
    li $v0, 5
    syscall
    move $t0, $v0
    li $t1, 0

    mtc1 $zero, $f10
    mtc1 $zero, $f11

    loop: 
        beq $t1, $t0, fim
        
        li $v0, 6
        syscall
        add.s $f10, $f10, $f0 #denominador
        mov.s $f1, $f0  #peso

        li $v0, 6
        syscall
        mul.s $f2, $f1, $f0  #peso*numero
        add.s $f11, $f11, $f2 #soma numerador

        addi $t1, $t1, 1
        j loop
    fim:
        div.s $f12, $f11, $f10
        li $v0,2
        syscall