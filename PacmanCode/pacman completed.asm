.data

.text
main:		# Construir 1° Fase
		addi $a3, $zero, 0 	# Indicador 1º Fase
		jal border 		# Construir Cenário
		jal collect		# Construir Coletaveis
		jal ghost 		# Construir NPCs
		jal pacman		# Construir Pacman
	
		# Endereços Utilizados para Mover os NPCs
		addi $t7, $zero, 14488 	# Fantasma Vermelho
		addi $t8, $zero, 17148	# Fantasma Rosa
		addi $t9, $zero, 14684 	# Fantasma Laranja
		addi $s0, $zero, 'd'	# Movimento Inicial FV
		addi $s1, $zero, 'a'	# Movimento Inicial FR
		addi $s2, $zero, 'd'	# Movimento Inicial FL
		
		# Enderços Utilizados para Mover o PACMAN
		addi $s3, $zero, 1032	# Endereço Inicial do Pacman
		
stage1:	# Passando Atuais Informações do Fantasma Vermelho 
	add $a2, $zero, $t7 # Posição
	add $a3, $zero, $s0 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Vermelho
	add $t7, $zero, $v0 # Nova Posição
	add $s0, $zero, $v1 # Novo Lado de Movimento
		
	# Passando Atuais Informações do Fantasma Rosa 
	add $a2, $zero, $t8 # Posição
	add $a3, $zero, $s1 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Rosa
	add $t8, $zero, $v0 # Nova Posição
	add $s1, $zero, $v1 # Novo Lado de Movimento
		
	# Passando Atuais Informações do Fantasma Laranja 
	add $a2, $zero, $t9 # Posição
	add $a3, $zero, $s2 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Laranja
	add $t9, $zero, $v0 # Nova Posição
	add $s2, $zero, $v1 # Novo Lado de Movimento
	
	# Movimentação PACMAN
	lui $s4, 0xffff # Enderço de Informações do Teclado	
	lw $s5, 4($s4) # Pega Informações do Teclado
	
	add $a2, $zero, $s3 # Posição
	add $a3, $zero, $s5 # Lado do Movimento
	jal movepacman
	add $s3, $zero, $v0 # Nova Posição
	add $s7, $s7, $v1 # Quantidade de Coletáveis Pego
	
	addi $s5, $zero, 7 # Quantidade de Coletáveis na Fase
	beq $s7, $s5 nextstage
	j stage1

nextstage:	# Construir 2° Fase
		jal clear
		addi $a3, $zero, 1 	# Indicador 2º Fase
		jal border 		# Construir Cenário
		jal collect		# Construir Coletaveis
		jal ghost 		# Construir NPCs
		jal pacman		# Construir Pacman
	
		# Endereços Utilizados para Mover os NPCs
		addi $t7, $zero, 16024 	# Fantasma Vermelho
		addi $t8, $zero, 18684	# Fantasma Rosa
		addi $t9, $zero, 16224 	# Fantasma Laranja
		addi $s0, $zero, 'a'	# Movimento Inicial FV
		addi $s1, $zero, 'd'	# Movimento Inicial FR
		addi $s2, $zero, 'a'	# Movimento Inicial FL
		
		# Enderços Utilizados para Mover o PACMAN
		addi $s3, $zero, 1032	# Endereço Inicial do Pacman
		addi $s7, $zero, 0 	# RESET - Quantidade de Coletáveis Coletados

stage2:	# Passando Atuais Informações do Fantasma Vermelho 
	add $a2, $zero, $t7 # Posição
	add $a3, $zero, $s0 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Vermelho
	add $t7, $zero, $v0 # Nova Posição
	add $s0, $zero, $v1 # Novo Lado de Movimento
		
	# Passando Atuais Informações do Fantasma Rosa 
	add $a2, $zero, $t8 # Posição
	add $a3, $zero, $s1 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Rosa
	add $t8, $zero, $v0 # Nova Posição
	add $s1, $zero, $v1 # Novo Lado de Movimento
		
	# Passando Atuais Informações do Fantasma Laranja 
	add $a2, $zero, $t9 # Posição
	add $a3, $zero, $s2 # Lado do Movimento
	jal movenpc
	# Recebendo Novas Informações do Fantasma Laranja
	add $t9, $zero, $v0 # Nova Posição
	add $s2, $zero, $v1 # Novo Lado de Movimento
	
	# Movimentação PACMAN
	lui $s4, 0xffff # Enderço de Informações do Teclado	
	lw $s5, 4($s4) # Pega Informações do Teclado
	
	add $a2, $zero, $s3 # Posição
	add $a3, $zero, $s5 # Lado do Movimento
	jal movepacman
	add $s3, $zero, $v0 # Nova Posição
	add $s7, $s7, $v1 # Quantidade de Coletáveis Pego
	
	addi $s5, $zero, 7 # Quantidade de Coletáveis na Fase
	bne $s7, $s5 stage2

end:	jal youwin

#====================================================================
# Função - Construtor de Cenário
# Entradas: $a3
# Saidas: ---
# Registradores Sujos: $sp, $t0, $1, $t2, $t3, $t4, $t5
# Rôtulos: border, top_bottom, left_right, Scen1, 
# Scen1Linep1 - p10, Scen2, Scen2Line1p1 - p2, 
# Scen2Line2p1 - p2, Scen2Line3p1 - p2, Scen2Line4p1 - p3,
# Scen2Line5p1 - p2, Scen2Line6p1 - p2, Scen2Line7p1 - p2,
# ScenColumn1 - 2 

#Criação da Borda do Cénario!
border:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001
		ori $t1, 0x0000ff #COR - AZUL
		addi $t2, $zero, 128 #Última Unidade Gráfica(Linha)

# Criação da Borda Superior e Inferior!	
top_bottom:	sw $t1, 0($t0) #1º Linha 
		sw $t1, 512($t0) #2º Linha
		sw $t1, 31744($t0) #Penultima Linha
		sw $t1, 32256($t0) #Última Linha
		addi $t0, $t0, 4 #Proxima Unidade Gráfica da Linha
		addi $t2, $t2, -1
		bne $t2, $zero top_bottom
		lui $t0, 0x1001 #RESET
		addi $t2, $zero, 64 #Última Unidade Gráfica(Coluna)  

left_right:	sw $t1, 0($t0) #1° Coluna
		sw $t1, 4($t0) #2º Coluna
		sw $t1, 504($t0) #Penultima Coluna
		sw $t1, 508($t0) #Última Coluna
		addi $t0, $t0, 512 #Próxima Unidade Gráfica(Coluna)
		addi $t2, $t2, -1
		bne $t2, $zero left_right
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 2580 #Endereço do Inicio dos Cenários
		beq $a3, $zero Scen1 #Entrada = 0 - Fase 1
		j Scen2 #Entrada = 1 - Fase 2

# Criação do Cenário
# $t0 -> Endereços do Cenário
# $t1 -> Cor do Cenário(AZUL)
# $t2 -> Quantidade de Unidades Gráficas dos Pedaços da Linhas/Colunas
# $t3 -> Quantidade de Pedaços de Linha/Coluna
# $t4 -> Largura da Linha/Coluna(Unidades Gráficas)
# $t5 -> Repetição do Padrão da Linha/Coluna

Scen1:		#Informações Quatro Primeiras Linhas
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		addi $t5, $zero, 4

#Quatro Primeiras Linhas
Scen1Linep1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep1
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep1
		addi $t2, $zero, 22
		addi $t3, $zero, 3

Scen1Linep2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep2
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep2
		addi $t0, $t0, 28
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen1Linep1
		addi $t0, $t0, 1536
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		addi $t5, $t5, -1
		bne $t5, $zero Scen1Linep1
		#Informações Quinta Linha
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 3

#Quinta Linha (3 Unidades Gráficas de Largura)
Scen1Linep3:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep3
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep3
		addi $t2, $zero, 22
		addi $t3, $zero, 3

Scen1Linep4:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep4
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep4
		addi $t0, $t0, 28
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen1Linep3
		#Informações Sexta Linha
		addi $t0, $t0, 1536
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 2

#Sexta Linha
Scen1Linep5:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep5
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep5
		addi $t2, $zero, 22
		addi $t3, $zero, 3

Scen1Linep6:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep6
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep6
		addi $t0, $t0, 28
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen1Linep5
		#Informações Setima Linha
		addi $t0, $t0, 1536
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 3

#Setima Linha (3 Unidades Gráficas de Largura)
Scen1Linep7:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep7
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep7
		addi $t2, $zero, 22
		addi $t3, $zero, 3

Scen1Linep8:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep8
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep8
		addi $t0, $t0, 28
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen1Linep7
		#Informações Quatro Últimas Linhas
		addi $t0, $t0, 1536
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		addi $t5, $zero, 4

#Quatro Últimas Linhas
Scen1Linep9:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep9
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep9
		addi $t2, $zero, 22
		addi $t3, $zero, 3

Scen1Linep10:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen1Linep10
		addi $t0, $t0, 12
		addi $t2, $zero, 21
		addi $t3, $t3, -1
		bne $t3, $zero Scen1Linep10
		addi $t0, $t0, 28
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen1Linep9
		addi $t0, $t0, 1536
		addi $t2, $zero, 21
		addi $t3, $zero, 2
		addi $t4, $zero, 2
		addi $t5, $t5, -1
		bne $t5, $zero Scen1Linep9
		j endScenConst

Scen2:		#Informações Primeira Linha
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $zero, 2

#Primeira Linha		
Scen2Line1p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line1p1
		addi $t0, $t0, 12
		addi $t2, $zero, 20
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line1p1
		addi $t2, $zero, 46

Scen2Line1p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line1p2
		addi $t0, $t0, 40
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen2Line1p1
		#Informações Segunda Linha
		addi $t0, $t0, 1536
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $zero, 2

#Segunda Linha	
Scen2Line2p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line2p1
		addi $t0, $t0, 12
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line2p1
		addi $t2, $zero, 54
		
Scen2Line2p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line2p2
		addi $t0, $t0, 40
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen2Line2p1
		#Informações Terceira Linha
		addi $t0, $t0, 1524
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $zero, 6

#Terceira Linha	
Scen2Line3p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line3p1
		addi $t0, $t0, 12
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line3p1
		addi $t2, $t2, 57
		
Scen2Line3p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line3p2
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero Scen2Line3p1
		#Informações Quarta Linha (Bloco de Linhas)
		addi $t0, $t0, 1548
		addi $t2, $zero, 20
		addi $t3, $zero, 4
		addi $t4, $zero, 2
		addi $t5, $zero, 4

#Quarta Linha		
Scen2Line4p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line4p1
		addi $t0, $t0, 12
		addi $t2, $zero, 22
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line4p1
		addi $t2, $t2, -2

Scen2Line4p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line4p2
		addi $t0, $t0, 40
		addi $t2, $zero, 20
		addi $t3, $zero, 4
		addi $t4, $t4, -1
		bne $t4, $zero Scen2Line4p1

#Repetição do Padrão da Quarta Linha 4x	
Scen2Line4p3:	addi $t0, $t0, 1536
		addi $t2, $zero, 20
		addi $t3, $zero, 4
		addi $t4, $zero, 2
		addi $t5, $t5, -1
		bne $t5, $zero Scen2Line4p1
		#Informações Quinta Linha
		addi $t0, $t0, -12
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $zero, 5
#Quinta Linha
Scen2Line5p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line5p1
		addi $t0, $t0, 12
		addi $t2, $t2, 4
		addi $t3, $t3, -1
		bne $t3, $zero, Scen2Line5p1
		addi $t2, $t2, 57
		
Scen2Line5p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, Scen2Line5p2
		addi $t2, $zero, 57
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, Scen2Line5p1
		#Informações Sexta Linha
		addi $t0, $t0, 1548
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $zero, 2

#Sexta Linha		
Scen2Line6p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, Scen2Line6p1
		addi $t0, $t0, 12
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line6p1
		addi $t2, $zero, 54
		
Scen2Line6p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, Scen2Line6p2
		addi $t0, $t0, 40
		addi $t2, $zero, 54
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, Scen2Line6p1
		#Informações Setima Linha
		addi $t0, $t0, 1536
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $zero, 2

#Setima Linha		
Scen2Line7p1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Line7p1
		addi $t0, $t0, 12
		addi $t2, $zero, 20
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Line7p1
		addi $t2, $zero, 46

Scen2Line7p2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero, Scen2Line7p2
		addi $t0, $t0, 40
		addi $t2, $zero, 46
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero, Scen2Line7p1
		#Informações Primeira Coluna(TOP)
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 1272
		addi $t2, $zero, 4
		addi $t3, $zero, 8

#Primeira Coluna(TOP)
Scen2Column1:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Column1
		addi $t0, $t0, 496
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Column1
		#Informações Segunda Coluna(BOTTOM)
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 27896
		addi $t2, $zero, 4
		addi $t3, $zero, 8

#Segunda Coluna(BOTTOM)		
Scen2Column2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Scen2Column2
		addi $t0, $t0, 496
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero Scen2Column2		
		
endScenConst:	addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Construtor do Personagem(PACMAN)
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $sp, $t0, $t1, $t2
# Rôtulos: pacman, pacman_, pacman_2, pacman_3 endConstPAC

pacman:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001
		addi $t0, $t0, 1032 #Posição Inicial do Pacman
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xffff00 #COR - AMARELA
		addi $t2, $zero, 3 #Quantidade de Unidades Gráficas por Linha
		
pacman_:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero pacman_
		addi $t0, $t0, 500
		addi $t2, $zero, 2
		
pacman_2:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero pacman_2
		addi $t0, $t0, 504
		addi $t2, $zero, 3
		
pacman_3:	sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero pacman_3

endConstPAC: 	addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Construtor dos NPC(Fantasmas)
# Entradas: $a3
# Saidas: ---
# Registradores Sujos: $sp, $t0, $t1, $t2
# Rôtulos: ghost, S1Ghost, S1RedGhostp1 - p2, 
# S1PinkGhostp1 - p2, S1OrangeGhostp1 - p2, S2Ghost, 
# S2RedGhostp1 - p2, S2PinkGhostp1 - p2, S2OrangeGhostp1 - p2, 
# endConstGhost

ghost:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001 #RESET
		ori $t1, 0xffffff #COR - BRANCA
		beq $a3, $zero S1Ghost
		j S2Ghost
#Criação dos Fantasma do Primeiro Cénario
S1Ghost:	addi $t0, $t0, 14488 #Posição do Fantasma Vermelho

S1RedGhostp1:	#Primeira Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xff0000 #COR - VERMELHA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xff0000 #COR - VERMELHA
		addi $t2, $zero, 3
		
S1RedGhostp2:	#Segunda Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S1RedGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pular a Segunda Unidade Gráfica
		sw $t1, 0($t0) # Terceira Unidade Gráfica
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 17148 #Posição do Fantasma Rosa
		ori $t1, 0xffffff #COR - BRANCA
		
S1PinkGhostp1:	#Primeira Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xff007f #COR - ROSA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xff007f #COR - ROSA
		addi $t2, $zero, 3
		
S1PinkGhostp2:	#Segunda Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S1PinkGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pular a Segunda Unidade Gráfica
		sw $t1,0 ($t0) #Segunda Unidade Gráfica
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 14684 #Posição do Fantasma Laranja
		ori $t1, 0xffffff #COR - BRANCA
		
S1OrangeGhostp1:#Primeira Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xffa500 #COR - LARANJA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xffa500 #COR - LARANJA
		addi $t2, $zero, 3
		
S1OrangeGhostp2:#Segunda Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S1OrangeGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pula a Segunda Unidade Gráfica
		sw $t1,0 ($t0) #Terceira Unidade Gráfica
		j endConstGhost
#Criação dos Fantasma do Segundo Cénario
S2Ghost:	addi $t0, $t0, 16024 #Posição do Fantasma Vermelho
		
S2RedGhostp1:	#Primeira Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xff0000 #COR - VERMELHA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xff0000 #COR - VERMELHA
		addi $t2, $zero, 3
		
S2RedGhostp2:	#Segunda Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S2RedGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Vermelho
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pular a Segunda Unidade Gráfica
		sw $t1, 0($t0) # Terceira Unidade Gráfica
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 18684 #Posição do Fantasma Rosa
		ori $t1, 0xffffff #COR - BRANCA
		
S2PinkGhostp1:	#Primeira Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xff007f #COR - ROSA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xff007f #COR - ROSA
		addi $t2, $zero, 3
		
S2PinkGhostp2:	#Segunda Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S2PinkGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Rosa
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pular a Segunda Unidade Gráfica
		sw $t1,0 ($t0) #Segunda Unidade Gráfica
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 16224 #Posição do Fantasma Laranja
		ori $t1, 0xffffff #COR - BRANCA
		
S2OrangeGhostp1:#Primeira Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 4
		addi $t1, $zero, 0
		ori $t1, 0xffa500 #COR - LARANJA
		sw $t1, 0($t0) #Segunda Unidade Gráfica
		addi $t0, $t0, 4
		ori $t1, 0xffffff #COR - BRANCA
		sw $t1, 0 ($t0) #Terceira Unidade Gráfica
		addi $t0, $t0, 504
		addi $t1, $zero, 0
		ori $t1, 0xffa500 #COR - LARANJA
		addi $t2, $zero, 3
		
S2OrangeGhostp2:#Segunda Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero S2OrangeGhostp2
		addi $t0, $t0, 500
		#Última Linha do Sprit do Fantasma Laranja
		sw $t1, 0($t0) #Primeira Unidade Gráfica
		addi $t0, $t0, 8 #Pula a Segunda Unidade Gráfica
		sw $t1,0 ($t0) #Terceira Unidade Gráfica

endConstGhost:	addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Construir Coletáveis
# Entradas: $a3
# Saidas: ---
# Registradores Sujos: $sp, $t0, $t1
# Rôtulos: collect, S1Collect, S2Collect, endConstCollect

collect:	sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xf5f5f5 # COR - BRANCO ACINZENTADO(OFF-WHITE)
		beq $a3, $zero S1Collect
		j S2Collect

S1Collect:	#1° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 4184
		sw $t1, 0($t0)
		#2° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 4516
		sw $t1, 0($t0)
		#3° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 11932
		sw $t1, 0($t0)
		#4° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 15104
		sw $t1, 0($t0)
		#5° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 20832
		sw $t1, 0($t0)
		#6° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 28248
		sw $t1, 0($t0)
		#7° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 28580
		sw $t1, 0($t0)
		j endConstCollect
		
S2Collect:	#1° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 4276
		sw $t1, 0($t0)
		#2° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 4424
		sw $t1, 0($t0)
		#3° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 16568
		sw $t1, 0($t0)
		#4° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 16640
		sw $t1, 0($t0)
		#5° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 16708
		sw $t1, 0($t0)
		#6° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 28340
		sw $t1, 0($t0)
		#7° Coletável
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 28488
		sw $t1, 0($t0)
		
endConstCollect:addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função - Mover os NPCs(Fantasmas)
# Entradas: $a2, $a3
# Saidas: $v0, $v1
# Registradores Sujos: $sp, $t0, $t1, $t2, $t3, $t4, $t5, $s1, 
# $s2, $s3, $s4, $s5, $s6
# Rôtulos: movenpc - _ , movetop - _, movebottom - _, 
# moveleft - _, moveright - _, collide - _, finalmove, 
# ScenCollide1, CollideBottom, CollideLeft, CollideRight, 
# NPC_Collect, PacmanCollide, LeftRight, RightV, Choise - 2,
# LeftChoice, RightChoice, TwoChoise - 2, TopBottom, BottomV, 
# TopChoise, BottomChoise, TOP, BOTTOM, LEFT, RIGHT, endmove

movenpc:	#Guardando na Memoria para Utilizar
		sw $ra, 0($sp) #Endereço de Volta
		sw $s3, -4($sp) #Será Usado para Verificar a Direção do Movimento
		sw $s4, -8($sp) #Será Usado para Verificar se é a Primeira ou Segunda Verificação de Colisão
		sw $s5, -12($sp) #Será Usado para Verificar o Lado de Direção do NPC
		sw $s6, -16($sp) #Será Usado para Verificar a Passagem pela Verificação de Intersecção
		addi $sp, $sp, -20
		add $v0, $zero, $a2
		add $v1, $zero, $a3
		addi $s4, $zero, 0 #RESET
		j collide

movenpc_:	#Guarda Endereço de Posição do NPC
		add $a3, $zero, $v1
		addi $s4, $zero, 1 #Passou pela Primeira Verificação de Colisão
		lui $t0, 0x1001 #RESET
		add $t0, $t0, $a2 #Posição do NPC
		#Verificação da Direção de Movimento do NPC
		addi $s3, $zero, 'w'
		beq $a3, $s3 movetop
		addi $s3, $zero, 's'
		beq $a3, $s3 movebottom
		addi $s3, $zero, 'a'
		beq $a3, $s3 moveleft
		j moveright

movetop:	#Movimentação para Cima
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime1
		
movetop_:	lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, -512 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, 516 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero movetop_
		addi $t0, $t0, 500 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero, movetop_
		addi $t0, $t0, -512 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 4($t0)
		sw $t1, 8($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, -1536 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		addi $v1, $zero, 'w'
		j collide

movebottom:	#Movimentação para Baixo
		addi $t0, $t0, 1024 #Inverter Unidade Gráfica de Referência
		#Unidade Gráfica de Referência Padrão(Canto Superior Esquerdo)
		#Unidade Gráfica de Referência Invertida(Canto Inferior Esquerdo) 
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime1
		
movebottom_:	lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, 512 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, -508 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero movebottom_
		addi $t0, $t0, -524 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero, movebottom_
		addi $t0, $t0, 512 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 4($t0)
		sw $t1, 8($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, 512 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		addi $v1, $zero, 's'
		j collide

moveleft:	#Movimentação para Esquerda
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime1

moveleft_:	lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, -4 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, 8 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero, moveleft_
		addi $t0, $t0, 500 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero moveleft_
		addi $t0, $t0, -1528 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 512($t0)
		sw $t1, 1024($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, -12 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		addi $v1, $zero, 'a'
		j collide

moveright:	#Movimentação para Direita
		addi $t0, $t0, 8 #Inverter Unidade Gráfica de Referência
		#Unidade Gráfica de Referência Padrão(Canto Superior Esquerdo)
		#Unidade Gráfica de Referência Invertida(Canto Superior Direito)
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime1
		
moveright_:	lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, 4 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, -8 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero moveright_
		addi $t0, $t0, 524 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero moveright_
		addi $t0, $t0, -1544 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 512($t0)
		sw $t1, 1024($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, 4 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		addi $v1, $zero, 'd'
		
collide:	lui $t0, 0x1001 #RESET
		add $t0, $t0, $v0 #Posição Atual do NPC
		
		lw $t2, -512($t0) #Unidade Gráfica de Verificação de Colisão(TOP/Superior Esquerda)
		lw $t3, -508($t0) #Unidade Gráfica de Verificação de Colisção(TOP/Centro)
		lw $t4, -504($t0) #Unidade Gráfica de Verificação de Colisão(TOP/Superior Direita)
		addi $s3, $zero, 'w'
		beq $v1, $s3 collide_
		lw $t2, 1536($t0) #Unidade Gráfica de Verificação de Colisão(BOTTOM/Inferior Esquerda)
		lw $t3, 1540($t0) #Unidade Gráfica de Verificação de Colisção(BOTTOM/Centro)
		lw $t4, 1544($t0) #Unidade Gráfica de Verificação de Colisão(BOTTOM/Inferior Direita)
		addi $s3, $zero, 's'
		beq $v1, $s3 collide_
		lw $t2, -4($t0) #Unidade Gráfica de Verificação de Colisão(LEFT/Superior Esquerda)
		lw $t3, 508($t0) #Unidade Gráfica de Verificação de Colisção(LEFT/Centro)
		lw $t4, 1020($t0) #Unidade Gráfica de Verificação de Colisão(LEFT/Inferior Esquerda)
		addi $s3, $zero, 'a'
		beq $v1, $s3 collide_
		lw $t2, 12($t0) #Unidade Gráfica de Verificação de Colisão(RIGHT/Superior Direita)
		lw $t3, 524($t0) #Unidade Gráfica de Verificação de Colição(RIGHT/Centro)
		lw $t4, 1036($t0) #Unidade Gráfica de Verificação de Colisão(RIGHT/Inferior Direita)

collide_:	#Colisão com Cenário
		addi $t5, $zero, 0 #RESET
		ori $t5, 0x0000ff #COR - AZUL
		beq $t2, $t5, ScenCollide1
		#Colisão com Coletáveis
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xf5f5f5 # COR - BRANCO ACINZENTADO(OFF-WHITE)
		beq $t3, $t5 NPC_Collect
		#Colisão entre NPCs
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xff0000 #COR - VERMELHA
		beq $t2, $t5, NPC_Collect
		beq $t3, $t5, NPC_Collect
		beq $t4, $t5, NPC_Collect
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xff007f #COR - ROSA
		beq $t2, $t5, NPC_Collect
		beq $t3, $t5, NPC_Collect
		beq $t4, $t5, NPC_Collect
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xffa500 #COR - LARANJA
		beq $t2, $t5, NPC_Collect
		beq $t3, $t5, NPC_Collect
		beq $t4, $t5, NPC_Collect
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xffffff #COR - BRANCA
		beq $t2, $t5, NPC_Collect
		beq $t3, $t5, NPC_Collect
		beq $t4, $t5, NPC_Collect
		#Colisão com Pacman
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xffff00 #COR - AMARELA
		beq $t2, $t5, PacmanCollide
		beq $t3, $t5, PacmanCollide
		beq $t4, $t5, PacmanCollide
		
		beq $s4, $zero movenpc_
		#Movimento entre Intersecções
		bne $s6, $zero finalmove
		addi $t5, $zero, 'w'
		beq $v1, $t5 LeftRight
		addi $t5, $zero, 's'
		beq $v1, $t5 LeftRight
		addi $t5, $zero, 'a'
		beq $v1, $t5 TopBottom
		addi $t5, $zero, 'd'
		beq $v1, $t5 TopBottom
		
finalmove:	addi $s6, $zero, 0
		j endmove
		
ScenCollide1:	sw $v0, 0($sp) #Guardando o Valor do Registrador $v0 na Pilha
		addi $sp, $sp, -4
		addi $v0, $zero, 42 #Função de Randomização
		addi $a1, $zero, 3 #Randomizar Números de 0-2
		syscall
		addi $sp, $sp, +4
		lw $v0, 0($sp) #Recuperar o Valor do Registrador $v0 da Pilha
		addi $s3, $zero, 'w'
		bne $s3, $v1 collideBottom
			addi $t6, $zero, 0
			beq $a0, $t6, BOTTOM
			addi $t6, $zero, 1
			beq $a0, $t6, LEFT
			addi $t6, $zero, 2
			beq $a0, $t6, RIGHT

collideBottom:	addi $s3, $zero, 's'
		bne $s3, $v1 collideLeft
			addi $t6, $zero, 0
			beq $a0, $t6, TOP
			addi $t6, $zero, 1
			beq $a0, $t6, LEFT
			addi $t6, $zero, 2
			beq $a0, $t6, RIGHT

collideLeft:	addi $s3, $zero, 'a'
		bne $s3, $v1 collideRight
			addi $t6, $zero, 0
			beq $a0, $t6, TOP
			addi $t6, $zero, 1
			beq $a0, $t6, BOTTOM
			addi $t6, $zero, 2
			beq $a0, $t6, RIGHT

collideRight:	addi $s3, $zero, 'd'
		bne $s3, $v1 collide
			addi $t6, $zero, 0
			beq $a0, $t6, TOP
			addi $t6, $zero, 1
			beq $a0, $t6, BOTTOM
			addi $t6, $zero, 2
			beq $a0, $t6, LEFT

NPC_Collect:	addi $s3, $zero, 'w'
		beq $s3, $v1 BOTTOM
		addi $s3, $zero, 's'
		beq $s3, $v1 TOP
		addi $s3, $zero, 'a'
		beq $s3, $v1 RIGHT
		addi $s3, $zero, 'd'
		beq $s3, $v1 LEFT

PacmanCollide:	or $v0, $zero, $t5 #NPC Tocou no Pacman = Cor do Pacman
		jal gameover

LeftRight:	addi $s6, $zero, 1
		lw $t2, -4($t0) #Unidade Gráfica de Verificação (LEFT/Superior Esquerda)
		lw $t3, 508($t0) #Unidade Gráfica de Verificação (LEFT/Centro)
		lw $t4, 1020($t0) #Unidade Gráfica de Verificação (LEFT/Inferior Esquerda)
		addi $t5, $zero, 0 #RESET
		addi $s5, $zero, 0 #RESET
		addi $t5, $zero, 0x000000 #COR - PRETA
		bne $t2, $t5 RightV
		bne $t3, $t5 RightV
		bne $t4, $t5 RightV
		addi $s5, $zero, 1 #Esquerda OK!

RightV:		lw $t2, 12($t0) #Unidade Gráfica de Verificação (RIGHT/Superior Direita)
		lw $t3, 524($t0) #Unidade Gráfica de Verificação (RIGHT/Centro)
		lw $t4, 1036($t0) #Unidade Gráfica de Verificação (RIGHT/Inferior Direita)
		bne $t2, $t5 Choise
		bne $t3, $t5 Choise
		bne $t4, $t5 Choise
		addi $s5, $s5, 2 #Direita OK!
		
Choise:		sw $v0, 0($sp) #Guardando o Valor do Registrador $v0 na Pilha
		addi $sp, $sp, -4
		addi $v0, $zero, 42 #Função de Randomização
		addi $a1, $zero, 3 #Randomizar Números de 0-2
		syscall
		addi $sp, $sp, +4
		lw $v0, 0($sp) #Recuperar o Valor do Registrador $v0 da Pilha
		addi $t5, $zero, 1 #Esquerda OK!
		beq $s5, $t5 LeftChoise
		addi $t5, $zero, 2 #Direita OK!
		beq $s5, $t5 RightChoise
		addi $t5, $zero, 3 #Esquerda + Direita OK!
		beq $s5, $t5 TwoChoise
		j finalmove

LeftChoise:	addi $s5, $zero, 0
		beq $a0, $s5 LEFT
		j finalmove

RightChoise:	addi $s5, $zero, 0
		beq $a0, $s5 RIGHT
		j finalmove

TwoChoise:	addi $s5, $zero, 0
		beq $a0, $s5 LEFT
		addi $s5, $zero, 1
		beq $a0, $s5 RIGHT
		j finalmove

TopBottom:	addi $s6, $zero, 1
		lw $t2, -512($t0) #Unidade Gráfica de Verificação (TOP/Superior Esquerda)
		lw $t3, -508($t0) #Unidade Gráfica de Verificação (TOP/Centro)
		lw $t4, -504($t0) #Unidade Gráfica de Verificação (TOP/Superior Direita)	
		addi $t5, $zero, 0 #RESET
		addi $s5, $zero, 0 #RESET
		addi $t5, $zero, 0x000000 #COR - PRETA
		bne $t2, $t5 BottomV
		bne $t3, $t5 BottomV
		bne $t4, $t5 BottomV
		addi $s5, $zero, 1 #Cima/Superior OK!

BottomV:	lw $t2, 1536($t0) #Unidade Gráfica de Verificação (BOTTOM/Inferior Esquerda)
		lw $t3, 1540($t0) #Unidade Gráfica de Verificação (BOTTOM/Centro)
		lw $t4, 1544($t0) #Unidade Gráfica de Verificação (BOTTOM/Inferior Direita)		
		bne $t2, $t5 Choise2
		bne $t3, $t5 Choise2
		bne $t4, $t5 Choise2
		addi $s5, $s5, 2 #Baixo/Inferior OK!
		
Choise2:	sw $v0, 0($sp) #Guardando o Valor do Registrador $v0 na Pilha
		addi $sp, $sp, -4
		addi $v0, $zero, 42 #Função de Randomização
		addi $a1, $zero, 2 #Randomizar Números de 0-1
		syscall
		addi $sp, $sp, +4
		lw $v0, 0($sp) #Recuperar o Valor do Registrador $v0 da Pilha
		addi $t5, $zero, 1 #Cima/Superior OK!
		beq $s5, $t5 TopChoise
		addi $t5, $zero, 2 #Baixo/Inferior OK!
		beq $s5, $t5 BottomChoise
		addi $t5, $zero, 3 #Cima/Superior + Baixo/Inferior OK!
		beq $s5, $t5 TwoChoise2
		j finalmove

TopChoise:	addi $s5, $zero, 0
		beq $a0, $s5 TOP
		j finalmove

BottomChoise:	addi $s5, $zero, 0
		beq $a0, $s5 BOTTOM
		j finalmove

TwoChoise2:	addi $s5, $zero, 0
		beq $a0, $s5 TOP
		addi $s5, $zero, 1
		beq $a0, $s5 BOTTOM
		j finalmove

TOP:	addi $v1, $zero, 'w'
	j collide

BOTTOM:	addi $v1, $zero, 's'
	j collide

LEFT:	addi $v1, $zero, 'a'
	j collide

RIGHT:	addi $v1, $zero, 'd'
	j collide
		
endmove:	addi $sp, $sp, +20
		lw $ra, 0($sp) #Carregar Endereço de Volta
		lw $s3, -4($sp) #Carregar Valor do Registrador Usado($s3)
		lw $s4, -8($sp) #Carregar Valor do Registrador Usado($s4)
		sw $s5, -12($sp) #Carregar Valor do Registrador Usado($s5)
		sw $s6, -16($sp) #Carregar Valor do Registrador Usado($s6)
		jr $ra

#--------------------------------------------------------------------
# Função - Mover o PACMAN
# Entradas: $a2, $a3
# Saidas: $v0, $v1
# Registradores Sujos: $sp, $t1, $t2, $t3, $t4, $t5, $t6, $s3, $s4, $s5, 
# $s6
# Rôtulos: movepacman - _, w - _, s - _, a - _, d - _, 
# collidepacman - _, Collect - _, NPCs, ScenCollide2, 
# NPCsCollide, endmove_

movepacman:	#Guardando na Memoria para Utilizar
		sw $ra, 0($sp) #Endereço de Volta
		sw $s3, -4($sp) #Guardar Valor do Registrador $s3
		sw $s4, -8($sp) #Guardar Valor do Registrador $s4
		sw $s5, -12($sp) #Guardar Valor do Registrador $s5
		sw $s6, -16($sp) #Guardar Valor do Registrador $s6
		addi $sp, $sp, -20
		add $v0, $zero, $a2
		addi $v1, $zero, 0 #Nenhum Coletável Coletado
		addi $s4, $zero, 0 #RESET
		add $s5, $zero, $a3
		addi $s6, $zero, 0 #RESET
		j collidepacman

movepacman_:	#Guarda Endereço de Posição do PACMAN
		addi $s4, $zero, 1 #Passou pela Primeira Verificação de Colisão
		lui $t0, 0x1001 #RESET
		add $t0, $t0, $a2 #Posição do PACMAN
		#Verificação da Direção de Movimento do PACMAN
		addi $s3, $zero, 'w'
		beq $a3, $s3 w
		addi $s3, $zero, 's'
		beq $a3, $s3 s
		addi $s3, $zero, 'a'
		beq $a3, $s3 a
		addi $s3, $zero, 'd'
		beq $a3, $s3 d
		j endmove_
		
w:		#Movimentação para Cima
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 4($t0) #Mudar a Boca do Pacman
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xffff00 #COR - AMARELA
		sw $t1, 512($t0) #Apagar a Boca na Esquerda
		sw $t1, 520($t0) #Apagar a Boca na Direita
		sw $t1, 1028($t0) #Apagar a Boca no Bottom
		bne $s6, $zero endmove_
		
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime2
		
w_:		lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, -512 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, 516 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero w_
		addi $t0, $t0, 500 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero, w_
		addi $t0, $t0, -512 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 4($t0)
		sw $t1, 8($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, -1536 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		j collidepacman

s:		#Movimentação para Baixo
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 1028($t0) #Mudar a Boca do Pacman
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xffff00 #COR - AMARELA
		sw $t1, 512($t0) #Apagar a Boca na Esquerda
		sw $t1, 520($t0) #Apagar a Boca na Direita
		sw $t1, 4($t0) #Apagar a Boca no Bottom
		bne $s6, $zero endmove_
				
		addi $t0, $t0, 1024 #Inverter Unidade Gráfica de Referência
		#Unidade Gráfica de Referência Padrão(Canto Superior Esquerdo)
		#Unidade Gráfica de Referência Invertida(Canto Inferior Esquerdo) 
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime2
		
s_:		lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, 512 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, -508 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero s_
		addi $t0, $t0, -524 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero, s_
		addi $t0, $t0, 512 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 4($t0)
		sw $t1, 8($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, 512 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		j collidepacman

a:		#Movimentação para Esquerda
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 512($t0) #Mudar a Boca do Pacman
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xffff00 #COR - AMARELA
		sw $t1, 4($t0) #Apagar a Boca na Esquerda
		sw $t1, 520($t0) #Apagar a Boca na Direita
		sw $t1, 1028($t0) #Apagar a Boca no Bottom
		bne $s6, $zero endmove_
		
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime2

a_:		lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, -4 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, 8 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero, a_
		addi $t0, $t0, 500 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero a_
		addi $t0, $t0, -1528 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 512($t0)
		sw $t1, 1024($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, -12 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0
		j collidepacman

d:		#Movimentação para Direita
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 520($t0) #Mudar a Boca do Pacman
		addi $t1, $zero, 0 #RESET
		ori $t1, 0xffff00 #COR - AMARELA
		sw $t1, 4($t0) #Apagar a Boca na Esquerda
		sw $t1, 512($t0) #Apagar a Boca na Direita
		sw $t1, 1028($t0) #Apagar a Boca no Bottom
		bne $s6, $zero endmove_
		
		addi $t0, $t0, 8 #Inverter Unidade Gráfica de Referência
		#Unidade Gráfica de Referência Padrão(Canto Superior Esquerdo)
		#Unidade Gráfica de Referência Invertida(Canto Superior Direito)
		addi $t2, $zero, 3
		addi $t3, $zero, 3
		jal movetime2
		
d_:		lw $t1, 0($t0) #Salvar Unidade Gráfica(UG) 
		addi $t0, $t0, 4 #Posição de Movimento da UG
		sw $t1, 0($t0) #Mover a Unidade Gráfica
		addi $t0, $t0, -8 #Próximo Salvamento da UG
		addi $t2, $t2, -1
		bne $t2, $zero d_
		addi $t0, $t0, 524 #Próxima Linha de Movimentação
		addi $t2, $zero, 3
		addi $t3, $t3, -1
		bne $t3, $zero d_
		addi $t0, $t0, -1544 #Limpar Rastro
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t0)
		sw $t1, 512($t0)
		sw $t1, 1024($t0)
		addi $t1, $zero, 0 #RESET
		addi $t0, $t0, 4 #Voltar para a UG de Referência Padrão
		addi $t0, $t0, -268500992 #RESET + Endereço Novo
		add $v0, $zero, $t0

collidepacman:	lui $t0, 0x1001 #RESET
		add $t0, $t0, $v0 #Posição Atual do Pacman
		
		lw $t2, -512($t0) #Unidade Gráfica de Verificação de Colisão(TOP/Superior Esquerda)
		lw $t3, -508($t0) #Unidade Gráfica de Verificação de Colisção(TOP/Centro)
		addi $t6, $t0, -508 #Posição de Verificação de Coletaveis
		lw $t4, -504($t0) #Unidade Gráfica de Verificação de Colisão(TOP/Superior Direita)
		addi $s3, $zero, 'w'
		beq $s5, $s3 collidepacman_
		lw $t2, 1536($t0) #Unidade Gráfica de Verificação de Colisão(BOTTOM/Inferior Esquerda)
		lw $t3, 1540($t0) #Unidade Gráfica de Verificação de Colisção(BOTTOM/Centro)
		addi $t6, $t0, 1540 #Posição de Verificação de Coletaveis
		lw $t4, 1544($t0) #Unidade Gráfica de Verificação de Colisão(BOTTOM/Inferior Direita)
		addi $s3, $zero, 's'
		beq $s5, $s3 collidepacman_
		lw $t2, -4($t0) #Unidade Gráfica de Verificação de Colisão(LEFT/Superior Esquerda)
		lw $t3, 508($t0) #Unidade Gráfica de Verificação de Colisção(LEFT/Centro)
		addi $t6, $t0, 508 #Posição de Verificação de Coletaveis
		lw $t4, 1020($t0) #Unidade Gráfica de Verificação de Colisão(LEFT/Inferior Esquerda)
		addi $s3, $zero, 'a'
		beq $s5, $s3 collidepacman_
		lw $t2, 12($t0) #Unidade Gráfica de Verificação de Colisão(RIGHT/Superior Direita)
		lw $t3, 524($t0) #Unidade Gráfica de Verificação de Colição(RIGHT/Centro)
		addi $t6, $t0, 524 #Posição de Verificação de Coletaveis
		lw $t4, 1036($t0) #Unidade Gráfica de Verificação de Colisão(RIGHT/Inferior Direita)	

collidepacman_:	#Colisão com Cenário
		addi $t5, $zero, 0 #RESET
		ori $t5, 0x0000ff #COR - AZUL
		beq $t2, $t5, ScenCollide2
		beq $t3, $t5, ScenCollide2
		beq $t4, $t5, ScenCollide2
		#Colisão com Coletáveis
Collect:	addi $t5, $zero, 0 #RESET
		ori $t5, 0xf5f5f5 # COR - BRANCO ACINZENTADO(OFF-WHITE)
		beq $t3, $t5 Collect_
		#Colisão entre NPCs
NPCs:		addi $t5, $zero, 0 #RESET
		ori $t5, 0xff0000 #COR - VERMELHA
		beq $t2, $t5, NPCsCollide
		beq $t3, $t5, NPCsCollide
		beq $t4, $t5, NPCsCollide
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xff007f #COR - ROSA
		beq $t2, $t5, NPCsCollide
		beq $t3, $t5, NPCsCollide
		beq $t4, $t5, NPCsCollide
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xffa500 #COR - LARANJA
		beq $t2, $t5, NPCsCollide
		beq $t3, $t5, NPCsCollide
		beq $t4, $t5, NPCsCollide
		addi $t5, $zero, 0 #RESET
		ori $t5, 0xffffff #COR - BRANCA
		beq $t2, $t5, NPCsCollide
		beq $t3, $t5, NPCsCollide
		beq $t4, $t5, NPCsCollide
		
		beq $s4, $zero movepacman_
		j endmove_

ScenCollide2:	bne $s4, $zero endmove_
		addi $s6, $zero, 1
		j Collect
																													
Collect_:	addi $v1, $zero, 1 #Coletável Coletado
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		sw $t1, 0($t6) #Retirar Coletável do Cenário
		j NPCs
		
NPCsCollide:	or $v0, $zero, $t5 #Cor do NPC que o Pacman Colidiu
		jal gameover

endmove_:	addi $sp, $sp, +20
		lw $ra, 0($sp) #Carregar Endereço de Volta
		lw $s3, -4($sp) #Carregar Valor do Registrador Usado($s3)
		lw $s4, -8($sp) #Carregar Valor do Registrador Usado($s4)
		lw $s5, -12($sp) #Carregar Valor do Registrador Usado($s5)
		lw $s6, -16($sp) #Carregar Valor do Registrador Usado($s6)
		jr $ra

#--------------------------------------------------------------------
# Função Clear
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $sp, $t0, $t1, $t2, $t3
# Rôtulos: clear, clear_, back

clear:		sw $ra, 0($sp) #Guarda o endereço de volta da Função
		addi $sp, $sp, -4
		lui $t0, 0x1001 #RESET
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x000000 #COR - PRETA
		addi $t2, $zero, 513 #Quantidade de Unidades Gráficas da Linha
		addi $t3, $zero, 13 #Quantidade de Linhas
		
clear_:		jal time
		sw $t1, 0($t0)
		sw $t1, 512($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero clear_
		addi $t0, $t0, 512
		addi $t2, $zero, 513
		addi $t3, $t3, -1
		bne $t3, $zero, clear_
		
back:		addi $sp, $sp, +4 #Pega o endereço de volta da Função
		lw $ra, 0($sp)
		jr $ra

#--------------------------------------------------------------------
# Função Auxiliar de Tempo de Movimento dos NPCs
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $t1
# Rôtulos: movetime1, temp1

movetime1:	addi $t1, $zero, 2500
temp1:		addi $t1, $t1, -1
		bne $t1, $zero temp1
		jr $ra
		
#--------------------------------------------------------------------
# Função Auxiliar de Tempo de Movimento do PACMAN
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $t1
# Rôtulos: movetime2, temp2

movetime2:	addi $t1, $zero, 3500
temp2:		addi $t1, $t1, -1
		bne $t1, $zero temp2
		jr $ra
		
#--------------------------------------------------------------------
# Função Auxiliar de Tempo da Função Clear
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $t1
# Rôtulos: time, temp_

time:		addi $t1, $zero, 100
temp_:		addi $t1, $t1, -1
		bne $t1, $zero temp_
		jr $ra

#--------------------------------------------------------------------
# Função - Tela de Fim de Jogo
# Entradas: $v0
# Saidas: ---
# Registradores Sujos: $t1, $t2, $t3, $t4, $t5
# Rôtulos: gameover - _, G - _ - __ - ___, A - _, M - _, E - _, O - _, 
# V - _, R - _ - __

gameover:	jal clear
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 13952 #Posição Inicial da Formação do Nome "END GAME"
		addi $t1, $zero, 0 #RESET
		or $t1, $t1, $v0 #COR - Colisão com NPC
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantiadade de Linhas Verticais
		addi $t5, $zero, 0 #RESET

# LETRA G
G:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero G	
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero G
		addi $t2, $zero, 4 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Bloco de Linhas Horizontais

G_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero G_
		addi $t0, $t0, 496
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero G_
		addi $t0, $t0, 4096
		addi $t2, $zero, 4
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero G_
		addi $t0, $t0, -5624
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 5 #Quantidade de Linhas Horizontais
	
G__:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero G__
		addi $t0, $t0, -520
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero G__
		addi $t0, $t0, 508
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas/Linha Vertical
	
G___:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero, G___
		addi $t0, $t0, -3564 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRA A
A:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero A	
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero A
		addi $t0, $t0, 8
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero A
		addi $t0, $t0, -24
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais
	
A_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero A_
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero A_
		addi $t0, $t0, 1536
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero A_
		addi $t0, $t0, -5096 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

#LETRA M
M:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero M	
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero M
		addi $t0, $t0, 12
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero M
		addi $t0, $t0, 992
		addi $t2, $zero, 3 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 3 #Quantidade de Linhas Verticais

M_: 		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero M_
		addi $t0, $t0, -1020
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		addi $t4, $zero, 2
		beq $t3, $t4 M_
		addi $t0, $t0, -1536
		addi $t2, $zero, 3 
		addi $t4, $zero, 1
		beq $t3, $t4 M_
		addi $t0, $t0, 16 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas  
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais

# LETRA E	
E:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero E	
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero E
		addi $t2, $zero, 4 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 3 #Quantidade de Blocos de Linhas Horizontais
	
E_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero E_
		addi $t0, $t0, 496
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero E_
		addi $t0, $t0, 1536
		addi $t2, $zero, 4
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero E_
		bne $t5, $zero endE
		addi $t0, $t0, -7644 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRA O		
O:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero O
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero O
		addi $t0, $t0, 8
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero O
		addi $t0, $t0, 5096
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais

O_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero O_
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero O_
		addi $t0, $t0, -6144
		addi $t2, $zero, 2
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero O_
		addi $t0, $t0, 5144 #Próxima Letra
		addi $t2, $zero, 10 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRA V		
V:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero V
		addi $t0, $t0, -5116
		addi $t2, $zero, 10
		addi $t3, $t3, -1
		bne $t3, $zero V
		addi $t0, $t0, 8
		addi $t2, $zero, 10
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero V
		addi $t0, $t0, 5092
		addi $t2, $zero, 4 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais

V_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero V_
		addi $t0, $t0, 500
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero V_
		addi $t0, $t0, -6116 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t5, $zero, 1 #Identificação do Segundo E
		j E

endE:		addi $t0, $t0, -7656 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais

# LETRA R		
R:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero R
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero R
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais		
		
R_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero R_
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero R_
		addi $t0, $t0, 1536
		addi $t2, $zero, 2
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero R_
		addi $t0, $t0, -5112
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 3 #Quantidade de Linhas Verticais
		addi $t4, $zero, -5628 #Posição da Próxima Linha Vertical
		addi $t5, $zero, 4 #Quantidade de Unidades Gráficas da Próxima Linha Vertical
		
R__:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero R__
		add $t0, $t0, $t4
		add $t2, $zero, $t5
		addi $t3, $t3, -1
		addi $t4, $zero, 1024
		addi $t5, $zero, 5
		bne $t3, $zero R__
		
gameover_:	addi $v0, $zero, 10 #END GAME!
		syscall
		
#--------------------------------------------------------------------
# Função - Tela de Você Venceu
# Entradas: ---
# Saidas: ---
# Registradores Sujos: $t1, $t2, $t3, $t4, $t5
# Rôtulos: youwin - _, Y - _, O_U - _, U, W - _, I, N__ - ___

youwin:		jal clear
		lui $t0, 0x1001 #RESET
		addi $t0, $t0, 13992 #Posição Inicial da Formação do Nome "END GAME"
		addi $t1, $zero, 0 #RESET
		ori $t1, 0x00ff00 #COR - VERDE
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 7 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais
		addi $t5, $zero, 0 #RESET

# LETRA Y
Y:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero Y
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero Y
		addi $t0, $t0, -3600
		addi $t2, $zero, 2
		addi $t3, $zero, 7
		addi $t4, $t4, -1
		bne $t4, $zero Y
		addi $t0, $t0, 2584
		addi $t2, $zero, 7 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais

Y_:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero Y_
		addi $t0, $t0, -3580
		addi $t2, $zero, 7
		addi $t3, $t3, -1
		bne $t3, $zero Y_
		addi $t0, $t0, -2544 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRAS O e U
O_U:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero O_U
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero O_U
		addi $t0, $t0, 8
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero O_U
		addi $t0, $t0, 5096
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais

O_U_:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero O_U_
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero O_U_
		bne $t5, $zero U
		addi $t0, $t0, -6144
		addi $t2, $zero, 2
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero O_U_
		addi $t0, $t0, 5144 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais
		addi $t5, $zero, 1 #Indicador de Contrução da Letra U
		j O_U

U:		addi $t0, $t0, -6108 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRA W	
W:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero W
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero W
		addi $t0, $t0, 12
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero W
		addi $t0, $t0, 4576
		addi $t2, $zero, 3 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 3 #Quantidade de Linhas Verticais
	
W_:		sw $t1, 0($t0)
		addi $t0, $t0, -512
		addi $t2, $t2, -1
		bne $t2, $zero, W_
		addi $t0, $t0, 1028
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		addi $t4, $zero, 2
		beq $t3, $t4 W_
		addi $t0, $t0, 1536
		addi $t2, $zero, 3
		addi $t4, $zero, 1
		beq $t3, $t4 W_
		addi $t0, $t0, -5616 #Próxima Letra
		addi $t2, $zero, 2 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Horizontais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Horizontais

# LETRA I	
I:		sw $t1, 0($t0)
		addi $t0, $t0, 4
		addi $t2, $t2, -1
		bne $t2, $zero I
		addi $t0, $t0, 504
		addi $t2, $zero, 2
		addi $t3, $t3, -1
		bne $t3, $zero I
		addi $t0, $t0, 1024
		addi $t2, $zero, 2
		addi $t3, $zero, 8
		addi $t4, $t4, -1
		bne $t4, $zero I
		addi $t0, $t0, -7152 #Próxima Letra
		addi $t2, $zero, 12 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
		addi $t4, $zero, 2 #Quantidade de Blocos de Linhas Verticais

# LETRA N
N__: 		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero N__	
		addi $t0, $t0, -6140
		addi $t2, $zero, 12
		addi $t3, $t3, -1
		bne $t3, $zero N__
		addi $t0, $t0, 8
		addi $t2, $zero, 12
		addi $t3, $zero, 2
		addi $t4, $t4, -1
		bne $t4, $zero N__
		addi $t0, $t0, 1000
		addi $t2, $zero, 4 #Quantidade de Unidades Gráficas
		addi $t3, $zero, 2 #Quantidade de Linhas Verticais
	
N___:		sw $t1, 0($t0)
		addi $t0, $t0, 512
		addi $t2, $t2, -1
		bne $t2, $zero N___
		addi $t0, $t0, -1020
		addi $t2, $zero, 4
		addi $t3, $t3, -1
		bne $t3, $zero N___

youwin_:	addi $v0, $zero, 10 #YOU WIN
		syscall