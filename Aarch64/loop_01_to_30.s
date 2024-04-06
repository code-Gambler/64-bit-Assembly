 .text
 .globl _start
 min = 0                          /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
 max = 31                         /* loop exits when the index hits this number (loop condition is i<max) */
div = 10
 _start:
     mov     x19, min
 loop:
     /* Convert Loop counter to char */
     mov     x10, x19
     mov     x12, div
     udiv    x11, x10, x12
     msub    x13, x12, x11, x10

     add     x15, x11, '0'
     adr     x14, msg+6
     strb    w15, [x14]
     add     x16, x13, '0'
     adr     x17, msg+7
     strb    w16, [x17]
     /* Print the Message */

     mov     x0, 1           /* file descriptor: 1 is stdout */
     adr     x1, msg         /* message location (memory address) */
     mov     x2, len         /* message length (bytes) */

     mov     x8, 64          /* write is syscall #64 */
     svc     0               /* invoke syscall */

     /* Continue the Loop */
     add     x19, x19, 1
     cmp     x19, max
     b.ne    loop

     /* Exit the Program */
     mov     x0, 0           /* status -> 0 */
     mov     x8, 93          /* exit is syscall #93 */
     svc     0               /* invoke syscall */

.data
msg:    .ascii      "Loop:  #\n"
len=    . - msg
