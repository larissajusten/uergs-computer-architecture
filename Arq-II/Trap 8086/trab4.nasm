;Guilherme, Larissa e Yuri Bonito

section .data

msg1		db    10,"Escolha a base do numero principal: ",10,"1 - Hexadecimal, 2 - Octal, 3 - Binario, 4 - Decimal",10,"Opção: ",0
tam_msg1	equ   $ - msg1

num1		db    10,"Digite o numero: ",0
tam_num1	equ   $ - num1

msg2		db    10,"Escolha a base do resultado: ",10,"1 - Hexadecimal, 2 - Octal, 3 - Binario, 4 - Decimal",10,"Opção: ",0
tam_msg2  	equ   $ - msg2

msgresult	db    10,"Resultado: "
tam_msgresult 	equ   $ - msgresult

b404		db    10,"Base Invalida! "
tam_b404	equ   $ - b404

section .bss
base_um		 resb	 2
numero		 resq	 3
base_dois	 resb	 2
resultado	 resb	 15

;variaveis auxiliares

deze		resq		15

vetDecHexa	resq		15
vetOct		resq		15
vetBi		resq 		15
vetDec		resq		15

vetHexa		resq		15
vetOcta		resq		15
vetBina		resq		15

section .text
global _start
_start:

mov byte[base_um + 1], 10
mov byte[base_dois + 1], 10

;Printa msg1 "BASE NUM PRINCIPAL"
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, tam_msg1
	int 0x80

;Scanf BASE PRINCIPAL
	mov eax, 3
	mov ebx, 0
	mov ecx, base_um
	mov edx, 2
	int 0x80

;Printa num1 "DIGITE O NUMERO"
	mov eax, 4
	mov ebx, 1
	mov ecx, num1
	mov edx, tam_num1
	int 0x80

;Scanf NUMERO PRINCIPAL
	mov eax, 3
	mov ebx, 0
	mov ecx, numero
	mov edx, 3
	int 0x80
base2:
;Printa  "DIGITE A BASE DO RESULTADO"
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, tam_msg2
	int 0x80

;Scanf BASE A BASE DO RESULTADO
	mov eax, 3
	mov ebx, 0
	mov ecx, base_dois
	mov edx, 2
	int 0x80


;Verifica a BASE PRINCIPAL

; move o que esta na variável base1 pra al 
; transforma 'al' em decimal
 
 	mov al, byte[base_um + 0]
	sub al, 0x30

;================[BASE1]================

;Hexadecimal
	cmp al, 1
	je Hex

;Octal
	cmp al, 2
	je Oct

;Binario
	cmp al, 3
	je Bin

;Decimal
	cmp al, 4
	je Dec
	jmp errorb1
	
;printa BASE INCORRETA 
errorb1:
	mov eax, 4
	mov ebx, 1
	mov ecx, b404
	mov edx, tam_b404
	int 0x80
	jmp _start

;faz cmp pra ver qual transformação fazer 

;================[HEXADECIMAL]================

; transforma hexadecimal em decimal

Hex:

;verifica se e [HEX - HEX] 

	mov bl, byte[base_dois +0]
	sub bl, 0x30
	cmp bl, 1	; Hex  - Hex
	je HHex

;se SIM, so move numero pra variavel resultado (label HHex)
;se NAO, transforma em decimal
		
		mov bx, 0x0
		mov bx, 1
		mov ecx, 0
		mov dx, 0

		parteHexD:

		mov ax, word[numero + ecx]
		cmp ax, 41
		je troca1
		cmp ax, 42
		je troca2
		cmp ax, 43
		je troca3 
		cmp ax, 44
		je troca4
		cmp ax, 45
		je troca5
		cmp ax, 46
		je troca6 

		voltaconver:

		mul bx
		add  dx, ax
		mov word[vetHexa+ecx], dx
		mov ax, bx
		mov bx, 16
		mul bx
		add dx, ax
		mov bx, dx
		mov dx, 0
		cmp ecx, 3
		je  salvabitH
		inc ecx
		mov ax, 0
		jmp parteHexD

		salvabitH:

 		mov ecx, 0
		mov bx, word[vetHexa+ecx]
		add dx,bx
		inc ecx
		cmp ecx, 4
		jne salvabitH
		mov word[vetHexa+0], dx
		jmp ascII
		
		troca1:

		mov ax, 10
		jmp voltaconver
		
		troca2:

		mov ax, 11
		jmp voltaconver
			
		troca3:

		mov ax, 12
		jmp voltaconver
				
		troca4:

		mov ax, 13
		jmp voltaconver
				
		troca5:

		mov ax, 14
		jmp voltaconver
				 
		troca6:

		mov ax, 15
		jmp voltaconver
		
; compara a BASE de SAIDA

	mov bl, byte[base_dois + 0]
	sub bl, 0x30

HOct:
	cmp bl, 2	; Hex  - (decimal) - Octal
	mov ecx, 1
	je DOct 

HBin:	
	cmp bl, 3	; Hex  - (decimal) - Binario
	mov ecx, 1
	je DBin

HDec:
	cmp bl, 4	; Hex - Decimal
	je ascII
	jmp base404
HHex:
	mov ax, [numero]
	mov [resultado], ax
	mov ax, 0x0
	jmp imp

;================[OCTAL]================

; transforma octal em decimal

Oct: 		
;verifica se e [OCT - OCT] 

	mov bl, byte[base_dois + 0]
	sub bl, 0x30
	cmp bl, 2	; Octal - Octal
	je OOct

;se SIM, so move numero pra variavel resultado (label OOct)
;se NAO, transforma em decimal
		
		mov bx, 0x0
		mov ecx, 0x0
		mov ax, [numero]
	oc:
		sub word[numero+ecx], 0x30
		inc ecx	
		cmp ecx, 19
		jne oc
		
		mov ax, 0x0
		mov bx, 1
		mov ecx, 0x0
		mov dx, 0x0

		parteOD:

		mov ax, word[numero+ecx]
		mul bx
		add  dx, ax
		mov word[vetOcta+ecx], dx
		mov ax, bx
		mov bx, 8
		mul bx
		add dx, ax
		mov bx, dx
		mov dx, 0
		cmp ecx, 4
		je  salvabitO
		inc ecx
		mov ax, 0
		jmp parteOD


		salvabitO:

 		mov ecx, 0
		mov bx, word[vetOcta+ecx]
		add dx,bx
		inc ecx
		cmp ecx, 5
		jne salvabitO
		mov word[vetOcta+0], dx

; compara a BASE de SAIDA

	mov bl, byte[base_dois + 0]
	sub bl, 0x30

;OHex
	cmp bl, 1	; Octal - (decimal) - Hex
	jne OBin
	mov ecx, 0x0
	mov ecx, 2
	jmp DHex

OBin: 
	cmp bl, 3	; Octal - (decimal) - Binario
	jne ODec
	mov ecx, 0x0
	mov ecx, 2
	jmp DBin

ODec:
	cmp bl, 4	; Octal - Decimal
	jmp ascII
	jne base404

OOct:
	mov ax, [numero]
	mov [resultado], ax
	mov ax, 0x0
	jmp imp

;================[BINARIO]================

;transforma binario em decimal

Bin:

;verifica se e [BIN - BIN] 

	mov bl, byte[base_dois + 0]
	sub bl, 0x30
	cmp bl, 3	; Binario - Binario
	je BBin

;se SIM, so move numero pra variavel resultado (je BBin)
;se NAO, transforma em decimal
	
		mov bl, 0x0
		mov ecx, 0x0
		mov ax, [numero]
	bi:
		sub word[numero+ecx], 0x30
		inc ecx	
		cmp ecx, 19
		jne bi
		
		mov ax, 0x0
		mov bx, 1
		mov ecx, 0
		mov dx, 0

		parteBD:

		mov ax, word[numero+ecx]
		mul bx
		add  dx, ax
		mov word[vetBina+ecx], dx
		mov ax,bx
		mov bx, 2
		mul bx
		add dx, ax
		mov bx, dx
		mov dx, 0
		cmp ecx,15
		je  salvabitB
		inc ecx
		mov ax, 0
		jmp parteBD

		salvabitB:

		mov ecx, 0
		mov bx,word[vetBina+ecx]
		add dx,bx
		inc ecx
		cmp ecx, 16
		jne salvabitB
		mov word[vetBina+0] , dx
		
; compara a BASE de SAIDA

	mov bl, byte[base_dois + 0]
	sub bl, 0x30

;BHex
	cmp bl, 1	; Binario - (decimal) - Hex
	je DHex

BOct:
	cmp bl, 2	; Binario - (decimal) - Octal
	je DOct

BDec:
	cmp bl, 4	; Binario - Decimal
	je ascII
	jmp base404

BBin:	
	mov ax, [numero]
	mov [resultado], ax
	mov ax, 0x0
	jmp imp

;================[DECIMAL]================
Dec:

;DHex
	cmp bl, 1	; Decimal - Hex
	jne DOct

;OctDecHex                    quando o numero vem de Octal
	cmp ecx, 2
	jne BinDecHex
	mov ax, 0x0
	mov ax, [vetOcta]
	mov [numero], ax
	mov ax, 0x0
	jmp DHex

BinDecHex:                   ;quando o numero vem de Binario
	cmp ecx, 3
	jne DHex
	mov ax, 0x0
	mov ax, [vetBina]
	mov [numero], ax
	mov ax, 0x0
	
DHex:

		mov ecx, 0
		mov bl, 16

		parteDH:

		mov ax, word[numero+ecx]
		div bl		
		cmp ax, 41
		je troc1
		cmp ax, 42
		je troc2
		cmp ax, 43
		je troc3 
		cmp ax, 44
		je troc4
		cmp ax, 45
		je troc5
		cmp ax, 46
		je troc6
		cmp dx, 41
		je troc1
		cmp dx, 42
		je troc2
		cmp dx, 43
		je troc3 
		cmp dx,44 
		je troc4
		cmp dx, 45
		je troc5    
		cmp dx, 46
		je troc6
	
		voltacon:

		cmp al, 10
		jae salvabitDH
		mov byte[vetDecHexa], ah 
		cmp ecx, 4
		je ascII
		inc ecx
		jmp parteDH

		salvabitDH:

		mov  byte[vetDecHexa], al

;move o resultado pro vetor [resultado]
		mov ax, 0x0
		mov ax, [vetDecHexa]
		mov [resultado], ax
		mov ax, 0x0
		jmp ascII	                                               ;jmp [ASCII]


		troc1:

		mov al, 0xa
		mov ah, 0xa
		jmp voltacon
		
		troc2:

		mov al, 0xb
		mov ah, 0xb
		jmp voltacon
			
		troc3:

		mov al, 0xc
		mov ah, 0xc
		jmp voltacon
				
		troc4:

		mov al, 0xd
		mov ah, 0xd
		jmp voltacon
				
		troc5:

		mov al, 0xe
		mov ah, 0xe
		jmp voltacon
				
		troc6:

		mov al, 0xf
		mov ah, 0xf
		jmp voltacon
	

DOct:
	cmp bl, 2	; Decimal - Octal
	jne DBin
	
;HexDecOctal                    quando o numero vem de Hexadecimal
	cmp ecx, 1
	jne BinDecOct
	mov ax, 0x0
	mov ax, [vetHexa]
	mov [numero], ax
	mov ax, 0x0
	jmp oct

BinDecOct:                       ;quando o numero vem de Binario
	mov ax, 0x0
	mov ax, [vetBina]
	mov [numero], ax
	mov ax, 0x0
		
oct:
		mov ecx,0
		mov ax,[vetOcta]
		mov [numero], ax
		mov ax, 0x0
		mov bl, 8	

		parteDO:		
		mov ax, word[numero+ecx]	
		div bl
		cmp al, 8
		jb salvabitDO
		mov byte[vetOct], ah 
		cmp ecx, 7
		je ascII
		inc ecx
		jmp parteDO

		salvabitDO:

		mov  byte[vetOct], al

;move o resultado pro vetor [resultado]
		mov ax, 0x0
		mov ax, [vetOct]
		mov [resultado], ax
		mov ax, 0x0
		jmp ascII                                               ;jmp [ASCII]

DBin:
	cmp bl, 3	
	je DDec

;HexDecBin                    quando o numero vem de Hexadecimal
	cmp ecx, 1
	jne OctDecBin
	mov ax, 0x0
	mov ax, [vetHexa]
	mov [numero], ax
	mov ax, 0x0
	jmp bin

OctDecBin:                    ;quando o numero vem de Octal
	mov ax, 0x0
	mov ax, [vetOcta]
	mov [numero], ax
	mov ax, 0x0

bin:

		mov bl, 2
		mov ecx, 0

		parteB:

		mov ax, word[numero+ecx]
		div bl
		cmp al, 1
		je salvabit
		mov byte[vetBi], ah 
		cmp ecx, 15
		je ascII
		inc ecx
		jmp parteB

	salvabit:

		mov byte[vetBi], al
;move o resultado pro vetor [resultado]
		mov ax, 0x0
		mov ax, [vetBi]
		mov [resultado], ax
		jmp ascII                                               ;jmp [ASCII]

DDec:
	cmp bl, 4	; Decimal - Decimal
	jne base404
	mov ax, [numero]
	mov [resultado], ax
	mov ax, 0x0
	jmp imp

;printa BASE INCORRETA 
base404:
	mov eax, 4
	mov ebx, 1
	mov ecx, b404
	mov edx, tam_b404
	int 0x80
	jmp base2

; ================[ASCII]================
;transforma em ascII
ascII:
	mov ecx, 15
asc:
	add word[resultado+ecx], 0x30
 	sub ecx, 1
	cmp ecx, 0
	jne asc
	jmp imp


; ================[RESULTADO]================

imp:

;printa a msg "O RESULTADO: "
	mov eax, 4
	mov ebx, 1
	mov ecx, msgresult
	mov edx, tam_msgresult
	int 0x80

;printa o RESULTADO
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 2
	int 0x80


