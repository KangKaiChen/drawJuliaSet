.data

f1: .asciz "** Please Enter Member 1 ID:**\n"
f2: .asciz "** Please Enter Member 2 ID:**\n"
f3: .asciz "** Please Enter Member 3 ID:**\n"
f4: .asciz "** Please Enter Command**\n"
start: .asciz "*****Input ID*****\n"
middle: .asciz "*****Print Team Member ID and ID Summation*****\n"
end: .asciz "*****End Print*****\n"
member: .asciz "%d"
format2: .asciz "%s"
Sum: .asciz "ID Summation = %d\n"
output: .asciz "%d\n"
output2: .asciz "%s\n"
command: .asciz ""
p: .asciz "p"
enter: .asciz "\n\n"
ID1: .word 0
ID2: .word 0
ID3: .word 0
IDtotal: .word 0
  .text
  .global id
  .global ID1
  .global Sum
  .global ID2
  .global ID3
  .global IDtotal
  .global end
  .extern printf
  .extern scanf
id: stmfd sp!,{lr}
    ldr  r4, =p
    ldr  r0, =start
    bl   printf
    ldr  r0, =f1
    bl   printf
    ldr  r0, =member
    ldr  r1, =ID1
    bl   scanf
    ldr  r0, =f2
    bl   printf
    ldr  r0, =member
    ldr  r1, =ID2
    bl   scanf
    ldr  r0, =f3
    bl   printf
    ldr  r0, =member
    ldr  r1, =ID3
    bl   scanf
    ldr  r0, =f4
    bl   printf
    ldr  r1, =ID1
    ldr  r1,[r1]
    ldr  r2, =ID2
    ldr  r2,[r2]
    add r1,r1,r2
    ldr  r2, =ID3
    ldr  r2,[r2]
    add r1,r1,r2
    ldr  r3, =IDtotal
    str  r1,[r3]
    ldr  r0, =format2
    ldr  r1, =command
    bl   scanf
    ldr  r1, =command
    ldrb r2,[r1,#0]
    ldrb r3,[r4,#0]
    cmp  r2, r3
    ldmfd sp!,{lr}
    moveq pc, lr
    stmfd sp!,{lr}
    ldr  r0, =middle
    bl   printf
    ldr  r2, =ID1
    ldr  r1,[r2],#1
    ldr  r0, =output
    bl   printf
    ldr  r2, =ID2
    ldr  r1,[r2],r2
    ldr  r0, =output
    bl   printf
    ldr  r1, =ID3
    ldr  r1,[r1]
    ldr  r0, =output
    bl   printf
    ldr  r0, =enter
    bl   printf
    ldr  r1, =IDtotal
    ldr  r1,[r1]
    ldr  r0, =Sum
    bl   printf
    ldr  r0, =end
    bl   printf

    ldmfd sp!,{lr}
    mov   pc,lr

