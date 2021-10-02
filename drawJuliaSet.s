.data
num1:	.word  1500
num2:	.word  1000
num3:	.word  4000000
num4:	.word  255
cx:		.word  0
cy:		.word  0
width:  .word  0
height: .word  0
x: 		.word  0
y:		.word  0
i:		.word  0
zx:		.word  0
zy:		.word  0
color:  .word  0
frame:	.word  0
tmp:    .word  0
int:    .asciz "%d\n"
.text
.globl drawJuliaSet
drawJuliaSet:
				ldr r4,=cx
				str r0,[r4]			@cx
				ldr r4,=cy
				str r1,[r4]			@cy
				ldr r4,=width
				str r2,[r4]			@width
				ldr r4,=height
				str r3,[r4]			@height
				ldr r4,=frame
				str	sp,[r4]			@frame
				stmfd	sp!,{lr}
				mov r4,r14
				mov r0,#0
				adds   r14,r14,r0
				mov r14,r4
for1:
				ldr r0,=x
				ldr r0,[r0]
				ldr r1,=width
				ldr r1,[r1]
				cmp	r0,r1			@(x,width)
				bge	 end 			@(x>=width)
for2:
				ldr r0,=y
				ldr r0,[r0]
				ldr r1,=height
				ldr r1,[r1]
				cmp	r0,r1			@(y,height)
				movge	r0,#0		@  >=的話 (y= 0 )
				ldr	r1,=y
				str r0,[r1]
				ldr r1,=x
				ldr r0,[r1]
				addge	r0, r0, #1	@ >=	(x+1)
				str r0,[r1]
				bge	for1			@(y>=height)
				ldr r3,=width
				ldr r3,[r3]
				mov	r3, r3, lsr #1	@width>>1
				ldr	r2,=x			@r2=x
				ldr r2,[r2]
				sub	r3, r2, r3		@x-(width>>1)
				ldr r1,=num1		@r1=1500
				ldr r1,[r1]
				mul r0,r1,r3		@r0=1500*(x-(width>>1))
				ldr	r3,=width 		@r3=width
				ldr r3,[r3]
				mov r2,#1
				mov	r1, r3, lsr r2	@r1=width>>1
				bl	__aeabi_idiv	@r0/r1
				ldr r1,=zx			@zx
				str r0,[r1]			@zx=1500*(x-(width>>1))/(width>>1)
				ldr	r3,=height
				ldr r3,[r3]
				mov	r3, r3, lsr #1	@r3=height>>1
				ldr	r2,=y
				ldr r2,[r2]
				sub	r3, r2, r3		@y-(height>>1)
				ldr	r2,=num2		@r2= 1000
				ldr r2,[r2]
				mul	r0, r2, r3		@r0=1000*(y-(height>>1))
				ldr	r3,=height		@r3=height
				ldr r3,[r3]
				mov	r1, r3, lsr #1	@r1=(height>>1)
				bl	__aeabi_idiv	@r0/r1
				ldr	r1,=zy			@zy
				str r0,[r1]			@zy=1000*(y-(height>>1))/(height>>1)
				ldr r1,=i
				ldr r2,=num4
				ldr r2,[r2]
				str r2,[r1]			@i=255
conditional:
				ldr	r3,=zx
				ldr r3,[r3]
				mov r2, r3
				mul	r0, r2, r3		@r0=zx*zx
				ldr	r3,=zy
				ldr r3,[r3]
                mov r2, r3
				mul	r1, r2, r3		@r1=zy*zy
				add	r0,r0,r1		@r0=zy*zy+zx*zx

				ldr	r1,=num3		@r1=4000000
				ldr r1,[r1]
				cmp r0,r1			@(zy*zy+zx*zx,4000000)
				bge for2B	    	@            >=
				movlt r2,#0
				ldr r0,=i
				ldr r0,[r0]
				cmp r0,r2			@(i,0)
				ble for2B			@  <=
while1:
				ldr	r1,=zx
				ldr r1,[r1]
				ldr	r2,=zx
				ldr r2,[r2]
				mul	r3, r1, r2		@r3=zx*zx
				ldr	r1,=zy
                ldr r2,[r1]
				ldr r1,[r1]
				mul	r1, r1, r2		@r1=zy*zy
				sub	r0, r3, r1		@r0=zx*zx-zy*zy
				ldr	r1,=num2
				ldr r1,[r1]			@r1=1000
				bl	__aeabi_idiv	@r0/r1
				mov r3,r0			@r3=(zx*zx-zy*zy)/1000
				ldr r1,=cx
				ldr r1,[r1]
				add r3, r3, r1		@r3=tmp=(zx*zx-zy*zy)/1000+cx
				ldr r1,=tmp
				str r3,[r1]
				ldr r1,=zx
				ldr r1,[r1]
				add r0, r1, r1		@r0=zx*2
				ldr r2,=zy
				ldr r2,[r2]
				mul r0, r0, r2		@r0=zx*2*zy
				ldr r1,=num2
				ldr r1,[r1]			@r1=1000
				bl	__aeabi_idiv	@r0=(2*zx*zy)/1000
				ldr r1,=cy
				ldr r1,[r1]
				add r0, r0, r1		@r0=(2*zx*zy)/1000+cy
				ldr r1,=zy
				str r0,[r1]			@zy=(2*zx*zy)/1000+cy
				ldr r0,=zx
				ldr r1,=tmp
				ldr r1,[r1]
				str r1,[r0]
				ldr r0,=i
				ldr r1,[r0]
				sub r1,r1,#1		@i--
				str r1,[r0]
				b conditional
for2B:

				ldr	r0,=i
				ldr r0,[r0]			@r0=i
				ldr r1,=0xff
				and r0, r0, r1	@r0=i&0xff
				mov r1,r0			@r1=i&0xff
				mov	r0, r0, lsl #8	@r0=(i&0xff)<<8
				orr	r0, r0, r1		@r0=(i&0xff)<<8||i&0xff
				ldr r1,=color
				str	r0,[r1]		@color = (i&0xff)<<8||i&0xff
				ldr r0,=color
				ldr r0,[r0]
				mvn	r0,r0			@r0=~r0
				ldr	r1,=0xffff		@r1=0xffff
				and r0, r0, r1		@r0=151那一坨的相反&0xffff
				ldr r1,=color
				str	r0,[r1]		@color存進去
				ldr r0,=frame
				ldr r0,[r0]
				ldr r1,=y
				ldr r1,[r1]			@r1=y
				ldr r2,=x
				ldr r2,[r2]			@r2=x
				ldr r3,=width
				ldr r3,[r3]			@r3=width
				mul	r1, r1, r3		@r1=y*width
				add	r1, r1, r2		@r1=y*width+x
				mov r3,#2
				mul r1, r1, r3		@r1=2*(y*width+x)  2x+1280y
				add	r0, r0, r1		@r2=frame+2x+1280y
				ldr r4,=color
				ldr r4,[r4]
				strh	r4,[r0]			@color in

				ldr r0,=y
				ldr r1,[r0]
				add	r1,r1,#1		@y++
				str r1,[r0]
				b	for2
end:
                ldr r0,=x
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				ldr r0,=y
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				ldr r0,=i
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				ldr r0,=zx
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				ldr r0,=zy
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				ldr r0,=color
				ldr r1,[r0]
				mov r1,#0
				str r1,[r0]
				mov     r0, #0
				ldmfd   sp!,{lr}
				mov		pc,lr

