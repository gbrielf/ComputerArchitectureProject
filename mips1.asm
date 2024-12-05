.text
main:
	lui $8, 0x1001 #cria um espaço de 16 bits na memória alta
	addi $9, $0, 0xff00 #o registrador 9 vai receber a cor verde em Hexadecimal
	addi $20, $0, 32
test: 	beq $20, $0, reiniciavalor
	sw $9, 0($8) #estoca na memória o dado do registradro 9
	addi $8, $8, 4 #64 para pintar o primeiro pixel da segunda linha
	addi $20, $20, -1
	j test
reiniciavalor:
	lui $8, 0x1001 #cria um espaço de 16 bits na memória alta
	addi $9, $0, 0xff00 #o registrador 9 vai receber a cor verde em Hexadecimal
	addi $20, $0, 16
test2: 	beq $20, $0, reiniciavalor2
	sw $9, 0($8) #estoca na memória o dado do registradro 9
	addi $8, $8, 128 #64 para pintar o primeiro pixel da segunda linha
	addi $20, $20, -1
	j test2
reiniciavalor2:
	lui $8, 0x1001 #cria um espaço de 16 bits na memória alta
	addi $9, $0, 0xff00 #o registrador 9 vai receber a cor verde em Hexadecimal
	addi $20, $0, 32
test3: 	beq $20, $0, reiniciavalor3
	sw $9, 4($8) #estoca na memória o dado do registradro 9
	addi $8, $8, 124 #64 para pintar o primeiro pixel da segunda linha
	addi $20, $20, -1
	j test2
reiniciavalor3:
	lui $8, 0x1001 #cria um espaço de 16 bits na memória alta
	addi $9, $0, 0xff00 #o registrador 9 vai receber a cor verde em Hexadecimal
	addi $20, $0, 16
test4: 	beq $20, $0, reiniciavalor
	sw $9, 0($8) #estoca na memória o dado do registradro 9
	addi $8, $8, 124 #64 para pintar o primeiro pixel da segunda linha
	addi $20, $20, -1
	j test
#pintacoluna:
#	sw $9, 64($8)
fiml:
	addi $2, $0, 10
	syscall
