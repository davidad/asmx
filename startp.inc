format ELF64
include "syscalls.inc"
include "macros.inc"
public start

extrn printf    ; extrn is copublic

start:
  and rsp, (not 0x0f) ; for calling c fns, need to align rsp
