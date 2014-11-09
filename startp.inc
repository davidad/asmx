format ELF64
include "syscalls.inc"
public start

extrn printf

start:
  and rsp, (not 0x0f)
