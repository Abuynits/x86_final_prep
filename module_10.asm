Alexiy Buynitsky
HW-M10
Section 9.10

Problem 2
 Str_concat proto, tStr: PTR BYTE, source: PTR BYTE
.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code


main proc
INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
mov esi, OFFSET targetStr
mov ecx, lengthOf targetStr
l1:
mov al, [esi]
inc esi
loop l1
main ENDP

Str_concat PROC uses edi edi ecx, tStr: PTR BYTE, source: PTR BYTE
	mov edi, tStr
	add edi, 5
	mov esi, source
	mov ecx, 3
	rep movsb

ret
Str_concat endp
end main


Problem 3:
Str_remove PROTO, rem: PTR BYTE, times: BYTE
.data
target BYTE "abcxxxxdefghijklmop",0

.code


main proc

INVOKE Str_remove, ADDR [target+3], 4
mov edx, offset target
call writeString
mov edx, 0
main ENDP

Str_remove PROC uses esi eax edi, rem: PTR BYTE, times: BYTE
	;first need to move 0 into all of the positions
	mov al,41
	cld
	movzx ecx, times
	mov edi, rem
	rep stosb;edi is now 1 over the correct location, poitning to the value after removal
	mov esi, rem
	xchg esi, edi
	;now have: abc0000defghijklmop
	;need to swap values starting at esi with those at edi, incementing them along the way
	mov ecx, 12



	cld
	rep movsb

	;edi now point where need to start having 0's instead of leatters
	therfore:
	cld
	mov al,0
	movzx ecx, times
	rep stosb

	ret
Str_remove endp

end main

