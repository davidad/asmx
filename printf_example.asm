include "startp.inc"
  lea rdi, [msg]
  mov rsi, 42
  call printf

	xor	edi,edi
	mov	eax, SYSCALL_EXIT
	syscall

msg db 'The number is: %d',0xA,0x0
