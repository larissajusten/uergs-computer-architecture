	
inicio:	IN 00
	CMP AL, 30
	JS inicio
	CMP AL, 3A
	JNS inicio
	INC DL
	CMP DL, 2
	JZ n2
	PUSH AL 
	POP BL
	JMP inicio

n2: 	PUSH AL
	POP CL
	SUB BL, 30
	SUB AL, 30
	SUB CL, 30

conta: 	MUL BL, CL
	PUSH BL
	POP CL
	DIV BL, 0A
	MOD CL, 0A
	SUB AL, AL	
	MOV AL, C0
	MOV [AL], BL
	INC AL
	MOV [AL], CL
	
	END
	

	