.text
main:

	lui $4, 0x1001		# posi inicial
	addi $5, $0, 256		# altura
	addi $6, $0, 512		# largura
	li $7, 0xff00ff
	jal desenharQuadrado
	
	jal clound
	

	j end

############################################
# === Rotina para desenhar clound ===
#	$4: endereço de início do desenho
# Usa (sem preservar):
#	$17: endereço local dos pixels
#	$18: preto
#
# De uma linha para outra soma 512
############################################
clound:
	add $17, $0, $4 	# endereço local dos pixels
	li $18, 0xcee3f5	# cor local
	li $19, 0xddefff
	
	sw $19, 36($17)
	sw $19, 40($17)
	sw $19, 44($17)
	sw $19, 48($17)
	sw $19, 52($17)
	sw $19, 56($17)
	sw $18, 60($17)
	addi $17, $17, 512
	
	sw $18, 28($17)
	sw $18, 32($17)
	sw $19, 36($17)
	sw $19, 40($17)
	sw $19, 44($17)
	sw $19, 48($17)
	sw $19, 52($17)
	sw $19, 56($17)
	sw $19, 60($17)
	sw $19, 64($17)
	sw $18, 68($17)
	sw $18, 72($17)
	
	sw $19, 92($17)
	sw $19, 96($17)
	sw $18, 100($17)
	
	addi $17, $17, 512
	sw $18, 20($17)
	sw $19, 24($17)
	sw $19, 28($17)
	sw $19, 32($17)
	sw $19, 36($17)
	sw $18, 40($17)
	sw $18, 44($17)
	
	sw $18, 56($17)
	sw $18, 60($17)
	sw $19, 64($17)
	sw $19, 68($17)
	sw $18, 72($17)
	sw $18, 76($17)
	
	sw $19, 88($17)
	sw $19, 92($17)
	sw $19, 96($17)
	sw $19, 100($17)
	sw $19, 104($17)
	sw $19, 108($17)
	sw $19, 112($17)
	sw $18, 116($17)
	sw $18, 120($17)
	
	addi $17, $17, 512
	sw $19, 12($17)
	sw $19, 16($17)
	sw $19, 20($17)
	sw $18, 24($17)
	sw $18, 28($17)

	sw $19, 68($17)
	sw $19, 72($17)
	sw $19, 76($17)
	sw $18, 80($17)
	sw $18, 84($17)
	sw $19, 88($17)
	sw $19, 92($17)
	sw $18, 96($17)
	sw $18, 100($17)
	sw $19, 104($17)
	sw $19, 108($17)
	sw $19, 112($17)
	sw $19, 116($17)
	sw $19, 120($17)
	sw $19, 124($17)
	sw $18, 128($17)
	
	addi $17, $17, 512
	
	sw $19, 4($17)
	sw $19, 8($17)
	sw $19, 12($17)
	sw $18, 16($17)
	
	sw $19, 76($17)
	sw $19, 80($17)
	sw $19, 84($17)
	sw $18, 88($17)
	sw $18, 92($17)
	
	sw $19, 124($17)
	sw $18, 128($17)
	sw $18, 132($17)
	
	add $17, $17, 512
	sw $19, 0($17)
	sw $19, 4($17)
	sw $19, 8($17)
	
	sw $19, 132($17)
	sw $19, 136($17)
	
	add $17, $17, 512
	sw $19, 0($17)
	sw $19, 136($17)
	
	jr $31

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
	beq  $9, $0, endForQuadrado	# se altura = 0 -> fim
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

end:
	addi $2, $0, 10
	syscall
