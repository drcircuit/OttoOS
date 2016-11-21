; Author: Espen Sande Larsen
;Created On: 3/1/2016 8:06:39 PM
[BITS 16]
[ORG 7c0h]



cli
xor ax,ax
call clearScr
mov si, load
call grey
call printString
mov di, 1
mov si, loading
call printString
call green
xor di, di
mov si, complete
call printString
call printNL
call printNL
xor di,di

waiting:
call waitAbit
inc di
cmp di, 5
jb waiting
call grey
mov si, welcome
call printString
call printNL
call blue
mov si, osName
call printString
mov si, version
call printString
call printNL
call blue
mov si, credits
call printString
call printNL

userInput:
call printNL
call promptUser
push ax
call printNL
pop ax
cmp al, 0x77
je win
cmp al, 0x62
je basep
cmp al, 0x79
je yng
jmp errors

yng:
mov si, yngvis
call yellow
call printString
jmp userInput

win:
mov si, winError
call red
call printString
jmp userInput

basep:
mov si, base
call green
call printString
jmp userInput

errors:
mov si, error
call red
call printString
jmp userInput

promptUser:
call grey
mov ah, 1
mov si, prompt
call printString
call readInputChar
call printSingleChar
ret

readInputChar:
mov ah, 00h
int 16h
ret	

printNL:
mov si, newline
call printString
ret

clearScr:
mov ah, 00h
mov al, 03h
xor dx,dx
int 10h
ret

printSingleChar:
mov ah, 09h
mov bh, 0
mov cx, 1
int 10h
ret

printString:
loops: 
cmp di, 1
jne continue
call waitAbit
continue:
lodsb
or al, al
jz return
cmp al, 0x0A
je end
call printSingleChar
mov ah,02h
inc dl
int 10h
jmp loops
end:
mov ah, 02h
inc dh
cmp dh, 24
jne noClear
call clearScr

noClear:
xor dl,dl
int 10h
return:
ret

waitAbit:
push dx
mov ah, 86h
mov dx, 10
int 15h
pop dx
ret
green:
mov bl, 0Ah
ret

red: 
mov bl, 0Ch
ret

blue:
mov bl, 03h
ret
     
yellow:
mov bl, 0Eh
ret

grey:
mov bl, 07h
ret

load: db 'Loading ',0
loading: db '.............. ',0
complete: db '[OK]',0
welcome: db 'Welcome to:',0
osName: db ' Compello OS ',0
version: db 'version 1.3.3.7',0
credits: db ' Written by O^2',0
error: db 'ERROR! NO SUCH COMMAND!',0
base: db 'ALL YOUR BASE ARE BELONG TO US!',0
winError: db 'No windows found, are they open?',0
yngvis: db 'A man who eats steak has an animal inside him',0
prompt: db 'OS>',0
newline: db 0x0A

times 510-($-$$) db 0
dw 0xAA55
