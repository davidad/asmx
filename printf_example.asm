format ELF64
include "syscalls.inc"
public start

extrn printf

start:
  and rsp, (not 0x0f)
  lea rdi, [msg]
  mov rsi, 42
  call printf

	xor	edi,edi
	mov	eax, SYSCALL_EXIT
	syscall

msg db 'The number is: %d',0xA,0x0
