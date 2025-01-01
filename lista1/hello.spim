.data
	# * declarando String
	msg: .asciiz "Ola mundo\n" 
.text
main: 
	# * imprimir String
	li $v0, 4 
	# * $a0 recebe o endereço de msg
	la $a0, msg 
	# * syscall opera o valor em $a0
	syscall 

	# * encerra o programa
	li $v0, 10 
	syscall 
