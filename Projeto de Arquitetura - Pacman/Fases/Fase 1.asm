.data

.text
main:	jal wave1





end:	addi $v0, $zero, 10
	syscall

#====================================================================
# Função - Construtor de Cenário 1
# Entradas:
# Saidas:
# Registradores Sujos: $sp, $t0, $1, $t2
# Rôtulos: wave1, endConst1, frame

wave1:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4 # $29
		lui $t0, 0x1001 #$8
		ori $t1, 0x0000ff # $9 COR - AZUL
		addi $t2, $zero, 128 # $10 Última Unidade Gráfica(Linha)
		
frame1:		sw $t1, 0($t0) #1º Linha 
		sw $t1, 512($t0) #2º Linha
		sw $t1, 31232($t0) #Antipenultima
		sw $t1, 31744($t0) #Penultima Linha
		sw $t1, 32256($t0) #Última Linha
		addi $t0, $t0, 4 #Proxima Unidade Gráfica da Linha
		addi $t2, $t2, -1
		bne $t2, $zero frame1
		lui $t0, 0x1001 #RESET
		addi $t2, $zero, 64 #Última Unidade Gráfica(Coluna)  

prox1:		sw $t1, 0($t0) #1° Coluna
		sw $t1, 4($t0) #2º Coluna
		sw $t1, 508($t0) #Última Coluna
		addi $t0, $t0, 512 #Próxima Unidade Gráfica(Coluna)
		addi $t2, $t2, -1
		bne $t2, $zero prox1
		
maze:
		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4 # $29
		lui $t0, 0x1001 #$8
		addi $t0, $t0, 12
		ori $t1, 0x0000ff # $9 COR - AZUL
		addi $t2, $zero, 80 # $10 Última Unidade Gráfica(Linha)
		addi $t3, $zero, 6
		addi $t4, $0, 1
		addi $t5, $0, 2048
		addi $t6, $0, 19
criandoobstaculo:	
		sw $t1, 2568($t0)	
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		addi $t3, $t3, -1
		beq $t3, $zero, contador
		bne $t2, $zero, criandoobstaculo
		j proximoobstaculo
		j endConst1
contador:
		addi $t3, $zero, 6
		addi $t0, $t0, 12
		j criandoobstaculo
proximoobstaculo:		
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 12
		addi $t2, $zero, 80
		addi $t3, $zero, 6
		mul $t6, $t4, $t5
		add $t0, $t0, $t6
		add $t6, $zero, $zero
		addi $t4, $t4, 1
		beq $t4, $t6, endConst1
		j criandoobstaculo
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
		bne $t2, $zero, frame2
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 3592 #Última Unidade Gráfica(Coluna) 
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
