Alexiy Buynitsky
X86 HW-M4

Section 3-10

Problem 1:
	mov eax,5
	mov ebx,26
	mov ecx,15
	mov edx,3
	add eax, ebx; A+B and store in A
	add ecx, edx; C+D and store in C
	sub eax, ecx; eax=A+B, exc=C+D, eax-ecx = (A+B)-(c+D) and store in eax
Problem 2:
.data
	MONDAY = 1
	TUESDAY = 2
	WEDNESDAY = 3
	THURSDAY = 4
	FRIDAY = 5
	SATURDAY = 6
	SUNDAY = 7

.code
main proc

.data
	list BYTE MONDAY, TUESDAY, WEDNESDAY
		 BYTE THURSDAY, FRIDAY, SATURDAY, SUNDAY
.code
	invoke ExitProcess,0
Problem 3:
.data
	myByte BYTE  'h' ; 8 bit unsigned integer (unsigned short)
	mySByte SBYTE -124; 8 bit signed integer  (signed short)
	myWord WORD 0F2h; 16 bit unsigned integer (unsigned int)
	mySWord SWORD -2146; 16 bit signed integer (signed signed int)
	myDWord DWORD 12345678h; 32 bit unsigned integer (double)
	mySDWord SDWORD -5436; 32 bit signed integer (signed double)
	myFWord FWORD 48969365; 48-bit integer (Far pointer in protected mode)
    myQword QWORD 0FDAC3464387h; 64-bit integer (signed long)
	myTByte TBYTE 000000000000001234h; 80- bit integer (Stored in BCB - like a float, can hold decimals, can only be stored in hex)
	myReal4 REAL4 1.5; 4 bit real # - used to convert real to BCD by: "flb realNumber " to load on floating-point stack register, and lload its output onto tByte variable: "fbstp bcdVal"
	myReal8 REAL8 -87643.43;  8 bit real number -can store decimals and negatives
	myReal10 REAL10 102034.0; 10 bit real number - can store decimals and negatives
.code
main proc


	invoke ExitProcess,0
main endp
Problem 4:
	greetings TEXTEQU <"hi">
	greetings1 EQU <"Bye">
	transfer TEXTEQU <mov>
	move_greetings_to_eax TEXTEQU <transfer eax,greetings>
.data
	greetingsHolder BYTE greetings1
.code
main proc


	move_greetings_to_eax


	invoke ExitProcess,0

