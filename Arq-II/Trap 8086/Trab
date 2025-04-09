;Guilherme e Larissa
section .data

msg1		db    10,"Escolha a base do numero principal",10,"1 - Hexadecimal, 2 - Octal, 3 - Binario, 4 - Decimal",10,"Opção: ",0
tam_msg1	equ   $ - msg1

num1		db    10,"Digite o numero: "
tam_num1	equ   $ - num1

msg2		db    10,"Escolha a base do resultado: ",10,"1 - Hexadecimal, 2 - Octal, 3 - Binario, 4 - Decimal",10,"Opção: ",0
tam_msg2  	equ   $ - msg2

msgresult	db    10,"Resultado: "
tam_msgresult 	equ   $ - msgresult

b404		db    10,"Base Invalida! "
tam_b404	equ   $ - b404

section .bss
base1		 resb	 1
num1		 resb    3
base2		 resb	 1
resultado   	 resb    6

section .text
global _start
_start:

;Printa msg1 "BASE NUM PRINCIPAL"
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, tam_msg1
	int 0x80

;Scanf BASE PRINCIPAL
	mov eax, 3
	mov ebx, 0
	mov ecx, base1
	mov edx, 1
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
	mov ecx, num1
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
	mov ecx, base2
	mov edx, 1
	int 0x80


;Verifica a BASE PRINCIPAL

; move o que esta na variável base1 pra al 
; transforma 'al' em decimal
 
 	mov al, byte[base1 + 0]
	sub al, 0x30

	mov bl, byte[base2 + 0]
	sub bl, 0x30

; faz as comparações pra saber qual a BASE selecionada

	cmp al, 1
	jne Oct
	jmp Hex
Oct:	
	cmp al, 2
	jne Bin
	jmp Oct
Bin:
	cmp al, 3
	jne Dec	
	jmp Bin
Dec:
	cmp al, 4
	jne errorb1
	jmp Dec
	
;printa BASE INCORRETA 
errorb1:
	mov eax, 4
	mov ebx, 1
	mov ecx, b404
	mov edx, tam_b404
	int 0x80
	jmp _start

;faz cmp pra ver qual transformação fazer 

; COMPARAÇÕES com HEXADECIMAL
Hex:
	cmp bl, 1	; Hex - Hex
	jne HOct
	jmp outHex
HOct:
	cmp bl, 2	; Hex - Octal
	jne HBin 
	-
	jmp ascII

HBin:	
	cmp bl, 3	; Hex - Binario
	jne HDec
	-
	jmp ascII

HDec:	
	cmp bl, 4	; Hex - Decimal
	jne 404
	-
	jmp ascII

404:
	jmp base404

; COMPARAÇÕES com OCTAL
Oct: 
	cmp bl, 1	; Octal - Hex
	jne OOct
	-
	jmp ascII

OOct:
	cmp bl, 2	; Octal - Octal
	jne OBin
	jmp outOct

OBin:
	cmp bl, 3	; Octal - Binario
	jne ODec
	-
	jmp ascII

ODec:
	cmp bl, 4	; Octal - Decimal
	jne 404
	-
	jmp ascII

404:
	jmp base404

; COMPARAÇÕES com BINARIO
Bin:
	cmp bl, 1	; Binario - Hex
	jne BOct
	-
	jmp ascII

BOct:
	cmp bl, 2	; Binario - Octal
	jne BBin
	-
	jmp ascII

BBin:
	cmp bl, 3	; Binario - Binario
	jne BDec
	jmp outBin

BDec:
	cmp bl, 4	; Binario - Decimal
	jne 404
	-
	jmp ascII

404:	jmp base404

; COMPARAÇÕES com DECIMAL
Dec:
	cmp bl, 1	; Decimal - Hex
	jne DOct
	-
	jmp ascII

DOct:
	cmp bl, 2	; Decimal - Octal
	jne DBin
	-
	jmp ascII

DBin:
	cmp bl, 3	; Decimal - Binario
	jne DDec
	-
	jmp ascII

DDec:
	cmp bl, 4	; Decimal - Decimal
	jne base404
	jmp outDec

;printa BASE INCORRETA 
base404:
	mov eax, 4
	mov ebx, 1
	mov ecx, b404
	mov edx, tam_b404
	int 0x80
	jmp _base2

;transforma em ASCII para printar na tela
ascII:
	


;printa o RESULTADO

outHex:

outOct:

outBin:

outDec:

		


