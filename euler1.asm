; If we list all the natural numbers below 10 that are multiples of 3 or 5, we
; get 3, 5, 6 and 9. The sum of these multiples is 23.

; Find the sum of all the multiples of 3 or 5 below 1000.

define iter edi
define sum esi 

;; function in assembler language -> fancy #define
;;; divides iter by divisor and test whether mod is 0
macro modtest divisor {
  xor edx, edx ; 0 it out b/c concat for div
  mov eax, iter ; dividend in eax
  mov ecx, divisor ; divisor in unused
  div ecx
  test edx, edx ; is remainder 0?
}

include "startp.inc"
  mov iter, 999 
  xor sum, sum
subfizzbuzz:
  test iter, iter
  jz done
  modtest 3
  jz fizzbuzz
  modtest 5
  jnz nofizzbuzz ; if remainder != 0, go to no
fizzbuzz:
  add sum, iter ; sum += iter
  ; fizzbuzz now falls through to nofizzbuzz and also decs
nofizzbuzz:
  dec iter
  jmp subfizzbuzz
done:
  ;; print sum
  lea rdi, [msg] ; 1st arg to printf is ptr to str 
  call printf    ; sum is already 2nd arg
  ;; exit
  xor edi, edi
  mov eax, SYSCALL_EXIT
  syscall

msg db 'The sum of the numbers divisible by 3 or 5 less than 1000 is %d',0xA,0x0
