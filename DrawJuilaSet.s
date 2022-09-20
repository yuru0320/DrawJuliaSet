    .data
zx:  .word 0
zy:  .word 0
tmp: .word 0
i:   .word 0
x:   .word 0
y:   .word 0
cx:  .word 0
cy:  .word 0
width:   .word 0
height:  .word 0
frame:   .word 0

    .text
    .global drawJuliaSet

drawJuliaSet :
    ldr     r4,=frame
    str     sp,[r4]

    ldr     r4,=cx
    str     r0,[r4]

    ldr     r4,=cy
    str     r1,[r4]

    ldr     r4,=width
    str     r2,[r4]

    ldr     r4,=height
    str     r3,[r4]

    stmfd   sp!,{lr}
    ldr     r0,=x
    mov     r1,#0       @operand2-1
    str     r1,[r0]     @x=0
    b       loop11

loop1:
    ldrvc     r0,=x     @C-1
    ldr     r0,[r0]
    ldr     r1,=width
    ldr     r1,[r1]
    cmp     r0,r1       @x<width
    bge     end
    blt     loop11

loop11:
    ldr     r0,=y
    mov     r1,#0
    str     r1,[r0]     @y=0
    b       loop22

loop2:
    ldr     r0,=y
    ldr     r0,[r0]
    ldr     r1,=height
    ldr     r1,[r1]
    cmp     r0,r1
    blt     loop22      @y<height
    bge     done

done:
    ldr     r0,=x
    ldr     r1,[r0]
    add     r1,r1,#1    @x++
    ldr     r0,=x
    str     r1,[r0]
    b       loop1

loop22:
@zx
    ldr     r0,=x
    ldr     r1,=width
    ldr     r2,=1500
    ldr     r0,[r0]
    ldr     r1,[r1]
    mov     r1,r1,asr#1     @operand2-2
    sub     r0,r0,r1        @x-(width>>1)
    mul     r0,r0,r2
    bl      __aeabi_idiv
    ldr     r1,=zx
    str     r0,[r1]
@zy
    ldr     r0,=y
    ldr     r1,=height
    mov     r2,#1000
    ldr     r0,[r0]
    ldr     r1,[r1]
    mov     r1,r1,asr#1
    sub     r0,r0,r1        @operand2-4
    mul     r0,r0,r2
    bl      __aeabi_idiv
    ldr     r1,=zy
    str     r0,[r1]

    mov     r0,#255
    ldr     r1,=i
    str     r0,[r1]
    b       loop3

loop3:
@cmp zx*zx+zy*zy
    ldr     r0,=zx
    ldr     r1,=zy
    ldr     r0,[r0]
    ldr     r1,[r1]
    mul     r0,r0,r0
    mul     r1,r1,r1
    add     r0,r0,r1
    ldr     r1,=4000000
    cmp     r0,r1
    bge     store          @>=4000000
    ldrlt     r0,=i         @C-2
    ldrlt     r0,[r0]
    cmp     r0,#0
    bgt     loop33          @>
    ble     store           @<=

store:
    ldr     r0,=i
    ldr     r0,[r0]
    and     r0,r0,#0xff
    orr     r0,r0,r0,lsl#8      @operand2-3
    @mvn     r0,r0
    ldr     r7,=0xffff
    bic     r0,r7,r0

    ldr     r1,=640
    ldr     r2,=y
    ldr     r3,=x
    ldr     r2,[r2]
    ldr     r3,[r3]
    mla     r1,r1,r2,r3
    mov     r1,r1,lsl#1
    @mul     r1,r1,r2
    @add     r1,r1,r3
    @mov     r1,r1,lsl#1

    ldr     r2,=frame
    ldr     r2,[r2]
    strh    r0,[r2,r1]

    ldr     r0,=y
    ldr     r1,[r0]
    add     r1,r1,#1        @y++
    ldr     r0,=y
    str     r1,[r0]
    b       loop2

loop33:
@zx
    ldr     r0,=zx
    ldr     r0,[r0]
    ldr     r1,=zy
    ldr     r1,[r1]
    mul     r0,r0,r0
    mul     r1,r1,r1
    sub     r0,r0,r1
    mov     r1,#1000
    bl      __aeabi_idiv
    ldr     r2,=cx
    ldr     r2,[r2]
    add     r0,r0,r2
    ldr     r1,=tmp
    str     r0,[r1]
@zy
    ldr     r0,=zx
    ldr     r0,[r0]
    ldr     r1,=zy
    ldr     r1,[r1]
    mul     r0,r0,r1
    mov     r0,r0,lsl#1
    ldr     r1,=1000
    bl      __aeabi_idiv
    ldr     r2,=cy
    ldr     r2,[r2]
    add     r0,r0,r2
    ldr     r1,=zy
    str     r0,[r1]

    ldr     r0,=tmp
    ldr     r1,=zx
    ldr     r0,[r0]
    str     r0,[r1]
@i
    ldr     r0,=i
    ldr     r1,=i
    ldr     r1,[r1]
    sub     r1,#1
    str     r1,[r0]
    b       loop3
end:
    mov     r0,#0
    adds    r14,r0,r13
    subs    r0,r14,r13
    ldmfd   sp!,{lr}
    mov     pc,lr
    .end
