ORG 100h

start:
    
    mov ax, cs         ; Set up data segment
    mov ds, ax

    ; Initialize 16-bit dividend and divisor
    mov ax, [dividend]
    xor dx, dx         
    mov bx, [divisor]  

    div bx             
                       
    mov [quotient], ax 
    mov [remainder], dx 

    ; Print message for quotient
    mov dx, offset msg_quotient
    mov ah, 09h        
    int 21h

    ; Print 16-bit quotient
    mov ax, [quotient]
    call print_hex     

    ; Print new line
    mov dl, 0Dh        
    mov ah, 02h
    int 21h
    mov dl, 0Ah        
    int 21h

    mov dx, offset msg_remainder
    mov ah, 09h        
    int 21h

    ; Print 16-bit remainder
    mov ax, [remainder]
    call print_hex    

    mov ah, 4Ch
    int 21h

; Procedure to print 16-bit number in AX as hexadecimal
print_hex proc
    ; Print high byte
    mov ah, al         
    shr al, 4          
    and al, 0Fh        
    call print_digit   

    ; Print low nibble
    mov al, ah        
    and al, 0Fh       
    call print_digit   

   
    mov ah, al         
    shr al, 4
    and al, 0Fh
    call print_digit

    ; Print low nibble of next byte
    mov al, ah
    and al, 0Fh
    call print_digit

    ret
print_hex endp

; Procedure to print a single hex digit
print_digit proc
    add al, 30h        
    cmp al, 39h        
    jle print_it       
    add al, 7          
print_it:
    mov dl, al        
    mov ah, 02h        
    int 21h
    ret
print_digit endp

; Data Section
dividend  dw 64h      
divisor   dw 22h     
quotient  dw 0          
remainder dw 0          

msg_quotient db "Quotient: $"
msg_remainder db "Remainder: $"

