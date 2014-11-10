; A palindromic number reads the same both ways. The largest palindrome 
; made from the product of two 2-digit numbers is 9009 = 91 × 99.

; Find the largest palindrome made from the product of two 3-digit numbers.

; ebx ecx
; 999 999
; 998 999
; 998 998
; 997 999
; 997 998
; 997 997
; 996 999
; 996 998
; 996 997
; 996 996

; eax = 9009, digit = 0
; div by 10. eax = 900, edx = 9
; mov [decimal + digit], edx (decimal, as 6 numbers: 9 ? ? ? ? ?)
; digit++ (digit is 1 now)
; check if eax is 0. if not, loop.
; div by 10. eax = 90, edx = 0
; mov [decimal + digit], edx (decimal, as 6 numbers: 9 0 ? ? ? ?)
; digit++ (digit is 2 now)
; check if eax is 0. if not, loop
; div by 10. eax = 9, edx = 0
; mov [decimal + digit], edx (decimal, as 6 numbers: 9 0 0 ? ? ?)
; digit++ (digit is 3 now)
; check if eax is 0. if not, loop
; div by 10. eax = 0, edx = 9
; mov [decimal + digit], edx (decimal, as 6 numbers: 9 0 0 9 ? ?)
; digit++ (digit is 4 now)
; check if eax is 0... it is, so check for palindrome-ness.
; index1 = 0. index2 = digit - 1, i.e. 3.
; compare index1 to index2. if greater or equal, pass.
; compare [decimal + index1] (9) and [decimal + index2] (9). if not equal, fail
; index1++ (now 1), index2-- (now 2).
; compare index1 to index2. if greater or equal, pass.
; compare [decimal + index1] (0) and [decimal + index2] (0). if not equal, fail
; index1++ (now 2), index2-- (now 1).
; compare index1 to index2. if greater or equal, pass. (yes! pass!)

define product eax
define digit   rbp
define index1  r11
define index2  rbp
define decimal rdi

include "startp.inc"
  mov esi, 1000
  mov ebx, esi       ; start 1 greater because dec immediately
  mov r10, 10        ; for div for palindrome check
  lea decimal, [_decimal] ; ptr to decimal rep in memory
.outer:
  dec ebx            ; starts at 999
  mov ecx, esi       ; set to 1000, will dec to 999
  .inner:
     cmp ebx, ecx
     jge  .outer
     dec ecx         ; starts at 999 too
     ;; multiply ebx, ecx
     mov product, ebx
     mul ecx         ; result in product (eax)
     ;; make decimal representation
     mov rsi, product ; for printf later because decimalrep clobbers product
     xor digit, digit
     .decimalrep:
       xor rdx, rdx  ; div works on rdx:rax
       div r10       ; div rax by 10
       mov [4*digit + decimal], edx ; mult by 4 because each num is 4 bytes
       inc digit
       test eax, eax
       jnz .decimalrep
     ;; check if palindrome
     xor index1, index1
     ; lea index2, [digit-1] ; [] less a ptr, lea more a ptr, for fast dec+mov
     dec index2       ; same as digit
     .digitcomp:
       cmp index1, index2
       jge done      ; g or e depends on even or odd, will hit here eventually
       mov r12d, [4*index2 + decimal]
       cmp r12d, [4*index1 + decimal]
       jne .inner     ; not a palindrome, try another num
       inc index1
       dec index2
       jmp .digitcomp
done:
  lea rdi, [msg]
  call printf
  exit_0             ; from startp.inc

msg db 'The largest palindrome that is the product of 3 digit nums is %d',0xA,0x0
section 'decimal' writable   ; make _decimal writeable and not executable
_decimal rd 6  ; only up to 6 digits long
