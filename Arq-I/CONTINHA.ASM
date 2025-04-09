	CLO

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
	SUB BL, 31
	SUB AL, 30
	SUB CL, 30
conta: 	ADD CL, AL
	SUB BL, 1
	JNZ conta
	PUSH CL
	POP AL
	MOV [C0], AL
	END
	

	