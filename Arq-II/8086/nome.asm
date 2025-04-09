section .data
; Iniciar variáveis com dados definidos.
msg_um        db    10,"Digite o primeiro valor: "
tam_msg_um    equ   $ - msg_um

msg_dois      db    10,"Digite o segundo valor: "
tam_msg_dois  equ   $ - msg_dois

msg_tres      db    10,"Resposta: "
tam_msg_tres  equ   $ - msg_tres

section .bss
; Alocar espaço para variáveis.
valor_um      resb    2
valor_dois    resb    2
resposta      resb    3

section .text
global _start
_start:
; Início do cógido do programa.

  mov byte[resposta + 2], 10

; Imprime a mensagem "Digite o primeiro valor: "
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_um
  mov edx, tam_msg_um
  int 0x80

; Faz a leitura do primeiro valor
  mov eax, 3
  mov ebx, 0
  mov ecx, valor_um
  mov edx, 2
  int 0x80

; Imprime a mensagem "Digite o segundo valor: "
  mov eax, 4
  mov ebx, 1
  mov ecx, msg_dois
  mov edx, tam_msg_dois
  int 0x80

; Faz a leitura do segundo valor
  mov eax, 3
  mov ebx, 0
  mov ecx, valor_dois
  mov edx, 2
  int 0x80

; Realizando a soma
; Todos os valores que são digitados pelo usuários, são lidos em ASCII.
; Portanto, se o usuário digitou '2', na variável estará armazenado o número 50, que é o '2' em ASCII.
; Dessa forma, devemos subtrair 0x30 do valor armazenado na variáver para conseguir realizar a soma devidamente.
; Lembrando que o valor está armazenado no primeiro byte da váriavel.

  mov al, byte[valor_um + 0]
  sub al, 0x30

  mov bl, byte[valor_dois + 0]
  sub bl, 0x30

; Depois que foi feita a subtração dos valores, podemos realizar a soma.

  add al, bl

; O resultado está armazenado em 'al' e agora devemos imprimí-lo.
; Para isso, devemos colocá-lo em ASCII novamente para que apareça na tela de forma correta.
; Entretanto, a soma de dois valores que possuem no máximo um dígito pode resultar em dois dígitos,
; exemplo: 9+9 = 18.
; Para resolver este problema, devemos dividir o valor por 10 para pegar o dígito da casa das dezenas.

  mov bl, 10      ; bl = 10
  div bl          ; al/bl

; Agora nós possuimos o valor do dígito da casa das dezenas em 'al', e o resto da divisão em 'ah'.
; O resto da divisão é o valor do dígito da casa das unidades.
; Exemplo: 18/10 = 1  resto = 8
; Agora podemos transformar em ASCII e mover para a variável 'resposta'.

  add al, 0x30
  add ah, 0x30

  mov byte[resposta + 0], al
  mov byte[resposta + 1], ah

; Agora o primeiro byte da variável 'resposta' possui o valor da casa das dezenas e
; o segundo byte da variável 'resposta' possui o valor da casa das unidades.
; A única tarefa que falta é imprimir o resultado na tela.
; Para isso devemos chamar a função para imprimir a resposta na tela.

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
  mov edx, 3
  int 0x80


fim:
  mov eax, 1
  int 0x80

