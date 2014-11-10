macro exit_0 {
  xor edi, edi
  mov eax, SYSCALL_EXIT
  syscall
}

macro save [reg] {
  forward push qword reg
  common macro unsave \{
  reverse pop qword reg
  common purge unsave
  \}
}

macro zero [reg] {
  forward xor reg, reg
}
