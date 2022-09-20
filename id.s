    .data
ID:     .asciz  "%d"
CMD:    .asciz  "%s"
enter:  .asciz  "\n"
PID:    .asciz  "%d\n"
p: .asciz "p"
error:  .asciz  "ERROR COMMAND"
start: .asciz  "*****Input ID*****\n"
input1: .asciz  "**Please Enter Member 1 ID:**\n"
input2: .asciz  "**Please Enter Member 2 ID:**\n"
input3: .asciz  "**Please Enter Member 3 ID:**\n"
end:   .asciz  "*****End Print*****\n"
command:    .asciz  "** Please Enter Command **\n"
output: .asciz  "*****Print Team Member ID and ID Summation*****\n"
output2:    .asciz  "ID Summation = "
num1:   .word 0
num2:   .word 0
num3:   .word 0
sum:    .word 0
inputcmd:   .word
    .text
    .globl  ID
    .globl  num1
    .globl  num2
    .globl  num3
    .globl  id
    .globl  sum
    .globl  output2
    .globl  PID
    .globl  p

id:
    ldr r4,=p
	stmfd  sp!,{lr}
	ldr r0,=start
	bl  printf

	ldr r0,=input1
	bl  printf
	ldr r0,=ID
	ldr r1,=num1
	bl scanf

	ldr r0,=input2
	bl  printf
	ldr r0,=ID
	ldr r1,=num2
	bl  scanf

	ldr r0,=input3
	bl  printf
	ldr r0,=ID
	ldr r1,=num3
	bl scanf

    ldr r0,=command
    bl  printf

	ldr r0,=CMD
	ldr r1,=inputcmd
	bl  scanf
	ldr r1,=inputcmd
    ldrb r3,[r1,#0]
    ldrb r2 ,[r4,#0]
    cmp r2,r3
    bne else

    ldr r0,=output
	bl  printf

    ldr r1,=num1
	ldr r1,[r1,#0]

	ldr r2,=num2
	ldr r2,[r2]

    adds r1,r1,r2

	ldr r2,=num3
	ldr r2,[r2]

    addnes r1,r1,r2
    ldr r3,=sum
    str r1,[r3]

    ldr r2,=num1
    ldr r1,[r2],#1
    ldr r0,=PID
    bl  printf

    ldr r2,=num2
    ldr r1,[r2],r2
    ldr r0,=PID
    bl  printf

    ldr r2,=num3
    ldr r1,[r2]
    ldr r0,=PID
    bl  printf

    ldr r0,=enter
	bl  printf

    ldr r0,=output2
    bl  printf

    ldr r2,=sum
    ldr r1,[r2]
    ldr r0,=PID
    bl  printf

	ldr r0,=end
	bl  printf

	ldr r0,=enter
	bl  printf

	mov r0,#0
	mov r1,#0
	mov r2,#0
	mov r3,#0
	mov r4,#0

	ldmfd   sp!,{lr}
	mov pc,lr

else:
    ldr r0,=error
    bl  printf
    ldmfd   sp!,{lr}
    mov pc,lr
    .end


