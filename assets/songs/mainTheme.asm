.text
main:
	addi $4, $0, 2000 # 2s
	addi $2, $0, 32
	syscall

	jal mainThemePt1
	jal mainThemePt2
	jal mainThemePt2
	j end

mainThemePt1:
	# salva endereço de retorno
	addi $29, $29, -4
	sw   $31, 0($29)
	# Configuração padrão
	addi $6, $0, 0       # Instrumento (0 = Piano)
	addi $7, $0, 120     # Volume

	# E4
	addi $4, $0, 64
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# F#4
	addi $4, $0, 66
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# G4
	addi $4, $0, 67
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica

	# E4
	addi $4, $0, 64
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica

	# B4
	addi $4, $0, 71
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica

	# E4
	addi $4, $0, 64
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# F#4
	addi $4, $0, 66
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# G4
	addi $4, $0, 67
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica

	# B4
	addi $4, $0, 71
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica
	
	# B4
	addi $4, $0, 71
	addi $5, $0, 600
	addi $2, $0, 31
	syscall
	addi $4, $0, 600
	jal pausaMusica

	# B4
	addi $4, $0, 71
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# C5
	addi $4, $0, 72
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# B4
	addi $4, $0, 71
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# A4
	addi $4, $0, 69
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# G4
	addi $4, $0, 67
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica

	addi $4, $0, 67
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# F#4
	addi $4, $0, 66
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica

	# E4 (final)
	addi $4, $0, 64
	addi $5, $0, 1000
	addi $2, $0, 31
	syscall
	addi $4, $0, 1000
	jal pausaMusica

	lw $31, 0($29)
	addi $29, $29, 4
	jr $31

mainThemePt2:
	# salva endereço de retorno
	addi $29, $29, -4
	sw   $31, 0($29)
	# Configuração padrão
	addi $6, $0, 0       # Instrumento (0 = Piano)
	addi $7, $0, 120     # Volume
  # E4
	addi $4, $0, 64
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# F#4
	addi $4, $0, 66
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# G4
	addi $4, $0, 67
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica
	# E4
	addi $4, $0, 64
	addi $5, $0, 400
	addi $2, $0, 31
	syscall
	addi $4, $0, 600
	jal pausaMusica
	# G4
	addi $4, $0, 67
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# A4
	addi $4, $0, 69
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# B4
	addi $4, $0, 71
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica
	# G4
	addi $4, $0, 67
	addi $5, $0, 400
	addi $2, $0, 31
	syscall
	addi $4, $0, 600
	jal pausaMusica
	# B4
	addi $4, $0, 71
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# C#5
	addi $4, $0, 73
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# D5
	addi $4, $0, 74
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# C#5
	addi $4, $0, 73
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# D5
	addi $4, $0, 74
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# C#5
	addi $4, $0, 73
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# D5
	addi $4, $0, 74
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# E5
	addi $4, $0, 76
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# D5
	addi $4, $0, 74
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# C#5
	addi $4, $0, 73
	addi $5, $0, 150
	addi $2, $0, 31
	syscall
	addi $4, $0, 150
	jal pausaMusica
	# E4
	addi $4, $0, 71
	addi $5, $0, 300
	addi $2, $0, 31
	syscall
	addi $4, $0, 300
	jal pausaMusica
	# E4
	addi $4, $0, 71
	addi $5, $0, 400
	addi $2, $0, 31
	syscall
	addi $4, $0, 600
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
