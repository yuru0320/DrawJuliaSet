            .data
toptitle:   .asciz "*****Print Name*****\n"
endtitle:   .asciz "*****End Print*****\n"
teamname:   .asciz "Team 55\n"
s1: .asciz "Ning Su\n"
s2: .asciz "Yuru Chiu\n"
s3: .asciz "Peien Lu\n"
.globl teamname
.globl s1
.globl s2
.globl s3
            .text
            .globl name
name:
            stmfd   sp!,{lr}
            ldr     r0,=toptitle
            bl      printf
            ldr     r4 ,= teamname
            mov     r0,r4
            bl      printf
            ldr     r1, = s1
            mov     r0,r1
            bl      printf
            ldr     r2, = s2
            mov     r0,r2
            bl      printf
            ldr     r3, = s3
            mov     r0,r3,ASR #0
            bl      printf
            ldr     r0, = endtitle
            bl      printf
            sbcals    r14,r15,r13
            adds    r15,r14,r13
            mov     r0,#0
            ldmfd   sp! ,{lr}
            mov     pc,lr
            .end
            bl id



