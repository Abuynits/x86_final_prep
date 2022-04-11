HW-M7
Alexiy Buynitsky
02/16/2022

Section 6.10:

Problem 5:
The value stored in ebx is 0BFAFF69Fh

Problem 7:
A: 2Dh
B: 48h
C: 6Fh
D: 0A3h

Problem 8:
A: 85h
B: 34h
C: 0BFh
D: 0AEh

Problem 9:
A: CF=0, ZF=0, SF=0
B: CF=0, ZF=0, SF=0
C: CF=1, ZF=0, SF=1

Problem 12
EDX would store the value 1. This is because 7FFFh is less than 8000h, and through the comparison call, we would jump to L1.

Problem 14:
EDX would store the value 0. This is because we perform a signed comparison beweek 7FFFh which is positive and 0FFFF8000h which is negative. As the positive number is not greater than the negative number, we do not jump to l2 and we move 0 into the edx register.

Problem 16:
True. as we are using signed values, -42 would be 0FFFFFFD6h. As this is greater than the hex representation of 26 in a unsigned comparison through the instruction JA. we will in fact perform a jump. We should be using jg instead.
Problem 19:
In the lower 8 bytes, we would have: 80808080h. In the upper we would have 00000000h, as the and operation loks for common bit values. Therefore combined, we would have 0000000080808080h.

Section 16.11.2

Problem 1:
.data
n=5
start=1
endArr=3
myArr DWORD n DUP(?)
.code
main PROC
mov eax,0
mov ebx,0
call setupValues
call generateRandomArray
call printValues


start = 2
endArr = 4
call setupValues
call generateRandomArray
call printValues


INVOKE ExitProcess,0
main ENDP

generateRandomArray PROC USES edi ecx ebx eax
	fillArray:
		call Random32
		mov [edi],eax
		add edi, ebx
	loop fillArray
	ret
generateRandomArray ENDP

setupValues PROC
	mov al,start
	mov ah, endArr
	mov bl, TYPE myArr
	mov edi, OFFSET myArr
	mov ecx, n
	ret
	setupValues endp

printValues PROC USES edi eax ebx ecx edx
	mov ecx,0
	mov cl, ah
	sub cl, al
	inc cl
	movzx edx, al

	l1:
		mov eax, [edi]
		add edi, edx
		call writeHex
		mov al, " "
		call writeChar
		add bh, bl
	loop l1
	call crlf
	ret
	printValues ENDP
end main

Problem 2:
.data
lengthArray =8
myArr DWORD lengthArray DUP(?)
i=2
j=5

.code
main PROC

mov edi, OFFSET myArr
mov edx, TYPE myArr
call generateArray
call getSum ; return in ebx
i=4
j=7
mov edi, OFFSET myArr
mov edx, TYPE myArr
call generateArray
call getSum ; return in ebx


INVOKE ExitProcess,0
main ENDP


getSum PROC uses ecx edi edx ebx eax
	mov edi, OFFSET myArr
	mov ecx, 0
	mov cl,  j
	sub cl,  i
	inc cl
	mov edx, i*TYPE myArr

	l1:
		add ebx, [edi+edx]
		add edx, TYPE myArr
	loop l1
	push eax
	mov eax,ebx
	call writehex
	pop eax
	call crlf

ret
getSum endp

generateArray PROC uses ecx edi edx
	mov ecx, lengthArray
	l1:
		call random32
		mov [edi], eax
		add edi, edx
	loop l1


ret
generateArray endp

end main

Problem 4:

.data
TRUE = 1
FALSE = 0
gradeAverage DWORD 275 ; test value
credits DWORD 12 ; test value
OkToRegister BYTE ?
askMessage BYTE "hello, please enter your grade average and credits",0
errorMessage BYTE "ERROR: please renter values",0
allowReg BYTE "You can register",0
notAllowReg BYTE "You cannot register",0
.code
main PROC

call askForValues; return gradeAverage in ebx, return creditValues in eax
mov gradeAverage,ebx
mov credits,eax

call checkIfValidCredits; store credits in eax, return true/false in ecx
 cmp ecx, TRUE
 jb NotOkToRegister


cmp gradeAverage, 350
jb allowToRegister;if grade average below 350, allow

cmp gradeAverage, 250
jb failFirst
cmp credits, 16
jb allowToRegister; if grade average >250 and credits <=16
failFirst:

cmp credits, 12
jb allowToRegister; if credits <12, allow to register

jmp NotOkToRegister
allowToRegister:
mov edx, OFFSET allowReg
call writeString
jmp skipOverNotAllow
NotOkToRegister:
mov edx, OFFSET notAllowReg
call writeString
skipOverNotAllow:

INVOKE ExitProcess,0
main ENDP

askForValues proc uses edx
	mov edx, OFFSET askMessage
	call writeString
	call crlf
	call readInt
	mov ebx, eax
	call readInt
	ret
	askForValues endp

checkIfValidCredits proc uses ebx
	; value cannot be less than 1 or greater than 30
	mov ecx, TRUE
	cmp eax, 1
	jb invalid
	cmp eax, 30
	ja invalid
	jmp valid
	invalid:
	mov ecx, FALSE
	mov edx, OFFSET errorMessage
	call writeString;show the error here
	call crlf
	valid:
	ret
	checkIfValidCredits endp

end main

