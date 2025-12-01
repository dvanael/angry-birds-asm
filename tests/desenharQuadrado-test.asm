.data

.text
main:

    lui $4, 0x1001          # endereço inicial (linha 0, coluna 0)
    ori $4, $4, 0x0000

    addi $5, $0, 256         # altura
    addi $6, $0, 512         # largura

    li $7, 0xFF0000       # cor vermelha

    jal desenharQuadrado

	li $7, 0x0000FF
desenharMem:
    add  $8, $0, $4     # endereço da linha atual
    add  $9, $0, $5     # contador de altura

forMem:
    beq  $9, $0, endForMemQ

    add  $10, $0, $6    # contador de largura
    add  $11, $0, $8    # pixel atual da linha

forLinhaMem:
    beq  $10, $0, endForMem

    sw   $7, 32768($11)      # bitmap inferior

    addi $11, $11, 4         # 1 pixel para direita
    addi $10, $10, -1
    j forLinhaMem

endForMem:
    addi $8, $8, 512        # desce 1 linha (CORRETO)
    addi $9, $9, -1
    j forMem

endForMemQ:


loadBuffer:
    la   $t0, 0x10010000      # destino (tela)
    la   $t1, 0x10018000      # origem (buffer)
    li   $t2, 131072         # número de pixels
copyLoop:
    beq  $t2, $zero, endCopy
    lw   $t3, 0($t1)
    sw   $t3, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $t1, 4
    addi $t2, $t2, -1
    j copyLoop
endCopy:


    j main                  # trava a tela


#######################################################################
# desenharQuadrado
#######################################################################
# Entradas:
#   $4 = endereço inicial
#   $5 = altura
#   $6 = largura
#   $7 = cor
#
# Usa: $8 $9 $10 $11
#
# Display layout:
#   pixel à direita = +4 bytes
#   pixel abaixo    = +2048 bytes  (512 * 4)
#######################################################################

desenharQuadrado:
    add  $8, $0, $4     # endereço da linha atual
    add  $9, $0, $5     # contador de altura

forQuadrado:
    beq  $9, $0, endForQuadrado

    add  $10, $0, $6    # contador de largura
    add  $11, $0, $8    # pixel atual da linha

forLinha:
    beq  $10, $0, endForLinha

    sw   $7, 0($11)          # azul (bitmap superior)
    sw   $7, 32768($11)      # verde (bitmap inferior)

    addi $11, $11, 4         # 1 pixel para direita
    addi $10, $10, -1
    j forLinha

endForLinha:
    addi $8, $8, 512        # desce 1 linha (CORRETO)
    addi $9, $9, -1
    j forQuadrado

endForQuadrado:
    jr $31

