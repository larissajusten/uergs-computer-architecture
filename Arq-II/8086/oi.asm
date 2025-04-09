section .data
; Iniciar variáveis com dados definidos.

msg_um        db    10,"Digite o valor da base: "
tam_msg_um    equ   $ - msg_um

msg_dois      db    10,"Digite o valor do expoente: "
tam_msg_dois  equ   $ - msg_dois

msg_tres      db    10,"Resposta: "
tam_msg_tres  equ   $ - msg_tres

section .bss
; Alocar espaço para variáveis.
base  		 resb    4
expoente     	 resb    1
resposta     	 resb    5

section .text
global _start
_start:
; Início do cógido do programa.

 mov byte[resposta + 2], 10

; Imprime a mensagem "Digite o valor da base: "
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_um
  mov edx, tam_msg_um
  int 0x80

; Faz a leitura do primeiro valor
  mov eax, 3
  mov ebx, 0
  mov ecx, base
  mov edx, 2
  int 0x80

; Imprime a mensagem "Digite o valor do expoente: "
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_dois
  mov edx, tam_msg_dois
  int 0x80

; Faz a leitura do segundo valor
  mov eax, 3
  mov ebx, 0
  mov ecx, expoente
  mov edx, 2
  int 0x80

;Realizar a potencia
; Todos os valores que são digitados pelo usuários, são lidos em ASCII.
; Portanto, se o usuário digitou '2', na variável estará armazenado o número 50, que é o '2' em ASCII.
; Dessa forma, devemos subtrair 0x30 do valor armazenado na variáver para conseguir realizar a soma devidamente.
; Lembrando que o valor está armazenado no primeiro byte da váriavel.

  mov al, byte[base + 0]
  sub al, 0x30

; Em al se encontra a base ja em decimal.

  mov bl, byte[expoente + 0]
  sub bl, 0x30

; Em bl se encontra o expoente ja em decimal.

; Depois que foi feita a subtração dos valores, podemos realizar a potencia.

 mov cl, al
 dec bl

loop:
 mul cl
 dec bl
 cmp bl, 0
 jne loop
 mov dl, 4 
 div dl
 cmp al, 250
 jb comparacao

  mov cl, 100     ; cl = 100
  div cl          ; al/cl
  mov dl, ah 

 mov al, 1
 mul ah

  mov cl, 10    ; cl = 10
  div cl          ; al/cl
  add al,dl
  add al, 0x30
  mov byte[resposta + 0], al
  
 mov al, 1
 mul ah

  mov cl, 100     ; cl = 100
  div cl          ; al/cl
  add al, 0x30
  mov byte[resposta + 1], al

 mov al, 1
 mul ah
  	
  mov bl, 10      ; bl = 10
  div bl          ; al/bl
  add al, 0x30
  mov byte[resposta + 2], al

  add ah, 0x30
  mov byte[resposta + 3], ah
  mov byte[resposta + 4], 10
  jmp res



comparacao:
 cmp ax, 100
 jb if

  mov cl, 100     ; cl = 100
  div cl          ; al/cl
  add al, 0x30
  mov byte[resposta + 0], al

 mov al, 1
 mul ah
  	
  mov bl, 10      ; bl = 10
  div bl          ; al/bl
  add al, 0x30
  mov byte[resposta + 1], al

  add ah, 0x30
  mov byte[resposta + 2], ah
  mov byte[resposta + 3], 10
  jmp res

if:
  mov bl, 10      ; bl = 10
  div bl          ; al/bl
  add al, 0x30
  mov byte[resposta + 0], al
 
  add ah, 0x30
  mov byte[resposta + 1], ah
  mov byte[resposta + 2], 10

; Agora nós possuimos o valor do dígito da casa das dezenas em 'al', e o resto da divisão em 'ah'.
; O resto da divisão é o valor do dígito da casa das unidades.
; Exemplo: 18/10 = 1  resto = 8
; Agora podemos transformar em ASCII e mover para a variável 'resposta'.

;  add dl, 0x30
;  add dh, 0x30
;  add al, 0x30
;  add ah, 0x30

;  mov byte[resposta + 0], dl
;  mov byte[resposta + 1], dh
;  mov byte[resposta + 2], al
;  mov byte[resposta + 3], ah

; A única tarefa que falta é imprimir o resultado na tela.
; Para isso devemos chamar a função para imprimir a resposta na tela.

res:
; Imprime a mensagem "Resposta: "
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_tres
  mov edx, tam_msg_tres
  int 0x80

; Imprime a variável 'resposta'
  mov eax, 4
  mov ebx, 1
  mov ecx, resposta
  mov edx, 5
  int 0x80


fim:
  mov eax, 1
  int 0x80



