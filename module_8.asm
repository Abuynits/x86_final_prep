HW-m8
Alexiy Buynitksy

Section 7.9.1

Problem 1:
A: 6Ah
B: 0EAh
C: 0FDh
D: A9h

Problem 3:
Dx: 0002h
Ax: 2200h

Problem 5:
Edx: 00000000h
Eax: 00012340h

Problem 8:
As we are dividing in 64 bit values, the full number will be stored in rdx:rax
When we perform the division, the quotient will be stored in RAX, while the remainder will be stored in RDX.

Problem 9:
We have to store the memory locations of the qword in edi and esi, not the dword itself. We will do so via OFFSET
As we are storing the values in little endian, we will need to increment edi and esi, not decrement. That way, we would loop from the lsb to the msb.
We also have to remove all of the garbage from the ecx via mov ecx , 8 instead of mov cx, 8

Section 7.10

Problem 1:
​​​​.data
DECIMAL_OFFSET = 5
decimal_one BYTE "100123456789765"
write_var BYTE lengthof decimal_one+2 DUP(0)
.code
main proc
mov edx, OFFSET decimal_one
mov ecx, lengthof decimal_one
mov ebx, DECIMAL_OFFSET
call writeScaled

INVOKE ExitProcess,0
main ENDP
writeScaled PROC uses eax edi ecx
	mov eax,0
	mov edi,0
	push ecx
	sub ecx,ebx
	beforeDecimal:

	mov al, BYTE PTR [edx]
	mov write_var[edi], al
	inc edi
	inc edx
	loop beforeDecimal
	pop ecx

	mov write_var[edi],46d
	inc edi

	mov ecx, ebx
	afterDecimal:
	mov al, BYTE PTR [edx]
	mov write_var[edi], al
	inc edi
	inc edx
	loop afterDecimal
	mov eax, OFFSET write_var
	call writeString
	call crlf
	ret
	writeScaled endp
end main

Problem 2:
.data

decimal_one BYTE "10012345647897656786976526789765"
decimal_two BYTE "59487648013958360143786730540595"
dif BYTE lengthof decimal_one+2 DUP(0)
.code
main proc
mov edi, OFFSET decimal_one+sizeof decimal_one-1
mov esi, OFFSET decimal_two+sizeof decimal_two-1
mov ecx, lengthof decimal_two
mov eax, 0

call Extended_Sub

INVOKE ExitProcess,0
main ENDP
Extended_Sub proc uses ecx esi edi eax ebx
	;going to subtract esi-edi
	clc
	push ecx
	subtract:
	mov al,BYTE PTR [esi]
	mov bl, BYTE PTR [edi]
	sbb al,BYTE PTR [edi]
	aas
	mov bl, al
	or bl,30h
	mov BYTE PTR [esi],bl
	dec esi
	dec edi

	loop subtract

	pop ecx

	mov edx, OFFSET decimal_two
	call writeString
	call crlf


	ret
	Extended_Sub endp

end main
;decimal_one BYTE "10012345647897656786976526789765"
;decimal_two BYTE "59487648013958360143786730540595"
Problem 4:
.data
key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
message BYTE "Hello this world is nice"
eMessage BYTE lengthof message DUP(0)
.code
main proc
mov ecx, lengthof message

mov eax, OFFSET message
mov edx, OFFSET eMessage

mov ebx, 0; store the encryption loc
encrypt:
; need to have process do encryption
push ecx
call changeVal; eax=mess Offset, edx= eMess Offset, ebx= encryption location
;return value in cl
mov [edx],cl

pop ecx
;to update, need to increment ebx. if ebx= lengthof message,set back to 0

	inc ebx
	cmp ebx, lengthof key
	JNE notReset
	mov ebx, 0

	notReset:
	inc eax
	inc edx
loop encrypt
mov eax,DWORD ptr [message]
call writeHex
mov eax,DWORD ptr [message+8]
call writeHex
call crlf

mov eax,DWORD ptr [eMessage]
call writeHex
mov eax,DWORD ptr [eMessage+8]
call writeHex


call crlf

INVOKE ExitProcess,0
main ENDP

changeVal proc uses eax edx
	mov cl, BYTE PTR key[ebx]
	;eax= char loc
	;edx = encryption storage loc
	movzx edx, BYTE PTR [eax]
	cmp cl,0
	JL rotateLeft

	rotateRight:
	ror dl,cl
	jmp continue

	rotateLeft:
	;rotate with ROL inst
	not cl
	inc cl
	rol dl,cl

	continue:
	mov cl,dl

	;need to compare if the offset value is -: rotate Left

	;else rotate right

	ret
	changeVal endp

end main


