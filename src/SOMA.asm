section .text
; dados externos
extern aux_str, tamanho, msg_numero, msg_resultado
; funcoes externas
extern print32, print16, printstr, read32, read16

; funcoes publicas
global soma
soma:   ; se tamanho = 0, vai para soma de 16 bits
        cmp byte [tamanho], 0
        je soma16
        ; 32 bits
        ; comeca o frame de pilha com 4 bytes reservados para uma variavel local
        enter 4, 0

        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read32
        ; guarda o primeiro numero como variavel local
        mov [ebp-4], eax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read32

        ; soma segundo numero ao primeiro que esta como variavel local
        add [ebp-4], eax

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 32 bits
        push dword [ebp-4]
        push aux_str
        call print32
    
        leave
        ret

        ; 16 bits
soma16: ; comeca o frame de pilha com 2 bytes reservados para uma variavel local
        enter 2, 0
        
        push msg_numero
        call printstr
        ; ler numero usuario
        push aux_str
        call read16
        ; guarda o primeiro numero como variavel local
        mov [ebp-2], ax

        push msg_numero
        call printstr
        ; ler segundo numero
        push aux_str
        call read16

        ; soma segundo numero ao primeiro que esta como variavel local
        add [ebp-2], ax

        ; imprime resultado
        push msg_resultado
        call printstr
        ; printa resultado de 16 bits
        push word [ebp-2]
        push aux_str
        call print16
    
        leave
        ret
