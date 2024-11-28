
# ! lógica baseada na fórmula:
# 1- a = bq+r
# 2- r = a-bq

.text
main: 
    # * ler N = a
    li $v0, 5 
    syscall
    move $t0, $v0

    # * ler i
    li $v0, 5 
    syscall
    move $t1, $v0

    # * calcular: 2^î = b
    li $t2, 1
    sll $t2, $t2, $t1

    # * calcular: quociente = q
    srl $t3, $t0, $t1

    # * calcular: bq
    mul $s0, $t2, $t3
    
    # * calcular: a-bq = resto
    sub $s1, $t0, $s0

    # * impressões:
    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 11
    li $a0, 10
    syscall

    li $v0, 10
    syscall





