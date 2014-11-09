format ELF64
include "syscalls.inc"
public start

extrn printf    ; extrn is copublic

start:
  and rsp, (not 1111b) ; for calling c fns, need to align rsp
  lea rdi, [msg]
  mov rsi, 42
  call printf

	xor	edi,edi          ; 0 is arg for exit (ie success)
	mov eax, SYSCALL_EXIT
	syscall

msg db 'The number is: %d',0xA,0x0
