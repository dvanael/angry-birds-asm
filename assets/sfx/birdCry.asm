.text
main:
	addi $4, $0, 1000 # 1s
	addi $2, $0, 32
	syscall

	jal birdCry
	j end

birdCry:
	# salva endereço de retorno
	addi $29, $29, -4
	sw   $31, 0($29)

	addi $6, $0, 30		# Guitar
	addi $7, $0, 60	# Volume
	# (C#5 C#5)
	addi $4, $0, 73
	addi $5, $0, 50
	addi $2, $0, 31
	syscall
	addi $4, $0, 73
	addi $2, $0, 31
	syscall
	addi $4, $0, 50
	jal pausaMusica

	# D#5
	addi $4, $0, 75
	addi $5, $0, 50
	addi $2, $0, 31
	syscall
	addi $4, $0, 50
	jal pausaMusica

	# (F#5 D#5)
	addi $4, $0, 78
	addi $5, $0, 70
	addi $2, $0, 31
	syscall
	addi $4, $0, 75
	addi $2, $0, 31
	syscall
	addi $4, $0, 7
	jal pausaMusica

	#
	addi $4, $0, 36
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	lw   $31, 0($29)
	addi $29, $29, 4
	jr $31

# -----------------------------
# Rotina de pausa
# Entrada:
#   $4 = tempo em ms
# -----------------------------
pausaMusica:
	addi $2, $0, 32
	syscall
	jr $31

end:
	addi $2, $0, 10
	syscall

