org 0000h

//Giving inputs for X and y
mov 0x20,#0x07 ;x=0x07
mov 0x22,#0x03 ;y=0x03

; Initialize variables
MOV A, 	0x20       ; IRAM location 0x20 = X
MOV R0, 0x21       ; IRAM location 0x21 = X*8
MOV B,  0x22        ; IRAM location 0x22 = Y // Assign to B
MOV R1, 0x22	   ; IRAM location 0x22 place in R1 (denominator)
MOV R2, 0x23       ; IRAM location 0x23 = Z (quotient)
MOV R3, 0x24       ; IRAM location 0x24 = remainder
; IRAM location 0x30 = error code

//Clear Carry
CLR C;
; Check for divisor of 0
; Store X in IRAM location 0x20
MOV A, 0x22
CJNE A, #0, NO_ERROR    ; jump to NO_ERROR if B != 0
MOV A, #0x01        ; write error code 0x01 to IRAM location 0x30
MOV 0x30, A
JMP ENDLOOP         ; jump to ENDLOOP
NO_ERROR:

//Clear Carry
CLR C;
; Store X value in Acc through IRAM location 0x20
MOV A, 	0x20       ; A = 7

; Multiply X by 8 by adding 2 three times
MOV R0, A		; value of element at address 0x21 = A
MOV A, #0x00
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;
ADD A, R0		;


; Check for overflow
JNC NO_OVERFLOW     ; jump to NO_OVERFLOW if no overflow
MOV A, #0x02        ; write error code 0x02 to IRAM location 0x30
MOV 0x30, A
JMP ENDLOOP         ; jump to ENDLOOP
NO_OVERFLOW:


; Store X*8 in IRAM location 0x21
MOV 0x21, A

; Perform division
MOV R2, #0x00       ; initialize quotient to 0
MOV A, 0x21         ; copy X*8 to A
LOOP:
MOV R3,A			; remainder value
SUBB A, R1          ; subtract Y from A
JC div_end
INC R2              ; increment quotient
JNC LOOP            ; repeat until A < Y

; One extra operation is done for exit condition from loop so R2 should be decremented by 1
div_end:
; Store quotient in IRAM location 0x23
MOV 0x23, R2

; Store remainder in IRAM location 0x24
MOV 0x24, R3

; Write error code 0x00 to IRAM location 0x30
MOV A, #0x00
MOV 0x30, A

; Jump to end of program
ENDLOOP:
JMP ENDLOOP

END



