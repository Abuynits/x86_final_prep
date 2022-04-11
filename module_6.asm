Alexiy Buynitsky HW-M6
Section 5.8.1:

Problem 15:
The value: 00000005h will be stored in eax
Problem 16:
The program will halt with a runtime error on line 11 (Choice d)
Because the ret tries to remove the topmost return value, which in turn is the memory location of the initial function call. As 20d is unlikely to be a valid memory location, we receive an error on this line.
Problem 17:
EAX will be equal to 30 on line 6 (Choice C)
Problem 18:
EAX will equal to 30 on line 7 (choice A)
Problem 19:
EDX will equal to 40 on line 6 (choice A)
Problem 20:
The contents of the array will be the following:
0000 000Ah;10
0000 0014h;20
0000 001Eh;30
0000 0028h;40

Section 5.9 problems 1,2,4,5,7

Problem 1:
.data
myString BYTE "Hello everyone",0
black =0
red=4
green =2
cyan =3
white =15

myColors DWORD white+(blue*16),red+(black*16),green+(cyan*16),red+(black*16)

.code
 main PROC
 mov ecx,lengthof myColors
 mov esi,OFFSET myColors

l1:
mov eax, [esi]
call setTextColor
mov edx, OFFSET myString
call writeString
add esi, type myColors
loop l1
Problem 2:
.data
start =1
myChars BYTE "H","A","C","E","B","D","F","G"

links DWORD    0,  4,  5,  6,  2,  3,  7,  0
timesLoop BYTE lengthof links

orderedChars BYTE lengthof links DUP(0);create an empty array that will be ordered

currentLoc DWORD start*TYPE myChars
tempVal DWORD 0
nextLoc BYTE 0

.code
 main PROC
 movzx ecx, timesLoop
 mov esi, currentLoc; esi is pointer to the links/myChars location
 mov edi, 0;edi is the pointer the the orderedChars location

 l1:
 ;process:
 ; need to access the current letter at esi & store it
 mov al, myChars[esi*TYPE myChars]
 mov orderedChars[edi*TYPE orderedChars],al
 ; need to access the corresponding link of that letter & store it
 mov esi,links[esi*TYPE links];*TYPE myChars
 ;need to update the next loc
 add edi, TYPE orderedChars

 loop l1
Problem 4:
.data
timesLoop = 3
val1 DWORD ?
val2 DWORD ?
.code
 main PROC
 mov ecx, timesLoop

l1:



call moveToCenter
call ReadInt;read first int until the enter value is hit
mov val1,eax
call moveToCenter
call ReadInt
add eax, val1
Call Clrscr;clear the screen
call WriteDec; show the decimal value in the console


 loop l1
INVOKE ExitProcess,0
main ENDP

moveToCenter PROC
mov dh,10
mov dl, 20
call Gotoxy ; move to the center of the screen
ret
moveToCenter ENDP
end main

Problem 5:
.data

.code
 main PROC
 mov ebx,-300
 mov eax, 100

mov ecx, 50
L1:

call BetterRandomRange
push eax
mov eax, edi
call WriteInt
pop eax
call Crlf
loop L1
INVOKE ExitProcess,0
main ENDP

BetterRandomRange PROC USES eax ebx

; need to generate integer between eax-ebx

sub eax,ebx
call RandomRange; give val in the range of ebx and eax
add eax, ebx; now add the value- store it in the eax register
mov edi,eax
ret
BetterRandomRange ENDP

end main
Problem 7:
.data
maxX WORD ?
maxY WORD ?

nextX BYTE ?
nextY BYTE ?
myChar BYTE "A"
loopTimes = 1000
delayAmount = 10
.code
 main PROC

 call setScreenBounds;set the bounds of screen and store in the maxX and maxY

 mov ecx, loopTimes

 L1:

 movzx eax, maxX
 call RandomRange
 mov nextX, al

 movzx eax, maxY
 call RandomRange
 mov nextY, al

 mov dh, nextX
 mov dl, nextY

 call Gotoxy
 mov al, myChar
 call writeChar

 mov eax, delayAmount
 call Delay


 loop L1


INVOKE ExitProcess,0
main ENDP

setScreenBounds PROC
call GetMaxXY
mov maxX, dx
mov maxY, ax
ret
setScreenBounds ENDP


