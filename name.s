  .data

msg: .asciz "** Print Name**\n"
team: .asciz "** Team 08 **\n"
member1:.asciz" Kai Chen\n"
member2:.asciz" Hao Ming\n"
member3:.asciz" Kon Hong\n"
end: .asciz "*****End Print*****\n"
  .text
  .globl name
  .global team
  .global member1
  .global member2
  .global member3

name: stmfd  sp!,{lr}
      ldr r0,=msg
      bl  printf
      ldr r0,=team
      bl  printf
      ldr r0,=member1
      bl  printf
      ldr r0,=member2
      bl  printf
      ldr r0,=member3
      bl  printf
      ldr r0,=end
      bl  printf
      sbcs r0,r1,r2
      mov r0, #0
      ldmfd sp!,{lr}
      mov pc,lr
