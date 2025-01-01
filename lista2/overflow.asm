.data
    msg: .asciiz "overflow"
.text
    main:
        li $v0, 5
        syscall
        move $t0, $v0

        li $v0, 5
        syscall
        move $t1, $v0

        li $v0, 5
        syscall
        move $t2, $v0

        xor $t3, $t1, $t2
        bgt $zero , $t3, notOverflow

        j overflow
        
    notOverflow:
        addu $a0, $t1, $t2
        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall

    overflow:
        addu $a0, $t1, $t2
        xor $t3, $a0, $t1

        bgt $zero, $t3, diferentes

        li $v0, 1
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall
    
    diferentes:
        la $a0,msg
        li $v0, 4
        syscall

        li $v0, 11
        li $a0, 10
        syscall

        li $v0, 10
        syscall