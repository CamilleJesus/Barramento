# Problema 3 - Barramento (TEC499 - MI  Sistemas Digitais P01)
# Programa: Códigos de Validação do Processador
# Equipe: Camille Jesus, Pedro Gomes e Sarah Pereira
# Data: 28/11/17

.data
vetor: .skip 300
pilha: .skip 10

#Definição de constantes:
.equ Switches, 0x9080
.equ Button, 0x9070
.equ RxData, 0x9000
.equ TxData, 0x9004
.equ FlagUART0, 0x9008

.text

.global _start


_start:
	movia r2, Switches
	movia r3, Button
	movia r13, RxData
	movia r14, TxData
	movia r9, FlagUART0

zera:
	mov r6, r0
	mov r7, r0
	mov r8, r0
	mov r10, r0
	mov r11, r0
	mov r12, r0
	mov r15, r0
	mov r16, r0
	mov r17, r0
	mov r18, r0
	mov r19, r0
	mov r20, r0
	mov r21, r0
	mov r22, r0

loop:
	ldwio r4, 0(r3)
	beq r4, r0, loop
	ldwio r4, 0(r2)

options:
	beq r4, r0, anoBissexto
	movi r5, 1
	beq r4, r5, bubbleSort
	movi r5, 2
	beq r4, r5, fatorial
	movi r5, 4
	beq r4, r5, geradorPrimos
	movi r5, 8
	beq r4, r5, sequenciaFibonacci

anoBissexto:
	movi r20, 32
	movi r19, 0x2c 
	movi r12, 128

	num0:	
		ldw r2, 0(r9)
		and r2, r2, r12
		bne r2, r12, num0   #Repete enquanto não recebe dado serial.
		br recebe_dado0   #Se recebeu, desvia para recebe_dado.

	#Rotina que transforma o ASCII recebido em decimal e junta dígitos de um mesmo número:
	pega_digito0:
		muli r10, r10, 10
		mov r11, r2
		subi r11, r11, 48
		add r10, r10, r11
		call num0

	recebe_dado0:
		ldw r2, 0(r13)
		beq r2, r20, guarda_num0   #Se recebeu espaço, desvia para guarda_num.
		beq r2, r19, guarda_num0   #Se não, se recebeu enter, desvia para guarda_num.
		br pega_digito0   #Se não, desvia para pega_digito.
	
	guarda_num0:	
		mov r5, r10   #Atribui à  ano o número recebido.
		call verifica   #Chama a verificão de ano bissexto.
      
	verifica:
	    movi r6, 4   #Primeiro divisor: 4.
	    call resto_divisao   #Calcula o resto da divisão por 4.
		beq r7, r0, verifica2   #Primeira condição: se resto da divisão por 4 for igual a 0, chama a segunda condição.
		br nao_bissexto   #Se não, NÃO É BISSEXTO.
		
	verifica2:
		movi r6, 400   #Segundo divisor: 400.
		call resto_divisao   #Calcula o resto da divisão por 400.
		beq r7, r0, bissexto   #Segunda condição: se resto da divisão por 400 for igual a 0, É BISSEXTO.
		br verifica3   #Se não, chama a terceira condição.

	verifica3:
		movi r6, 100   #Terceiro divisor: 100.
		call resto_divisao   #Calcula o resto da divisão por 100.
		bne r7, r0, bissexto   #Terceira condição: se resto da divisão por 100 não for igual a 0, É BISSEXTO.
		br nao_bissexto   #Se não, NÃO É BISSEXTO.
		
	#Rotina que calcula o resto da divisão:
	resto_divisao:
		div r7, r5, r6
		mul r7, r7, r6
		sub r7, r5, r7
		ret
			
	#SE NÃO FOR BISSEXTO:
	nao_bissexto:
		movi r8, 0   #Zera o registrador de resultado.
		
		addi r4, r0, 0x4e
		stw r4, 0(r14)
		
		addi r4, r0, 0xe3
		stw r4, 0(r14)
		
		addi r4, r0, 0x6f
		stw r4, 0(r14)
		
		call _start   #Finaliza execução.
		
	#SE FOR BISSEXTO:
	bissexto:
		movi r8, 1   #Coloca 1 no registrador de resultado.
		
		addi r4, r0, 0x53
		stw r4, 0(r14)
		
		addi r4, r0, 0xb69
		stw r4, 0(r14)
		
		addi r4, r0, 0x6d
		stw r4, 0(r14)
		
		call _start   #Finaliza execução.

bubbleSort:
	movia r7, vetor	
	movi r20, 32
	movi r19, 0x2c
	movi r6, 0
	movi r21, 0
	movi r3, 128 
	
	num1:		
		ldw r2, 0(r9)
		and r2, r2, r3
		bne r2, r3, num1
		br loop1
		
	pega_digito1:
		muli r6, r6, 10
		add r8, r0, r2
		subi r8, r8, 48
		add r6, r6, r8
		call num1
		
	loop1:
		ldw r2, 0(r13)
		beq r2, r20, guarda_num1
		beq r2, r19, guarda_num1
		br pega_digito1
	
	guarda_num1:
		stw r6, 0(r7)
		addi r7, r7, 4
		addi r6, r0, 0
		addi r21, r21, 1
		bne r2, r19, num1
	
	begin:
		addi r6, r0, 0
		movia r7, vetor				#Pega endereço de memória do vetor

		
		add r16, r0, r21			#i = tamanho -1
		#subi k, k, 1
		
		addi r22, r0, 1				# j = 0
		
		beq r21, r22, _start
	
	sort:				
		ldw r10, 0(r7)			#Pega elemento na posiçao j
		mov r15, r7			#Pega o endereço de memória de j
		
		addi r7, r7, 4			#Passa para o endereço de memoria j+1
		
		ldw r11, 0(r7)			#Pega próximo elemento
			
		bgt r10, r11, troca		#Se ant > que prox troca
			
		br atualiza_j
		
	troca:
		add r12, r10, r0			#Pega valor de ant e joga em aux
		
						
		stw r11, 0(r15)		#Escreve no endereço do anterior o próximo
		stw r10, 0(r7)			#Escreve no endereço do próximo o anterior
		
		add r10, r11, r0		#Troca os valores nos registradores
		add r11, r12, r0
		
	
	atualiza_j:
		
		addi r22, r22, 1			#Atualiza j
		
		bgt r21, r22, sort	#Se j<tamanho continua
		br atualiza_k			#Se não atualiza k
				
	atualiza_k:
		
		subi r16, r16 , 1
		addi r22, r0, 1
		movia r7, vetor	
		bgt r16, r0, sort
		movia r7, vetor	
		addi r16, r0, 0			
		br impressao1
			
	impressao1:	
		ldw r4, 0(r7)			#pega o valor da memoria
		subi sp, sp, 4			#Subtrai o topo da pilha
 		addi r17, r0, 10		#Bota 10 para r17
 		addi r9, r0, 0			#Contador em r18
		addi r7, r7, 4			#Próximo endereço da memória
		addi r16, r16, 1			# Atualizar contador de k
		call imp1			#chama impressão
		
		movi r4, 0x2C				#armazena o hexadecimal correspondente a virgula
		stw r4, 0(r14)
		bgt r21, r16, impressao1
		br _start
 		
 	imp1:
 		div r13,r4, r17		#divide r4 por 10	
 		beq r4, r0, imp12	# se r4 for igual a 0 imp2
 		addi r9, r9, 1	#aumenta contador
 		mul r19, r13, r17	#multiplica por 10
 		sub r19, r4,r19		# subtrai pra encontrar o resto
 		
 		stw r19, 0(sp)		#grava o resto na pilha
 		subi sp, sp, 4		#proxima endereço da pilha
 		

 		add r4, r0, r13         #atualiza r4
 		br imp1
 	
 	imp12:
 		subi r9, r9, 1
 		addi sp, sp, 4
 		ldw r19, 0(sp)
 		addi r19, r19, 48
 		stw r19, 0(r14)
 		bne r9, r0, imp12
		ret

fatorial:
	movi r11, 128
	movi r20, 32
	movi r19, 0x2c
	movi r6, 0
	
	num2:	
		ldw r2, 0(r9)				#Ler Ready
		and r2, r2, r11				#Faz uma and com o equivalente ao bit ativo de leitura
		bne r2, r11, num2		
		br loop2
		
	pega_digito2:
		muli r6, r6, 10
		add r8, r0, r2
		subi r8, r8, 48
		add r6, r6, r8
		call num2
	
	
	loop2:
		ldw r2, 0(r13)
		beq r2, r20, guarda_num2
		beq r2, r19, guarda_num2
		br pega_digito2
	
	guarda_num2:	
		call ini

	ini:		
		movi r4, 1
		call stack #chama a pilha
		call print
		br _start


	calcular_fatorial:		
		subi r6, r6, 1
		call stack
		ldw r6, 0(sp)
		ldw ra, 4(sp)
		addi sp, sp, 8
		mul r7, r7, r6
		ret

	stack:
		subi sp, sp, 8	#
		stw ra, 4(sp)	#		
		stw r6, 0(sp) 	#guarda r6 no vetor
		bgt r6, r4, calcular_fatorial#(if r6 > r4)
		addi r7, r0, 1
		addi sp, sp, 8
		ret

	print:  #printa o resultado
 		mov r4, r7 #passa o resultado que está em r7 para o tx(r4)
 		addi r9, r0, 10
 		addi r2, r0, 0
 		subi sp, sp, 8
 		
 	imp:
 		div r6,r7, r9			
 		beq r7, r0, imp2
 		addi r2, r2, 1
 		mul r4, r6, r9
 		sub r4, r7,r4
 		
 		add r8, r4, r0
 		stw r8, 0(sp)
 		subi sp, sp, 4
 		
 		add r7, r0, r6
 		br imp
 	
 	imp2:
 		subi r2, r2, 1
 		addi sp, sp, 4
 		ldw r4, 0(sp)
 		addi r4, r4, 48
 		stw r4, 0(r14)
 		bne r2, r0, imp2

geradorPrimos:
	movi r20, 32
	movi r19, 0x2c
	movi r6, 0
	movi r11, 0
	movi r3, 128
	
	num4:		
		ldw r2, 0(r9)				#Ler Ready
		and r2,r2,r3				#Faz uma and com o equivalente ao bit ativo de leitura
		bne r2, r3, num4	
		br loop4
		
	pega_digito4:
		muli r6, r6, 10
		add r8, r0, r2
		subi r8, r8, 48
		add r6, r6, r8
		call num4
	
	loop4:
		ldw r2, 0(r13)
		beq r2, r20, guarda_num4
		beq r2, r19, guarda_num4
		br pega_digito4
	
	guarda_num4:
		beq r11,r0, guarda_num42
		br inicializacao
		
	guarda_num42:
		add r12, r0, r6
		addi r11, r11, 1
		addi r6, r0, 0
		call num4

	inicializacao:
		add r11, r10, r6				#Guarda o limite superior em r3
		#addi limite_inferior,r0,2			#Guarda o limite inferior em r2
		addi r10, r0,2
		add r6, r0, r10 				#Inicia o divisor em 2
		div r8, r11, r10		#Pega a metade do dividendo
	
	verifica_se_primo:	
		div r7, r11, r6		#Pega o quociente da divisao
		mul r7, r7, r6			#Multiplica o quociente da divisão pelo divisor
		sub r7, r11, r7		#Subtrai o dividendo pela multiplicação do quociente pelo divisor, para pega o valor do resto
		bne r7, r0, atualiza_divisor		#Se o resto for diferente de 0 atualiza o divisor
		br atualizar_dividendo			#O número não é primo, atualiza do dividendo
				
	atualiza_divisor:
		addi r6, r6, 1				#Aumenta dividor
		bgt r8, r6, verifica_se_primo		#Verifica se o divisor é menor ou igual a metade do dividendo
									#OBS: UM NÚMERO NÃO É DIVISIVEL POR NÚMEROS MAIOR QUE SUA METADE
		#bgt dividendo,divisor, verifica_se_primo #Verifica se o dividendo é maior que o divisor/contado
		br impressao4
		
	impressao4: 
		add r4, r0, r11
		subi sp, sp, 8
 		addi r17, r0, 10
 		addi r18, r0, 0

 	imp4:
 		div r16,r4, r17			
 		beq r4, r0, imp42
 		addi r18, r18, 1
 		mul r19, r16, r17
 		sub r19, r4,r19
 		
 		stw r19, 0(sp)
 		subi sp, sp, 4
 		
 		add r4, r0, r16
 		br imp4
 	
 	imp42:
 		subi r18, r18, 1
 		addi sp, sp, 4
 		ldw r19, 0(sp)
 		addi r19, r19, 48
 		stw r19, 0(r14)
 		bne r18, r0, imp42
		
		stw r20, 0(r14)
		call atualizar_dividendo					#Atualiza do dividendo
	
	atualizar_dividendo:

		addi r11, r11, -1				#Diminui o dividendo
		beq r11, r10, impressao4
		
		addi r6,r0,2					#Reseta o divisor
		div r8, r11, r10			#Atualiza a metade do dividendo
		
		bgt r10, r11, _start
		bgt r11, r12, verifica_se_primo		#Se o dividendo é maior que o limite inferior, continua a busca por mais números primos

sequenciaFibonacci:
	movi r15, 1   #Inicializa a sequência com termo 1.
	movi r20, 32
	movi r19, 0x2c
	movia r12, pilha
	movi r11, 128
	
	num8:		
		ldw r2, 0(r9)
		and r2, r2, r11
		bne r2, r11, num8
		br recebe_dado8   #Se recebeu, desvia para recebe_dado.
		
	#Rotina que transforma o ASCII recebido em decimal e junta dígitos de um mesmo número:
	pega_digito8:
		muli r6, r6, 10
		mov r8, r2
		subi r8, r8, 48
		add r6, r6, r8
		call num8
		
	recebe_dado8:
		ldw r2, 0(r13)
		beq r2, r20, inicio   #Se recebeu espaço, desvia para inicio.
		beq r2, r19, inicio   #Se não, se recebeu enter, desvia para inicio.
		br pega_digito8   #Se não, desvia para pega_digito.
	
	inicio:
		mov r10, r15   #Valor do termo atual é atribuído à r10.
		movi r8, 1   #Coloca 1 em r8.
		call fib   #Verifica se necessário cálculo do fibonacci.
		
		mov r4, r1   #Valor do termo atual da sequência.

		addi r17, r0, 10
		addi r18, r0, 0
	
 	imp8:
 		div r16,r4, r17			
 		beq r4, r0, imp82
 		addi r18, r18, 1
 		mul r19, r16, r17
 		sub r19, r4,r19
 		
 		stw r19, 0(r12)
 		addi r12, r12, 4
 		

 		add r4, r0, r16
 		br imp8
 	
 	imp82:
 		subi r18, r18, 1
 		subi r12, r12, 4
 		ldw r19, 0(r12)
 		addi r19, r19, 48
 		stw r19, 0(r14)
 		bne r18, r0, imp82
		
		stw r20, 0(r14)
		    	  
    	addi r15, r15, 1   #Incrementa o termo atual.
    	bge r6, r15, inicio   #Se o termo limite for maior que o termo atual, continua gerando.
		br _start   #Se não, finaliza execução.
    	   	      
	fib:
		bgt r10, r8, fibonacci   #Se o valor do termo atual for maior que 1, calcula fibonacci.
		mov r1, r10   #Se não, coloca em r1 o termo atual.
		ret   #Retorna.
	      
	fibonacci:
	  	subi sp, sp, 12   #Reserva-se 3 espaços na pilha.
	  	stw ra, 0(sp)   #No primeiro é colocado o endereço de retorno.
	  	stw r10, 4(sp)   #No segundo o termo atual.
	  	
	 	subi r10, r10, 1   #Subtrai-se 1 do termo atual.
	  	call fib   #Verifica se necessário cálculo do fibonacci.
	  	
	  	ldw r10, 4(sp)   #Carrega em r10 o termo atual.
		stw r1, 8(sp)   #Armazena no terceiro espaço o valor do termo corrente.
	            
		subi r10, r10, 2   #Subtrai-se 2 do termo atual.
		call fib   #Verifica se necessário cálculo do fibonacci.
	      
		ldw r5, 8(sp)   #Carrega em r5 o valor do termo atual.
		add r1, r5, r1   #Soma o valor do termo atual ao valor do termo anterior.
	      
		ldw ra, 0(sp)   #Carrega o endereço de retorno salvo em ra.
		addi sp, sp, 12   #Reseta pilha.
		ret   #Retorna.
	
end:
	.end
