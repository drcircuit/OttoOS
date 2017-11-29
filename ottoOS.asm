[BITS 16]
[ORG 7c0h]

MOV AH, 0
MOV AL, 12H
INT 10H
mov si, load       
call blue
call printString 
mov si, loading
call green
call printString
mov si, complete
call printString
mov si, version
call blue
call printString
mov si, credits
call printString   
mov si, blank
call printString
mov si, prompt
call grey
call printString
JMP $         


printString: ;printString sub routine
printChar:
mov ah, 09h
mov bh, 0  
mov cx, 1
lodsb
cmp al, 0x00
je done     
int 10h   
mov bh, 0
mov ah, 03h
int 10h
mov ah, 02h
mov bh, 0
inc dl
int 10h
jmp printChar
done: 
mov ah, 02h
mov bh, 0
mov dl, 0
inc dh  
int 10h
ret        

blue:
mov bl, 0011b
ret 

red:
mov bl, 0x000C
ret

green:
mov bl, 0x000A
ret

grey:
mov bl, 0x0007
ret 
load: db 'Loading DocZ OS',10,13,0
loading: db '.................................',10,13,0
complete: db 'COMPLETE - LOADED OK!',0
version: db 'DocZ OS v. 1.3.3.7 (build 7.3.3.1)',10,13,0
credits: db 'Written by Otto',10,13,0    
blank: db 0
prompt: db 'COS> ',10,13,0





TIMES 510-($-$$) db 0 ;pad to fill address space
dw 0xAA55
