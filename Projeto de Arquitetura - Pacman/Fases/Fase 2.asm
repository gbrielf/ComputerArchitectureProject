.data

.text
main:	jal wave1





end:	addi $v0, $zero, 10
	syscall

#====================================================================
# Função - Construtor de Cenário 1
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $sp, $t0, $1, $t2, $t3, $t4, $t5
# Rôtulos: wave1, endConst1, frame1, prox1, line11p1, line11p2,
# line21p1, line21p2, line31p1, line31p2, line41p1, line41p2,
# line41p3, line51p1, line51p2, line61p1, line61p2, line71p1,
# line71p2

wave1:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001
		ori $t1, 0x0000ff #COR - AZUL
		addi $t2, $zero, 128 #Última Unidade Gráfica(Linha)
		
frame1:		sw $t1, 0($t0) #1º Linha 
		sw $t1, 512($t0) #2º Linha
		sw $t1, 31744($t0) #Penultima Linha
		sw $t1, 32256($t0) #Última Linha
		addi $t0, $t0, 4 #Proxima Unidade Gráfica da Linha
		addi $t2, $t2, -1
		bne $t2, $zero frame1
		lui $t0, 0x1001 #RESET
		addi $t2, $zero, 64 #Última Unidade Gráfica(Coluna)  

prox1:		sw $t1, 0($t0) #1° Coluna
		sw $t1, 4($t0) #2º Coluna
		sw $t1, 504($t0) #Penultima Coluna
		sw $t1, 508($t0) #Última Coluna
		addi $t0, $t0, 512 #Próxima Unidade Gráfica(Coluna)
		addi $t2, $t2, -1
		bne $t2, $zero prox1
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 2580
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		
line11p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero line11p1
		addi $t0, $t0, 12
		addi $t2, $zero, 20
		addi $t3, $t3, -1
		bne $t3, $zero line11p1
		addi $t2, $zero, 46

line11p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line11p2
		addi $t0, $t0, 40
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line11p1
		addi $t0, $t0, 1536
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		
line21p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line21p1
		addi $t0, $t0, 12
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero line21p1
		addi $t2, $zero, 54
		
line21p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line21p2
		addi $t0, $t0, 40
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line21p1
		addi $t0, $t0, 1524
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $zero, 6
		
line31p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero line31p1
		addi $t0, $t0, 12
		addi $t2, $t2, 4
		addi $t3, $t3, -1
		bne $t3, $zero, line31p1
		addi $t2, $t2, 57
		
line31p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line31p2
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line31p1
		addi $t0, $t0, 1536
		addi $t2, $zero, 23
		addi $t3, $zero, 4
		addi $t4, $zero, 2
		addi $t5, $zero, 4
		
line41p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero line41p1
		addi $t0, $t0, 12
		addi $t2, $t2, 22
		addi $t3, $t3, -1
		bne $t3, $zero line41p1
		addi $t2, $t2, 5

line41p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line41p2
		addi $t2, $zero, 23
		addi $t3, $zero, 4
		addi $t4, $t4, -1
		bne $t4, $zero, line41p1
		
line41p3:	addi $t0, $t0, 1536
		addi $t2, $zero, 23
		addi $t3, $zero, 4
		addi $t4, $zero, 2
		addi $t5, $t5, -1
		bne $t5, $zero line41p1
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $zero, 6

line51p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero line51p1
		addi $t0, $t0, 12
		addi $t2, $t2, 4
		addi $t3, $t3, -1
		bne $t3, $zero, line51p1
		addi $t2, $t2, 57
		
line51p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line51p2
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line51p1
		addi $t0, $t0, 1548
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		
line61p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line61p1
		addi $t0, $t0, 12
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero line61p1
		addi $t2, $zero, 54
		
line61p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line61p2
		addi $t0, $t0, 40
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line61p1
		addi $t0, $t0, 1536
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		
line71p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero line71p1
		addi $t0, $t0, 12
		addi $t2, $zero, 20
		addi $t3, $t3, -1
		bne $t3, $zero line71p1
		addi $t2, $zero, 46

line71p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, line71p2
		addi $t0, $t0, 40
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, line71p1
		
endConst1:	addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Construtor de Cenário 2
# Entradas:
# Saidas:
# Registradores Sujos: $sp, $t0, $t1, $t2
# Rôtulos: wave2, frame2, prox2, endConst2

wave2:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001
		ori $t1, 0x0000ff #COR - AZUL
		addi $t2, $zero, 128 #Última Unidade Gráfica(Linha)
		
frame2:		sw $t1, 0($t0) #1º Linha 
		sw $t1, 512($t0) #2º Linha
		sw $t1, 31744($t0) #Penultima Linha
		sw $t1, 32256($t0) #Última Linha
		addi $t0, $t0, 4 #Proxima Unidade Gráfica da Linha
		addi $t2, $t2, -1
		bne $t2, $zero frame2
		lui $t0, 0x1001 #RESET
		addi $t2, $zero, 64 #Última Unidade Gráfica(Coluna)  

prox2:		sw $t1, 0($t0) #1° Coluna
		sw $t1, 4($t0) #2º Coluna
		sw $t1, 504($t0) #Penultima Coluna
		sw $t1, 508($t0) #Última Coluna
		addi $t0, $t0, 512 #Próxima Unidade Gráfica(Coluna)
		addi $t2, $t2, -1
		bne $t2, $zero prox2

endConst2:	addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Construtor do Personagem(PACMAN)
# Entradas:
# Saidas:
# Registradores Sujos:
# Rôtulos: pacman, endConstPAC

pacman:

endConstPAC: 	jr $ra

#--------------------------------------------------------------------
# Função - Movimento do Personagem(PACMAN)
# Entradas:
# Saidas:
# Registradores Sujos:
# Rôtulos: movePACMAN, endMovePAC

movePACMAN:

endMovePAC:	jr $ra

#--------------------------------------------------------------------
# Função - Construtor dos NPC(Fantasmas)
# Entradas:
# Saidas:
# Registradores Sujos:
# Rôtulos: ghost, endConstGhost

ghost:

endConstGhost:	jr $ra

#--------------------------------------------------------------------
# Função - Movimento do NPC(Fantasmas)
# Entradas:
# Saidas:
# Registradores Sujos:
# Rôtulos: moveGhost, endMoveGhost

moveGhost:

endMoveGhost:	jr $ra
