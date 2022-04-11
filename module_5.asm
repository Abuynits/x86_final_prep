HW-M5 Alexiy Buynitsky

4.9.2 problem 13:
A: 00000001h
B: the length of the bytes, if they would be an array. For example, if the length of the array would be 4, this would output 4
C: the size of the memory that is taken up by the byte array. As we are working with a byte array, it would be lengthof the array* size of byte = length of array, as the size in bytes is 1
D:The type of mywords would be loaded in. Each word contains 2 bytes, so therefore the size of the word in bytes would be 2
E: the length of the array would be loaded in. This would correspond to the number of elements, regardless of the size. If the length of the word array would be 4, the output would be 4
F: the size of the memory taken up by the array would be outputed. This would correspond to the number of elements in the array multiplied by the size of each element in bytes. As a word contains 2 bytes, we would have: lengthof array* 2. If the length of the array would be 4, the output would therefore be 8
G: as a string is declared as a byte array, it would be the number of characters in the string ( each character would get its  unique byte ) multiplied by the number of characters taken up by the string in addition to the null character, which would also take up another extra space.
So it would be : number of characters*1 + 1(null character)

Problem 1:
.data
	bigEndian BYTE 12h, 34h, 56h, 78h
	l_label LABEL BYTE
	littleEndian DWORD ?
	temp WORD ?

.code
main proc
  mov al,[bigEndian+3]
  mov BYTE PTR [littleEndian],al

  mov al,[bigEndian+2]
  mov BYTE PTR [littleEndian+1],al

  mov al,[bigEndian+1]
  mov BYTE PTR [littleEndian+2],al

  mov al,[bigEndian]
  mov BYTE PTR [littleEndian+3],al


	invoke ExitProcess,0
Problem 2:
.data
	myArray BYTE 12h, 34h, 56h, 78h
	timesLoop BYTE ?
	firstLoc BYTE 0h
	secondLoc BYTE 1h
	tempVal BYTE ?



.code
main proc
	mov al, LENGTHOF myArray
	mov timesLoop, al

	mov esi, 0

	movzx ecx, timesLoop

	Array_loop:
	dec ecx

	mov al,  myArray[esi]
	inc esi
	xchg al, myArray[esi]
	dec esi
	xchg al, myArray[esi]
	inc esi
	inc esi

	loop Array_loop

	movzx eax, myArray
	movzx eax, myArray[1]
	movzx eax, myArray[2]
	movzx eax, myArray[3]

	invoke ExitProcess,0
main endp
end main
Problem 3
.data
	myArray BYTE 01h, 04h, 06h, 09h
	timesLoop BYTE ?
	sum WORD 0
	difference WORD 0

.code
main proc
	mov al, LENGTHOF myArray
	dec al
	mov timesLoop, al

	mov esi, 0

	movzx ecx, timesLoop

	Array_loop:

	inc esi
	mov ax, 0
	mov al,  myArray[esi]
	sub al, myArray[esi-1]
	mov difference, ax
	mov ax, sum;
	add ax, difference
	mov sum, ax

	loop Array_loop

	movzx eax, sum

	invoke ExitProcess,0
main endp
end main

Problem 4:
.data
	wordArray WORD 0001h,0002h,0003h,0004h
	dWordArray DWORD ?
	wLength BYTE ?


.code
main proc
	mov al, LENGTHOF wordArray
	mov wLength, al ; get the length of the array

	movzx ecx, wLength
	mov esi, 0
	loopArray:

	mov ax, wordArray[esi]
	mov WORD PTR[dWordArray +esi],ax

	inc esi



	loop loopArray
	movzx eax, wordArray
	movzx eax, wordArray+2
	movzx eax, wordArray+4
	movzx eax, wordArray+6


invoke ExitProcess,0
main endp
end main

Problem 5:
.data
	fib1 BYTE 01h
	fib2 BYTE 02h
	numCalc BYTE 7
	sum BYTE 0

.code
main proc
	mov al, numCalc
	dec al
	movzx ecx, al
	fib:
		mov al, fib1
		add al, fib2
		;al = new sum, fib1 = lower sum, fib 2 = upper sum
		; need to move fib 2 to fib 1, and al to fib2
		; will use register bl
		mov bl, fib2
		mov fib1,bl

		mov bl, al
		mov fib2, bl



	loop fib

	movzx eax,fib2


invoke ExitProcess,0
main endp
end main