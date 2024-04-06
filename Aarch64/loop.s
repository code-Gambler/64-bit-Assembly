 .text
 .globl _start
 min = 0                          /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
 max = 10                         /* loop exits when the index hits this number (loop condition is i<max) */
 _start:
     mov     x19, min
 loop:
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
msg:    .ascii      "Loop\n"
len=    . - msg