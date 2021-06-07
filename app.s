
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


	

.globl main
main:
	mov x20, x0
	mov x19, #0

animation:
	bl clear_screen

	movz x0, 100
	movz x1, 100
	movz x2, 200
	movz x3, 300
	mov x4, 0xFF0000
	bl draw_rect

	mov x0, x19
	movz x1, 150
	movz x2, 100
	movz x3, 50
	mov x4, 0x00FF00
	bl draw_rect
	//-------------	--------------------------------------------------
	// Infinite Loop 
	add x19, x19, #1
	mov x0, 0xFFFFF
	bl delay
	b animation
InfLoop: 
	b InfLoop


clear_screen:
	mov x0, x20

	mov x2, 0xFFFFFF   // 0x0000FF = BLUE
	movz x1, 0xB000
	movk x1, 0x4, LSL #16

super_loop0:
	stur x2,[x0]	   // Set color of pixel N

	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,super_loop0	   // If not end row jump
	ret
 

draw_rect: // x0: X, x1: Y, x2: W, x3: H, x4: Color

_draw_rect_loop_fila: 
	mov	   x5, SCREEN_WIDTH
	mul    x5, x1, x5
	add    x5, x5, x0
	lsl	   x5, x5, #2
	add    x5, x5, x20
	mov    x6, x2
_draw_rect_loop_col:
		str x4, [x5]
		add x5, x5, #4
		sub x6, x6, #1
		cbnz x6, _draw_rect_loop_col
	add x1, x1, #1
	sub x3, x3, #1
	cbnz x3, _draw_rect_loop_fila

	ret
	