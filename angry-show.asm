# CORES DO MORDECAI
# 000000 # PRETO
# 639bff # AZUL CLARO
# ffffff # BRANCO
# 1d2e97 # AZUL MARINHO
# 847e87 # CINZA

# CORES DO CEN�?RIO
# 7aacdd -> Azul escuro (Céu)
# a6d9f9 -> Azul levemente mais claro (Céu intermédio entre claro e escuro)
# d1eeff -> Azul claro (Céu mais claro)
# 4c941a - Verde escuro
# 6bbd2f - Verde claro
# 3e3e73 -> Parte debaixo do chão (Azul)

# CORES DAS NUVENS
# ddeeff -> Branco azulado
# cde3f5 -> Branco mais azulado ainda

# CORES DO MATO
# 035a01 -> Verde escuro
# 67e611 -> Verde claro
# 35c924 -> Verde levemente mais claro
# 02001b -> Contorno

# CORES DO PORCO
# 72ff38 -> Pele do porco
# 00b600 -> Nariz do porco 

.text
main:		
	lui $4, 0x1001
	jal desenharFundo
	
	lui $4, 0x1001
	addi $4, $4, 20940 # Posição inicial do porco
	jal desenharPorco
	
	lui $4, 0x1001
	addi $4, $4, 19456 # Posição inicial do Mordecai
	jal desenharMordecai

lacoInfinito:	
	lui $4, 0x1001
	addi $4, $4, 19456 # Posição inicial do Mordecai	
	jal piscarOlhosMordecai
	jal puloDoMordecai
	
	lui $4, 0x1001
	addi $4, $4, 18600 # Posição de referência para desenhar a seta
	jal moverMordecai
	
	lui $4, 0x1001
	addi $4, $4, 20940 # Posição inicial do porco
	jal piscarOlhosPorco

	j lacoInfinito
fim:	
	jal musicaParte1
	jal musicaParte2	
	jal musicaParte3
	jal musicaParte4
	addi $2, $0, 10
	syscall

##########################################
# ===== Rotina para desenhar fundo ===== 
# Entradas:                              	 				
#	$4: endereço                     
# Saída: void                            
# Usa (sem preservar):                   
#	$16: alcance do laço             
#	$17: endereço local              
#	$18: cor local                   
# O cenário é armazenado 32768 endereços 
# distantes dos endereços do display     
##########################################
desenharFundo:
	add $19, $0, $31

	addi $4, $4, 0		# posi inicial
	addi $5, $0, 15		# altura
	addi $6, $0, 128	# largura
	# li $7, 0x7bacde
	ori $7, $0, 0x7bac
	sll $7, $7, 8
	ori $7, $7, 0xde
	jal desenharQuadrado
	
	addi $4, $4, 7680	# posi inicial
	addi $5, $0, 7		# altura
	addi $6, $0, 128	# largura
	#li $7, 0xa5d9f7
	ori $7, $0, 0xa5d9
	sll $7, $7, 8
	ori $7, $7, 0xf7
	jal desenharQuadrado
	
	addi $4, $4, 3584	# posi inicial
	addi $5, $0, 30 	# altura
	addi $6, $0, 128	# largura
	#li $7, 0xd1eeff
	ori $7, $0, 0xd1ee
	sll $7, $7, 8
	ori $7, $7, 0xff
	jal desenharQuadrado
	
	addi $4, $4, 15360	# posi inicial
	addi $5, $0, 1		# altura
	addi $6, $0, 128	# largura
	#li $7, 0x67e60f
	ori $7, $0, 0x67e6
	sll $7, $7, 8
	ori $7, $7, 0x0f
	jal desenharQuadrado
	
	addi $4, $4, 512	# posi inicial
	addi $5, $0, 2		# altura
	addi $6, $0, 128	# largura
	#li $7, 0x35c527
	ori $7, $0, 0x35c5
	sll $7, $7, 8
	ori $7, $7, 0x27
	jal desenharQuadrado
	
	addi $4, $4, 1024	# posi inicial
	addi $5, $0, 9		# altura
	addi $6, $0, 128	# largura
	#li $7, 0x3f3f74
	ori $7, $0, 0x3f3f
	sll $7, $7, 8
	ori $7, $7, 0x74
	jal desenharQuadrado
	
	jr $19

##########################################
# desenharQuadrado
# Desenha um quadrado/retângulo
#
# Entradas:
# 	$4 - endereço do primeiro pixel (canto superior esquerdo)
# 	$5 - altura
# 	$6 - largura
#	$7 - cor (32 bits)
#
# Usa:
#   $8, $9, $10, $11
##########################################
desenharQuadrado:
    	add $8, $0, $4     # $8 = endereço linha atual
    	add $9, $0, $5     # $9 = contador de linhas (altura)

forQuadrado:
    	beq  $9, $0, endForQuadrado	# se altura = 0 → fim

    	# reset largura
    	add $10, $0, $6             	# $10 = contador de colunas (largura)
    	add $11, $0, $8             	# $11 = endereço do pixel da coluna atual

forLinha:
    	beq  $10, $0, endForLinha

    	sw $7, 0($11)               	# desenha pixel (cor)
    	sw $7, 32768($11)
    	addi $11, $11, 4             	# vai 1 pixel para a direita
    	
    	addi $10, $10, -1
    	j forLinha

endForLinha:
    	addi $8, $8, 512            	# desce 1 linha
    	addi $9, $9, -1
    	j forQuadrado

endForQuadrado:
    	jr $31

############################################
# === Rotina para desenhar o Mordecai ===  
# Entradas:                                	 				
#	$4: endereço de início do desenho  
# Saída:                                   
#        void                              
# Usa (sem preservar):                     
#	$17: endereço local dos pixels     
#	$18: cor local                     
#                                          
# De uma linha para outra soma 512         
############################################
desenharMordecai:
	add $17, $0, $4 # endereço local dos pixels
	ori $18, $0, 0x0000 # cor local

	# IN�?CIO DO TOPO DA CABEÇA
	sw $18, 16($17)
	sw $18, 528($17)
	sw $18, 532($17)
	sw $18, 1040($17) # Lateral esquerda
	sw $18, 1044($17)
	sw $18, 1048($17)
		
	# DAQUI PARA BAIXO TEM UMA REPETIÇÃO DE SOMAS
	sw $18, 1552($17) # Lateral esquerda (+512)
	sw $18, 1564($17) # (+4)
	sw $18, 2064($17) # Lateral esquerda (+512)
	sw $18, 2080($17) # (+4)
	sw $18, 2576($17) # Lateral esquerda (+512)
	sw $18, 2596($17) # (+4)
	sw $18, 3088($17) # Lateral esquerda (+512)
	sw $18, 3112($17) # (+4)
	# FIM DO TOPO DA CABEÇA
	
	sw $18, 2572($17)
	sw $18, 3080($17)
	sw $18, 3592($17)
	sw $18, 4104($17)
	sw $18, 4612($17)
	sw $18, 5124($17)
	sw $18, 5636($17)
	sw $18, 6152($17)
	sw $18, 6668($17)
	sw $18, 6672($17)
	sw $18, 7184($17)
	sw $18, 7700($17)
	sw $18, 7704($17)
	sw $18, 7708($17)
	sw $18, 7712($17)
	sw $18, 7716($17)
	sw $18, 7720($17)
	sw $18, 7212($17)
	sw $18, 6704($17)
	sw $18, 6708($17)
	sw $18, 6712($17)
	sw $18, 6204($17)
	sw $18, 6208($17)
	sw $18, 6212($17)
	sw $18, 6216($17)
	sw $18, 5708($17)
	sw $18, 5192($17)
	sw $18, 5188($17)
	sw $18, 5184($17)
	sw $18, 5180($17)
	sw $18, 5176($17)
	sw $18, 5172($17)
	sw $18, 5168($17)
	sw $18, 5164($17)
	
	sw $18, 5672($17) # Cantinho da boca
	sw $18, 5668($17)
	sw $18, 5664($17)
	sw $18, 5660($17)
	sw $18, 6168($17)
	sw $18, 6676($17)
	sw $18, 6184($17)
	sw $18, 6700($17)
	
	# Meio dos olhos
	sw $18, 4652($17) 
	sw $18, 4140($17)
	sw $18, 3628($17)
	# Fim do Meio dos olhos
	
	# Olho direito
	sw $18, 3632($17)
	sw $18, 3636($17)
	sw $18, 4152($17)
	sw $18, 4664($17)
	sw $18, 4660($17)
	# Fim do Olho direito
	
	# Olho esquerdo
	sw $18, 3624($17)
	sw $18, 3620($17)
	sw $18, 4128($17)
	sw $18, 4640($17)
	sw $18, 5156($17)
	sw $18, 5160($17)
	sw $18, 4648($17)
	# Fim do Olho esquerdo
	
	ori $18, $0, 0x639b
	sll $18, $18, 8
	ori $18, $18, 0xff 
	
	#### A PARTIR DAQUI É A COLORAÇÃO DO MORDECAI ####
	# IN�?CIO DO TOPO DA CABEÇA
	# DAQUI PARA BAIXO TEM UMA REPETIÇÃO DE SOMAS
	sw $18, 1556($17) # Lateral interna esquerda
	sw $18, 1560($17)
	sw $18, 2068($17) # Lateral interna esquerda
	sw $18, 2072($17)
	sw $18, 2076($17)
	sw $18, 2580($17)
	sw $18, 2584($17)
	sw $18, 2588($17)
	sw $18, 2592($17) 
	sw $18, 3092($17) # Lateral interna esquerda
	sw $18, 3096($17)
	sw $18, 3100($17)
	sw $18, 3104($17)
	sw $18, 3108($17)
	sw $18, 3084($17)
	sw $18, 3596($17) # Lateral interna esquerda
	sw $18, 3600($17)
	sw $18, 3604($17)
	sw $18, 3608($17)
	sw $18, 3612($17)
	sw $18, 3616($17)
	sw $18, 4108($17) # Lateral interna esquerda
	sw $18, 4112($17)
	sw $18, 4116($17)
	sw $18, 4120($17)
	sw $18, 4124($17)
	sw $18, 4616($17) # Lateral interna esquerda
	sw $18, 4620($17)
	sw $18, 4624($17)
	sw $18, 4628($17)
	sw $18, 4632($17)
	sw $18, 4636($17)
	sw $18, 5128($17) # Lateral interna esquerda
	sw $18, 5132($17)
	sw $18, 5136($17)
	sw $18, 5140($17)
	sw $18, 5144($17)
	sw $18, 5148($17)
	sw $18, 5152($17)
	sw $18, 5640($17) # Lateral interna esquerda
	sw $18, 5644($17)
	sw $18, 5648($17)
	sw $18, 5652($17)
	sw $18, 5656($17)
	sw $18, 6156($17) # Lateral interna esquerda
	sw $18, 6160($17)
	sw $18, 6164($17)
	
	ori $18, $0, 0xffff
	sll $18, $18, 8
	ori $18, $18, 0xcc
	
	
	sw $18, 4132($17) # Lateral interna do olho esquerdo
	sw $18, 4136($17)
	sw $18, 4644($17) # Lateral interna do olho esquerdo
	
	sw $18, 4144($17) # Lateral interna do olho direito
	sw $18, 4148($17)
	sw $18, 4656($17) # Lateral interna do olho direito
	
	sw $18, 6172($17) # Lateral interna da bochecha
	sw $18, 6176($17)
	sw $18, 6180($17)
	sw $18, 6680($17) # Lateral interna da bochecha
	sw $18, 6684($17)
	sw $18, 6688($17)
	sw $18, 6692($17)
	sw $18, 6696($17)
	sw $18, 7188($17) # Lateral interna da bochecha
	sw $18, 7192($17)
	sw $18, 7196($17)
	sw $18, 7200($17)
	sw $18, 7204($17)
	sw $18, 7208($17)
	# FIM DA CABEÇA
	
	# PINTURA DA BOCA
	ori $18, $0, 0x847e
	sll $18, $18, 8
	ori $18, $18, 0x87	
	
	sw $18, 5676($17) # Lateral interna da boca
	sw $18, 5680($17)
	sw $18, 5684($17)
	sw $18, 5688($17)
	sw $18, 5692($17)
	sw $18, 5696($17)
	sw $18, 5700($17)
	sw $18, 5704($17)
	sw $18, 6188($17) # Lateral interna da boca
	sw $18, 6192($17)
	sw $18, 6196($17)
	sw $18, 6200($17)
	# FIM PINTURA DA BOCA	
	jr $31

############################################
# === Rotina para desenhar o porco ===  
# Entradas:                                	 				
#	$4: endereço de início do desenho  
# Saída:                                   
#        void                              
# Usa (sem preservar):                       
#	$16: verificação dos olhos fechados 
#	$17: endereço local dos pixels     
#	$18: cor local                     
#                                          
# De uma linha para outra soma 512                                                   
############################################
desenharPorco:	
	##### CONTORNO DO CORPO #####
	add $17, $0, $4 # Endereço local
	ori $18, $0, 0x0000 
	sll $18, $18, 8
	ori $18, $18, 0x00 # Cor local: Preto
	
	sw $18, 0($17)
	sw $18, 4($17)
	sw $18, 28($17)
	sw $18, 32($17)	
	sw $18, 512($17)
	sw $18, 520($17)
	sw $18, 524($17)
	sw $18, 528($17)
	sw $18, 532($17)
	sw $18, 536($17)
	sw $18, 544($17)
	sw $18, 1020($17)
	sw $18, 1060($17)
	sw $18, 1528($17)
	sw $18, 1576($17)
	sw $18, 2036($17)
	sw $18, 2092($17)
	sw $18, 2548($17)
	sw $18, 2604($17)	
	sw $18, 3060($17)	
	sw $18, 3116($17)
	sw $18, 3572($17)
	sw $18, 3628($17)	
	sw $18, 4084($17)
	sw $18, 4140($17)
	sw $18, 4596($17)
	sw $18, 4652($17)
	sw $18, 5108($17)
	sw $18, 5164($17)
	sw $18, 5624($17)	
	sw $18, 5672($17)
	sw $18, 6140($17)
	sw $18, 6180($17)
	sw $18, 6656($17)
	sw $18, 6688($17)
	sw $18, 6684($17)
	sw $18, 6680($17)
	sw $18, 6676($17)
	sw $18, 6672($17)
	sw $18, 6668($17)
	sw $18, 6664($17)
	sw $18, 6660($17)
	
	##### PINTURA #####
	ori $18, $0, 0x72ff 
	sll $18, $18, 8
	ori $18, $18, 0x38 # Cor local: Verde
	
	sw $18, 516($17)
	sw $18, 540($17)
	sw $18, 1024($17)
	sw $18, 1028($17)
	sw $18, 1032($17)
	sw $18, 1036($17)
	sw $18, 1040($17)
	sw $18, 1044($17)
	sw $18, 1048($17)
	sw $18, 1052($17)
	sw $18, 1056($17)
	sw $18, 1532($17)
	sw $18, 1536($17)
	sw $18, 1540($17)
	sw $18, 1544($17)
	sw $18, 1548($17)
	sw $18, 1552($17)
	sw $18, 1556($17)
	sw $18, 1560($17)
	sw $18, 1564($17)
	sw $18, 1568($17)
	sw $18, 1572($17)
	sw $18, 2040($17) # Canto
	sw $18, 2044($17)
	sw $18, 2048($17)
	sw $18, 2052($17)
	sw $18, 2056($17)
	sw $18, 2060($17)
	sw $18, 2064($17)
	sw $18, 2068($17)
	sw $18, 2072($17)
	sw $18, 2076($17)
	sw $18, 2080($17)
	sw $18, 2084($17)
	sw $18, 2088($17)
	sw $18, 2552($17) # Canto
	sw $18, 2556($17)
	sw $18, 2560($17)
	sw $18, 2564($17)
	sw $18, 2568($17)
	sw $18, 2572($17)
	sw $18, 2576($17)
	sw $18, 2580($17)
	sw $18, 2584($17)
	sw $18, 2588($17)
	sw $18, 2592($17)
	sw $18, 2596($17)
	sw $18, 2600($17)
	sw $18, 3064($17) # Canto
	sw $18, 3068($17)
	sw $18, 3072($17)
	sw $18, 3076($17)
	sw $18, 3080($17)
	sw $18, 3084($17)
	sw $18, 3088($17)
	sw $18, 3092($17)
	sw $18, 3096($17)
	sw $18, 3100($17)
	sw $18, 3104($17)
	sw $18, 3108($17)
	sw $18, 3112($17)
	sw $18, 3576($17) # Canto
	sw $18, 3580($17)
	sw $18, 3584($17)
	sw $18, 3588($17)
	sw $18, 3592($17)
	sw $18, 3596($17)
	sw $18, 3600($17)
	sw $18, 3604($17)
	sw $18, 3608($17)
	sw $18, 3612($17)
	sw $18, 3616($17)
	sw $18, 3620($17)
	sw $18, 3624($17)
	sw $18, 4088($17) # Canto
	sw $18, 4092($17)
	sw $18, 4096($17)
	sw $18, 4100($17)
	sw $18, 4104($17)
	sw $18, 4108($17)
	sw $18, 4112($17)
	sw $18, 4116($17)
	sw $18, 4120($17)
	sw $18, 4124($17)
	sw $18, 4128($17)
	sw $18, 4132($17)
	sw $18, 4136($17)
	
	sw $18, 4600($17) # Canto
	sw $18, 4604($17)
	sw $18, 4608($17)
	sw $18, 4612($17)
	sw $18, 4616($17)
	sw $18, 4620($17)
	sw $18, 4624($17)
	sw $18, 4628($17)
	sw $18, 4632($17)
	sw $18, 4636($17)
	sw $18, 4640($17)
	sw $18, 4644($17)
	sw $18, 4648($17)
	
	sw $18, 5112($17) # Canto
	sw $18, 5116($17)
	sw $18, 5120($17)
	sw $18, 5124($17)
	sw $18, 5128($17)
	sw $18, 5132($17)
	sw $18, 5136($17)
	sw $18, 5140($17)
	sw $18, 5144($17)
	sw $18, 5148($17)
	sw $18, 5152($17)
	sw $18, 5156($17)
	sw $18, 5160($17)
	
	sw $18, 5628($17) # Canto
	sw $18, 5632($17)
	sw $18, 5636($17)
	sw $18, 5640($17)
	sw $18, 5644($17)
	sw $18, 5648($17)
	sw $18, 5652($17)
	sw $18, 5656($17)
	sw $18, 5660($17)
	sw $18, 5664($17)
	sw $18, 5668($17)
	
	sw $18, 6144($17) # Canto
	sw $18, 6148($17)
	sw $18, 6152($17)
	sw $18, 6156($17)
	sw $18, 6160($17)
	sw $18, 6164($17)
	sw $18, 6168($17)
	sw $18, 6172($17)
	sw $18, 6176($17)

	##### CONTORNO DO ROSTO #####
	ori $18, $0, 0x0000 
	sll $18, $18, 8
	ori $18, $18, 0x00 # Cor local: Preto
	
	# OLHO ESQUERDO
	sw $18, 2552($17)
	sw $18, 2556($17)
	sw $18, 3072($17)
	sw $18, 3576($17)
	sw $18, 3584($17)
	sw $18, 4096($17)
	sw $18, 4604($17)
	sw $18, 4600($17)
		
	# OLHO DIREITO
	sw $18, 2600($17)
	sw $18, 2596($17)
	sw $18, 3104($17)
	sw $18, 3616($17)
	sw $18, 3624($17)
	sw $18, 4128($17)
	sw $18, 4644($17)
	sw $18, 4648($17)
	
	# NARIZ
	sw $18, 3596($17)
	sw $18, 4108($17)
	sw $18, 4116($17)
	
	##### PINTURA DO ROSTO #####
	ori $18, $18, 0xffff
	sll $18, $18, 8
	ori $18, $18, 0xff
	
	# OLHO ESQUERDO
	sw $18, 3064($17)
	sw $18, 3068($17)
	sw $18, 3580($17)
	sw $18, 4088($17)
	sw $18, 4092($17)
	
	# OLHO DIREITO
	sw $18, 3112($17)
	sw $18, 3108($17)
	sw $18, 3620($17)
	sw $18, 4132($17)
	sw $18, 4136($17)
	
	# BOCA E NARIZ E SOBRANCELHA
	ori $18, $0, 0x009b
	sll $18, $18, 8
	ori $18, $18, 0x00
	
	# SOBRANCELHA ESQUERDA
	sw $18, 1540($17)
	sw $18, 2048($17)
	

	# SOBRANCELHA DIREITA
	sw $18, 1564($17)
	sw $18, 2080($17)
	
		
	# NARIZ
	sw $18, 2568($17)
	sw $18, 2572($17)
	sw $18, 2576($17)
	sw $18, 2580($17)
	sw $18, 2584($17)
	
	# BOCA
	sw $18, 3588($17)
	sw $18, 3612($17)
	sw $18, 4100($17)
	sw $18, 4124($17)
	sw $18, 4612($17)
	sw $18, 4616($17)
	sw $18, 4620($17)
	sw $18, 4624($17)
	sw $18, 4628($17)
	sw $18, 4632($17)
	sw $18, 4636($17)
	sw $18, 5128($17)
	sw $18, 5144($17)
	sw $18, 5644($17)
	sw $18, 5648($17)
	sw $18, 5652($17)
									
	jr $31

###################################################	
# ===== ROTINA PARA PISCAR OS OLHOS DO MORDECAI ===== 
# Entrada: 
#	$4: posição do mordecai
# Usa (sem preservar): 
#	$17: endereço local
#	$18: cor local
#	$19: cópia do endereço de $31
###################################################
piscarOlhosMordecai:
	add $17, $0, $4 # endereço local
	add $19, $0, $31		
	
	# FECHA
	ori $18, $0, 0xc1c1
	sll $18, $18, 8
	ori $18, $18, 0xc1 # Cor cinza escuro
	
	sw $18, 4132($17) # Lateral esquerda interna do olho esquerdo
	sw $18, 4136($17)

	sw $18, 4644($17)
	sw $18, 4648($17)

	sw $18, 4144($17) # Lateral interna do olho direito
	sw $18, 4148($17)

	sw $18, 4656($17) # Lateral interna do olho direito
	sw $18, 4660($17)
	addi $5, $0, 100000
	jal gastarTempo
		
	# ABRE
	ori $18, $0, 0xffff
	sll $18, $18, 8
	ori $18, $18, 0xff # Cor Branco
	
	sw $18, 4132($17) # Lateral esquerda interna do olho esquerdo
	sw $18, 4136($17)
	sw $18, 4644($17)
		
	sw $18, 4144($17) # Lateral interna do olho direito
	sw $18, 4148($17)
	sw $18, 4656($17) # Lateral interna do olho direito
	
	ori $18, $0, 0x0000 # Preto	
	sw $18, 4648($17)
	sw $18, 4660($17)
	addi $5, $0, 600000	
	jal gastarTempo
	
	jr $19

###################################################	
# ===== ROTINA PARA PISCAR OS OLHOS DO PORCO =====
# Entrada:
#	$4: posição inicial do porco
# Usa (sem presevar):
#	$17: endereco local
#	$18: cor local
#	$19: cópia do endereço de $31 
###################################################
piscarOlhosPorco:
	add $17, $0, $4 # Endereço local
	add $19, $0, $31
	
	# == FECHA ==
	ori $18, $0, 0x67e6
	sll $18, $18, 8
	ori $18, $18, 0x11 # verde claro
	
	# OLHO ESQUERDO
	sw $18, 3064($17)
	sw $18, 3068($17)
	sw $18, 3576($17)
	sw $18, 3580($17)
	sw $18, 4088($17)
	sw $18, 4092($17)
	
	# OLHO DIREITO
	sw $18, 3112($17)
	sw $18, 3108($17)
	sw $18, 3620($17)
	sw $18, 3624($17)
	sw $18, 4132($17)
	sw $18, 4136($17)
	addi $5, $0, 100000	
	jal gastarTempo
	
	# == ABRE ==
	ori $18, $0, 0xffff
	sll $18, $18, 8
	ori $18, $18, 0xff # Branco
	
	# OLHO ESQUERDO
	sw $18, 3064($17)
	sw $18, 3068($17)
	sw $18, 3580($17)
	sw $18, 4088($17)
	sw $18, 4092($17)
	
	# OLHO DIREITO
	sw $18, 3112($17)
	sw $18, 3108($17)
	sw $18, 3620($17)
	sw $18, 4132($17)
	sw $18, 4136($17)
	
	ori $18, $0, 0x0000 # Preto
	sw $18, 3576($17)
	sw $18, 3624($17)
	
	addi $5, $0, 600000	
	jal gastarTempo
	
	jr $19

###################################################	
# ===== ROTINA PARA RENDERIZAR CENARIO ATRAS DO MORDECAI =====
# Entrada:
#	$4: endereço
# Usa:
#	$17: cópia do endereço
#	$18, $19: loop
##############################################################
desenharParteCenarioMordecai:
	add $17, $0, $4			
	addi $18, $0, 16
forDesenharParteCenarioI:
	beq $18, $0, endForDesenharParteCenarioI
	addi $20, $0, 20
forDesenharParteCenarioJ:
	beq $20, $0, endForDesenharParteCenarioJ
	lw $16, 32768($17)
	sw $16, 0($17)
	addi $17, $17, 4
	addi $20, $20, -1 
	j forDesenharParteCenarioJ
endForDesenharParteCenarioJ:
	addi $17, $17, 432
	addi $18, $18, -1	
	j forDesenharParteCenarioI
endForDesenharParteCenarioI:
	jr $31

###################################################
# ===== ROTINA PARA PULAR O MORDECAI =====
# Entrada:
#	$4: posicao inicial do personagem
# Usa (sem preservar):
#	$16: endereço dos pixels copiados do cenário
#	$17: cópia da posição inicial
#	$19: cópia do endereço $31
###################################################
puloDoMordecai:			
	add $19, $0, $31 
	add $17, $0, $4	
		
	jal desenharParteCenarioMordecai
	addi $4, $4, -1024
	jal desenharMordecai
	
	addi $5, $0, 65000
	jal gastarTempo
	
	jal desenharParteCenarioMordecai
	addi $4, $4, 1024
	jal desenharMordecai
												
	jr $19

###################################################	
# ===== ROTINA PARA MOVER O MORDECAI =====
# Entrada:
#	$4: sinal do pressionamento de tecla
# Usa:
#	$16: tecla pressionada
#	$17: tecla para verificação
#	$19: cópia de $31
####################################################
moverMordecai:
	add $19, $0, $31
	lui $18, 0xffff
	lw $16, 0($18)
	beq $16, $0, fimMoverMordecai # $16=0 --> nenhuma tecla pressionada
	lw $16, 4($18) 
	addi $17, $0, 'd'
	beq $16, $17, setaFrente
	addi $17, $0, 'w'
	beq $16, $17, setaCima
setaFrente:
	jal apagarSeta
	jal desenharSetaParaFrente
	j fimMoverMordecai
setaCima:
	jal apagarSeta
	jal desenharSetaParaCima
	j fimMoverMordecai
fimMoverMordecai:
	jr $19

###################################################	
# ===== ROTINA PARA DESENHAR UMA SETA PARA FRENTE =====
# Entrada:
#	$5: posição da seta
# Usa:
#	$18: cor
#	$21: cópia de $31 
####################################################
desenharSetaParaFrente:
	ori $18, $0, 0x0000 # preto
	add $17, $0, $4
	
	# DESENHA
	sw $18, -1008($17)
	sw $18, -496($17)
	sw $18, -492($17)
	sw $18, 0($17)
	sw $18, 4($17)	
	sw $18, 8($17)
	sw $18, 12($17)
	sw $18, 16($17)
	sw $18, 20($17)
	sw $18, 24($17)
	sw $18, 528($17)
	sw $18, 532($17)
	sw $18, 1040($17)

	jr $31

###################################################	
# ===== ROTINA PARA DESENHAR UMA SETA PARA CIMA =====
# Entrada:
#	$5: posição da seta
# Usa:
#	$18: cor
#	$21: cópia de $31 
####################################################
desenharSetaParaCima:
	ori $18, $0, 0x0000 # preto
	add $17, $0, $4
	
	# DESENHA
	sw $18, -1024($17)
	sw $18, -516($17)
	sw $18, -512($17)
	sw $18, -508($17)
	sw $18, -8($17)
	sw $18, -4($17)
	sw $18, 0($17)
	sw $18, 4($17)
	sw $18, 8($17)
	sw $18, 512($17)
	sw $18, 2048($17)
	sw $18, 1024($17)
	sw $18, 1536($17)
	sw $18, 2048($17)
	sw $18, 2560($17)
	
	jr $31

###################################################	
# ===== ROTINA PARA APAGAR UMA SETA =====
# Entrada:
#	$4: posição da seta
# Usa:
#	$16, $17: loop	
#	$18: cor
####################################################
apagarSeta:
	add $17, $0, $4
	addi $17, $17, -1028
	addi $18, $0, 8 # Altura
forApagarSetaI:
	beq $18, $0, endForApagarSetaI
	addi $20, $0, 10 # Largura
	
forApagarSetaJ:
	beq $20, $0, endForApagarSetaJ
	lw $16, 32768($17)
	sw $16, 0($17)
	addi $17, $17, 4
	addi $20, $20, -1 
	j forApagarSetaJ
endForApagarSetaJ:

	addi $17, $17, 472
	addi $18, $18, -1	
	j forApagarSetaI
endForApagarSetaI:
	jr $31

###################################################	
# ===== ROTINA PARA PASSAR O TEMPO =====
# Entrada:
#	$5: tempo de duração
# Usa (sem preservar):
#	$25: tempo de duração
###################################################
gastarTempo:
	add $25, $0, $5
forGastarTempo:
	beq $25, $0, endForGastarTempo
	nop
	addi $25, $25, -1
	j forGastarTempo
endForGastarTempo:
	jr $31
	
# ===== ROTINA PARA TOCAR A MÚSICA =====
musica:
	jal musicaParte1
	jal musicaParte2
	jal musicaParte3
	jal musicaParte4
	jr $31
	
musicaParte1:
	addi $4, $0, 67		# Nota Sol
	addi $5, $0, 300
    	addi $6, $0, 26		# Instrumento
        addi $7, $0, 127	# Volume
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota Ré
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota Ré
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 72		# Nota Dó
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 1200
	addi $2, $0, 32
	syscall
	jr $31
	
musicaParte2:
	addi $4, $0, 67		# Nota Sol
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota Ré
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota Ré
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 72		# Nota si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota Dó
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 1200
	addi $2, $0, 32
	syscall
	jr $31
musicaParte3:
	addi $4, $0, 67		# Nota Sol
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 67		# Nota Sol
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota Si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota Ré
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 1200
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 74		# Nota ré
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 72		# Nota dó
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 67		# Nota sol
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 72		# Nota dó
	addi $5, $0, 1200
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 1200
	addi $2, $0, 32
	syscall
	jr $31
	
musicaParte4:
	addi $4, $0, 71		# Nota si
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 71		# Nota si
	addi $5, $0, 600
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 600
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 69		# Nota lá
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 67		# Nota sol
	addi $5, $0, 300
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 300
	addi $2, $0, 32
	syscall
	
	addi $4, $0, 67		# Nota sol
	addi $5, $0, 1200
	addi $2, $0, 31		
	syscall
	
	addi $4, $0, 1200
	addi $2, $0, 32
	syscall

	jr $31

