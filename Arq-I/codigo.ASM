	CLO
loop: 	
	in 00
	cmp al, 30 ; AL - 30(hex)
	js loop    ; se tiver sinal, volta loop
	cmp al, 3A ; AL - 3A(hex)
	jns loop   ; se nao ocorrer sinal, volta loop
	mov bl, c0 ; move BL para vdu(C0)
vdu: 	
	mov [bl], al
	inc bl
	inc al
	cmp al, 3A
	js vdu

	end