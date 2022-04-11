HW-M9
Alexiy Buynitsky

Problem 1:
.data
arr1 DWORD 1,7,5,-6,3,10
size1 = lengthof arr1

.code
main proc
push OFFSET arr1
push size1
call findLargest

INVOKE ExitProcess,0
main ENDP
findLargest PROC
	push ebp
	mov ebp,esp
	mov esi, [ebp+12]
	mov ecx, [ebp+8]
	mov eax,0
	l1:
	cmp eax, [esi]
	jl foundLarger
	jmp notFoundLarger
	foundLarger:
	mov eax, [esi]
	notFoundLarger:
	add esi,4
	loop l1


	pop ebp
	ret
	findLargest endp

end main
Problem 2:
INCLUDE Irvine32.inc
;
;
drawWhite PROTO, locX:DWORD,locY:DWORD
drawGrey PROTO, locX:DWORD,locY:DWORD
drawRow PROTO, numSquares:DWORD,yLoc:DWORD

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
times=8
grey = 2
white = 15
spaceChar BYTE "A",0
;grey square draw
;white square draw
;draw a row

.code
main proc

mov ecx, 8
l1:
push ecx
INVOKE drawRow, 8,ecx
pop ecx
loop l1
INVOKE ExitProcess,0
main ENDP


drawRow PROC uses ecx, numSquares:DWORD,yLoc:DWORD
	mov ecx, numSquares
		l1:
		push ecx
		and ecx, 00000001b
		.IF ecx> 0
			INVOKE drawGrey, ecx,yLoc
		.ELSE
			INVOKE drawWhite, ecx,yLoc
		.ENDIF
		pop ecx

		loop l1
	ret
drawRow endp

drawWhite PROC uses eax, locX:DWORD,locY:DWORD
	mov eax,grey
	call SetTextColor

	mov dl, BYTE PTR locY
	mov dh, BYTE PTR locX
	call Gotoxy
	mov edx, OFFSET spaceChar
	call writeString
	ret
	drawWhite endp

drawGrey PROC uses eax, locX:DWORD,locY:DWORD
	mov eax,white
	call SetTextColor

	mov dl, BYTE PTR locY
	mov dh, BYTE PTR locX
	call Gotoxy
	mov edx, OFFSET spaceChar
	call writeString
	ret
	drawGrey endp

end main
Problem 4:
INCLUDE Irvine32.inc
;
;
findThrees PROTO, arrPTR: PTR DWORD, len: DWORD
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

arr1 DWORD 1,5,4,3,3,3,6
l = lengthOF arr1

.code
main proc
	INVOKE findThrees, OFFSET arr1, l
main ENDP

findThrees PROC uses ecx esi, arrPTR: PTR DWORD, len: DWORD
	mov eax,0
	.IF len>3
		mov esi, arrPTR
		mov ecx, len
		sub ecx, 3

		l1:
		push ebx
		push edx
		push ecx

		mov ebx, [esi]
		mov edx, [esi+4]
		mov ecx, [esi+8]
			.IF (ebx==3)&&(ebx==edx)&&(ebx==ecx)
				mov eax,1
			.ENDIF
			add arrPTR,4
		pop ebx
		pop edx
		pop ecx
		loop l1

	.ENDIF

	ret
	findThrees endp
end main



Problem 5:
INCLUDE Irvine32.inc
;
;
checkIfSame PROTO, in1: DWORD, in2: DWORD,in3: DWORD
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

in1 DWORD 4
in2 DWORd 5
in3 DWORd 5

.code
main proc
	INVOKE checkIfSame, in1,in2,in3
main ENDP

checkIfSame PROC uses ebx ecx edx, i1: DWORD, i2: DWORD,i3: DWORD
mov eax, 0
mov ebx, i1
mov ecx, i2
mov edx, i3
	.IF (ebx==ecx)&&(ecx==edx)
		mov eax,1
	.ENDIF
	ret
	checkIfSame endp
end main



Problem 6:
INCLUDE Irvine32.inc
;
;
generateArray PROTO, arrPtr:PTR DWORD , len: DWORD
swapElements PROTO, pValX:PTR DWORD , pValY:PTR DWORD
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
lenArr = 8
arr DWORD lenArr DUP(?)

.code
main proc
	INVOKE generateArray, OFFSET arr, lenArr
	INVOKE swapElements, OFFSET arr, OFFSET arr + 4
main ENDP

	generateArray PROC uses ecx eax, arrPtr: PTR DWORD , len: DWORD
		mov ecx, len
		l1:
			call Random32
			mov [arrPtr], eax
			add arrPtr, 4
		loop l1
		ret
	generateArray endp

	swapElements PROC USES eax esi edi, pValX: PTR DWORD , pValY:PTR  DWORD
		;
		; Exchange the values of two 32-bit integers
		; Returns: nothing
		;-------------------------------------------------------
		mov esi,pValX ; get pointers
		mov edi,pValY
		mov eax,[esi] ; get first integer
		xchg eax,[edi] ; exchange with second
		mov [esi],eax ; replace first integer
		ret ; PROC generates RET 8 here
	swapElements ENDP


end main



Problem 7:

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
placeLargestFirst PROTO, v1: PTR DWORD, v2: PTR DWORD
computeGCD PROTO, v1: DWORD, v2:DWORD
.data
val1 DWORD 210d
val2 DWORD 45d


.code
main proc
  invoke placeLargestFirst, OFFSET val1, OFFSET val2
invoke computeGCD, val1, val2
call writeInt

main ENDP

computeGCD PROC uses ebx edx, v1: DWORD, v2:DWORD
	mov ebx, v2
	mov edx, 0
	mov eax, v1
	div ebx

	.IF edx!=0
		invoke computeGCD, v2, edx
	.ELSE
		mov eax, v2
	.ENDIF
ret
computeGCD endp

placeLargestFirst PROC uses eax ebx edi esi, v1:PTR DWORD , v2:PTR DWORD
	mov edi, v1
	mov esi, v2
	mov eax, [edi]
	mov ebx, [esi]
	cmp eax,ebx
	jl swap
	jmp noChange
	swap:
		mov [v1], ebx
		mov [v2], eax
	noChange:

ret
placeLargestFirst endp

end main

