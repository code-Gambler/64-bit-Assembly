 .text
 .globl    _start
 min = 0                         /* starting value for the loop index; **note that this is a symbol (constant)**, not a variable */
 max = 31                        /* loop exits when the index hits this number (loop condition is i<max) */
div = 10
 _start:
     mov     $min,%r15           /* loop index */
 loop:
     /* Convert Loop Counter to char  */
     mov     $0, %rdx
     mov     %r15, %rax
     mov     $div, %r13
     div     %r13
     mov     %rax, %r12
     mov     %rdx, %r11
     add     $'0', %r12
     mov     %r12b, msg+6
     add     $'0', %r11
     mov     %r11b, msg+7

     /* Print the Message */
     movq    $len,%rdx                       /* message length */
     movq    $msg,%rsi                       /* message location */
     movq    $1,%rdi                         /* file descriptor stdout */
     movq    $1,%rax                         /* syscall sys_write */
     syscall

     /* Continue the Loop */
     inc     %r15                /* increment index */
     cmp     $max,%r15           /* see if we're done */
     jne     loop                /* loop if we're not */

     /* Exit the program */
     mov     $0,%rdi             /* exit status */
     mov     $60,%rax            /* syscall sys_exit */
     syscall

.section .data

msg:    .ascii      "Loop: ##\n"
        len = . - msg
