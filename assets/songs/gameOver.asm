.text
main:
	addi $4, $0, 1000 # 1s
	addi $2, $0, 32
	syscall
	
	jal gameOverMusic
	j end

gameOverMusic:
	# salva endereço de retorno
	addi $29, $29, -4
	sw   $31, 0($29)
	
	# D minor chord
	addi $4, $0, 38		# D3
	addi $5, $0, 700	# Tempo (milisegundos)
	addi $6, $0, 33		# Bass
	addi $7, $0, 120	# Volume
	addi $2, $0, 31
	syscall
	
	addi $4, $0, 41		# F3
	addi $2, $0, 31
	syscall

	addi $4, $0, 45		# A3
	addi $2, $0, 31
	syscall

	addi $4, $0, 700
	jal pausaMusica

	# C#5 chord
	addi $4, $0, 37		# C#3
	addi $2, $0, 31
	syscall

	addi $4, $0, 41		# F
	addi $2, $0, 31
	syscall

	addi $4, $0, 500
	jal pausaMusica

	# C4 chord
	addi $4, $0, 36		# C
	addi $5, $0, 1000	# Tempo (milisegundos)
	addi $2, $0, 31
	syscall

	addi $4, $0, 38		# E
	addi $2, $0, 31
	syscall

	addi $4, $0, 1000
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

