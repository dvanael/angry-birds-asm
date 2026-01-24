.text
main:
	lui $4, 0x1001		# posi inicial
	addi $5, $0, 256	# altura
	addi $6, $0, 512	# largura
	li $7, 0xff00ff
	jal desenharQuadrado
	
	jal grass

	j end

############################################
# === Rotina para desenhar grass ===
#	$4: endereço de início do desenho
# Usa (sem preservar):
#	$17: endereço local dos pixels
#	$18: preto
#
# De uma linha para outra soma 512
############################################
grass:
	add $17, $0, $4 	# endereço local dos pixels
	li $18, 0x01031a	# cor local
	li $19, 0x035904
	li $20, 0x35c527
	li $21, 0x67e60f
	
	sw $19, 24($17)
	sw $19, 28($17)
	addi $17, $17, 512
	
	sw $19, 20($17)
	sw $21, 24($17)
	sw $21, 32($17)
	addi $17, $17, 512
	
	sw $21, 20($17)
	sw $20, 24($17)
	addi $17, $17, 512

	sw $19, 12($17)
	sw $21, 20($17)
	sw $20, 24($17)
	addi $17, $17, 512
	
	sw $19, 12($17)
	sw $18, 16($17)
	sw $21, 20($17)
	sw $20, 24($17)
	sw $20, 32($17)
	sw $21, 36($17)
	addi $17, $17, 512
	
	sw $18 8($17)
	sw $21, 12($17)
	sw $19, 16($17)
	sw $21, 20($17)
	sw $20, 24($17)
	sw $18, 28($17)
	sw $20, 32($17)
	sw $18, 36($17)

	addi $17, $17, 512
	sw $21, 12($17)
	sw $21, 16($17)
	sw $21, 20($17)
	sw $21, 24($17)
	sw $20, 28($17)
	
	addi $17, $17, 512
	sw $18, 16($17)
	sw $21, 20($17)
	sw $20, 24($17)
	sw $18, 28($17)
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
