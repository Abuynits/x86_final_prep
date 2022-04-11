Generate Prime numbers:
.data
startLoc DWORD 2
endLoc DWORD 1000
arr DWORd 998 DUP(?)
val EQU [ebp-4]

 ;write program that generates all prime numbers from 2-1000 using sieze of eranthoseness method
.code



main proc

push offset arr
push lengthof arr
call generateArray; return ptr in edi

push offset arr
push lengthof arr
call sieve

push offset arr
push lengthof arr
call displayPrimeNumbers




main endp
invoke ExitProcess, 0

displayPrimeNumbers proc
	Push ebp
	Mov ebp,esp
	mov edi, [ebp+12]
	mov ecx, [ebp+8]

	l1:
	mov eax,[edi]
	cmp eax,0
	jz isNotPrime
	call writeDec
	call crlf

	isNotPrime:
	add edi,4
	loop l1


	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	displayPrimeNumbers endp


sieve proc
	Push ebp
	Mov ebp,esp
	sub esp,4
	mov ecx, [ebp+8]
	mov edi, [ebp+12]

	l1:
		mov ebx, [edi]
		add edi,4

		cmp ebx, 0
		jz notPrime

		push ecx
		push edi
		dec ecx
		l2:
			mov edx, 0
			mov eax, [edi]
			div ebx

			;if remainder is 0 - can devide - set the number to 0, else, leave the number alone
			cmp edx,0
			jne notDevisor
			mov eax,0
			mov [edi],eax

			notDevisor:
				add edi,4

		loop l2

		pop edi
		pop ecx


		notPrime:

	loop l1

	add esp,4
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	sieve endp

generateArray proc
	Push ebp
	Mov ebp,esp

	mov ecx, [ebp+8]
	mov edi, [ebp+12]
	mov eax,2
	l1:
	mov [edi],eax
	inc eax
	add edi,4
	loop l1


	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	generateArray endp

end main


algorithm:
have all of the numbers
take the lowest number and see if it is unmarked. if marked, skip over it
if unmarked, it is a prime number, and then try to devide all of the numbers after it with this number
if they devide equally (not a prime), mark them (say set to 0)
if not devide, continue forward
Get GCD: also have abs function here
.data
 v1 DWORD 18
 v2 DWORD 48
.code


main proc
push 46
call getAbs
push -46
call getAbs



 push v1
 push v2
 call gcd

 call writeInt

main endp
invoke ExitProcess, 0



gcd proc
push ebp
	Mov ebp,esp
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]

	push ebx
	call getAbs
	pop ebx
	mov ebx, eax

	push ecx
	call getAbs
	pop ecx
	mov ecx, eax

	;let ebx = x
	;let ecx = y
	;let edi = n
	;int n = x % y
	;x = y
	;y = n

	l1:

	cmp ecx, 0
	jbe breakLoop

	mov edx,0
	mov eax, ebx
	div ecx
	;edx=n (remainder)

	mov ebx,ecx
	mov ecx,edx



	jmp l1

	breakLoop:
	mov eax, ebx

	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	gcd endp

getAbs proc
	push ebp
	Mov ebp,esp
	mov eax, [ebp+8]
	cmp eax, 0
	jg isPositive

	xor eax, 0FFFFFFFFh
	inc eax


	isPositive:

	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	getAbs endp

end main

	int GCD(int x, int y)
{
x = abs(x) // absolute value
y = abs(y)
do {
int n = x % y
x = y
y = n
} while (y > 0)
return x
}
Fib series generator:
.data

.code


main proc
push 1;value 1
push 1;value 2
push 47;counter
call fib


main endp
invoke ExitProcess, 0

fib proc
	Push ebp
	Mov ebp,esp
	mov ecx, [ebp+8];the counter
	mov eax, [ebp+16];second value
	mov ebx, [ebp+12];the third value


	add eax, ebx
	call writeInt
	call crlf
	dec ecx
	cmp ecx,0
	je exitRec

	push ebx
	push eax
	push ecx
	call fib
	pop ecx
	pop eax
	pop ebx

	exitRec:



	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	fib endp



end main
Linked list access:
​​.data
 links BYTE 0, 4, 5, 6, 2, 3, 7, 0
 source BYTE 'H', 'A', 'C', 'E', 'B', 'D', 'F', 'G'
 s DWORD 1
 target BYTE 0 dup(lenghtof source)
 len EQU [ebp-4]
 loc EQU [ebp-8]
.code


main proc
  push offset links
 push offset source
 push offset target
 push lengthof source
 push s
 call orderList
main endp
invoke ExitProcess, 0

orderList proc
	Push ebp
	Mov ebp,esp
	sub esp,8; space for 1 local var to store length of array

	mov eax, [ebp+8]
	mov loc, eax;start loc store as local variable
	mov eax, [ebp+12];
	mov len, eax;store as local variable

	mov esi, [ebp+16];target
	mov edi, [ebp+20];source
	mov edx, [ebp+24];links

	mov ecx, len
	mov eax, 0; this is the value in which store loc for target
	l1:
	;chars: H A C E B D F G
	;links: 0 4 5 6 2 3 7 0

	add edi,loc
	mov bl,BYTE PTR [edi]
	sub edi,loc

	mov BYTE PTR[esi+eax],bl;

	add edx,loc
	mov bl,BYTE PTR[edx]
	sub edx,loc
	mov loc, bl

	;need to get val in source from loc do by: edi[loc]
	;move the value from source to target mov edi[eax]
	;load in the next location from loc: loc =edx[loc]

	add eax,1

	loop l1


	add esp,8
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	orderList endp
end main

How to write a string:
Mov edx, OFFSET str1
Call writeString

Process code (with local variables):

myProc PROC
	Push ebp
	Mov ebp,esp
	Sub esp,8;allocate space for two local variables
	;move local variables by mov EBP-4, val



Add esp, 8; move back from local variables
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	myProc endp

Process code (without local variables)
myProc proc
Push ebp
	Mov ebp,esp

;note: use lea when move vars around: lea esi, [ebp-12], not mov esi, [ebp-12]


	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	myProc endp

If want to say that you use a register, but not modify it:
myProc proc
Push ebp
	Mov ebp,esp
Push ebx
Push edx



Pop edx
Pop ebx
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	myProc endp

Stack configuration:
Param; [EBP+12];1st param
Param; [EBP+8];2nd param
Return add;never access
Local var 1 [EBP-4]
Local var 2 [EBP-8] (this is esp)

Declar local var easier:
X_local EQU DWORD PTR [ebp-4]; param
Param1 EQU DWORD PTR [ebp+4];local var

Starter code:
INCLUDE Irvine32.inc
;
;
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

.code


main proc


main endp
invoke ExitProcess, 0


end main

Remove chars from a word:
.data

str1 BYTE "Good Morrrning",0

.code


main proc
mov esi, OFFSET str1
push 2; number letter remove
mov ebx, lengthof str1
push ebx
mov ebx, 7
push ebx;loc in array
call myProc
mov edx, offset str1
call writeString

main ENDP
invoke ExitProcess, 0

myProc PROC
	;esi = ptr
	; ecx = length
	; eax = loc remove
	Push ebp
	Mov ebp,esp
	mov eax, [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	sub ecx, eax
	sub ecx, edx

	add esi, eax;esi now points to start of array

	l1:
	mov al,[esi+edx]
	mov [esi],al
	add esi,1
	loop l1

	mov al, 0
	mov [esi],al




	Mov esp,ebp;
	Pop ebp;
	Ret
	myProc endp

end main


Proc to get length of a string (if have extra space - count until reach a 0) return in ebx
getLengthString proc
	Push ebp
	Mov ebp,esp

	mov esi, [ebp+8]
	mov ebx,0
	l1:
	mov al,[esi]
	cmp al, 0
	jz endCounter
	inc ebx
	inc esi
	jmp l1

	endCounter:

	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	getLengthString endp

Find largest value in array:
.data
arr1 DWORD 1,6,4,6,3,8,5
.code

main proc
push offset arr1
push lengthof arr1
call findLargest
mov ebx,eax
main endp
invoke ExitProcess, 0

findLargest proc
	Push ebp
	Mov ebp,esp
	push edi
	push ecx

	mov edi, [ebp+12]
	mov ecx, [ebp+8]
	mov eax, 0

	l1:
	cmp eax, [edi]
	ja notfoundNewLargest

	mov eax, [edi]


	notFoundNewLargest:

	add edi, 4

	loop l1


	pop edi
	pop ecx
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	findLargest endp


end main

count similar elements in array:
.data
arr1 DWORD 1,2,3,4,5,6,4,7
arr2 DWORD 2,3,3,5,6,3,6,4
len EQU [ebp-4]

.code


main proc
push offset arr1
push offset arr2
push lengthof arr1
call getSimilar
mov ebx,eax


main endp
invoke ExitProcess, 0

getSimilar proc
Push ebp
	mov ebp,esp
	sub esp,4
	push ecx
	push edx
	push edi
	push esi
	mov esi,[ebp+8]
	mov len,esi;store lenght as temp var
	mov esi, [ebp+12]
	mov edi, [ebp+16]

	mov ecx, len
	mov eax,0
	l1:
	mov edx, [edi]
	cmp [esi], edx
	JNE notEqual
	inc eax
	notEqual:

	add esi,4
	add edi,4
	loop l1

	pop esi
	pop edi
	pop edx
	pop ecx
	add esp,4
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	getSimilar endp

end main



Check if array has consecutive values that are equal:
.data
arr1 DWORD 1,2,3,3,4,4,0,1,3,3,3,4,5,6,6,6
numFind DWORD 3
num EQU [EBP-4]
.code




main proc
push offset arr1
push lengthof arr1
call findThrees; return 1 in eax if have 3 consecutive integers

main endp
invoke ExitProcess, 0
findThrees proc
	Push ebp
	mov ebp,esp
	sub esp,4
	push esi
	push ecx
	push ebx
	mov esi, [ebp+8]
	mov num,esi
	mov esi, [ebp+12]
	mov ecx, num
	sub ecx, 3
	mov eax,0

	add esi,12

	l1:
	mov ebx, [esi]
	cmp ebx, [esi-4]
	jne notSame
	cmp ebx,[esi-8]
	jne notSame
	mov ecx, 1
	mov eax, 1
	notSame:

	add esi,4

	loop l1

	pop ebx
	pop ecx
	pop esi
	add esp,4
	Mov esp,ebp;esp used for manipulation while ebp points to return address
	Pop ebp;get the return address
	Ret
	findThrees endp




end main




