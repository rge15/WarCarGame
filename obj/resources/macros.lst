ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .globl _macro_addresAux
                              2 
                              3 ;;Cargar el valor de _m_sizeOfEntity
                              4 .macro LOAD_VARIABLE_IN_REGISTER _var, _register
                              5     ld a, (#_var)
                              6     ld _register, a
                              7 .endm 
                              8 
                              9 ;;Cargar crear entidades con el template indicado
                             10 .macro CREATE_ENTITY_FROM_TEMPLATE _template
                             11     ld bc, #_template
                             12     call _m_game_createInitTemplate
                             13 .endm
                             14 
                             15 
                             16 
                             17 ;;;;;;;;;;;;;;;;;;;WORK ON PROGRESS ;;;;;;;;;;;;;;;;;;;;;;
                             18 ;;Carga en el registro A el campo que quieras de la struct de la entity
                             19 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             20 ; IMPORTANTE : NO SE PUEDE UTILIZAR EN EL REGISTRO A NI F
                             21 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             22 .macro LOAD_ENTITY_VARIABLE_IN_REGISTER _entity, _entity_var, _register
                             23     ; push af
                             24     ; push bc
                             25     ; push hl
                             26     push _entity
                             27     pop ix
                             28     ld _register, _entity_var(ix)
                             29 
                             30     ; ld b,h
                             31     ; ld c,l
                             32     ; ld hl, #_macro_addresAux
                             33     ; ld (hl), c
                             34     ; inc hl
                             35     ; ld (hl), b
                             36 
                             37     ; ld ix, #_macro_addresAux
                             38     ; ld a, _entity_var(ix)
                             39     
                             40     ; pop hl
                             41     ; pop bc
                             42 
                             43     ; ld _register, a
                             44 
                             45     ; pop af
                             46 .endm
                             47 
                             48 ;;Incrementa en 1 la variable indicada de la entidad indicada
                             49 .macro INCREMENT_ENTITY_VARIABLE _entity, _entity_var
                             50     push af
                             51     
                             52     ld _entityAux
                             53     ld ix, _entityAux
                             54     inc _entity_var(ix)
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56     pop af
                             57 .endm
                             58 
                             59 ;;Decrementa en 1 la variable indicada de la entidad indicada
                             60 .macro DECREMENT_ENTITY_VARIABLE _entity, _entity_var
                             61     push af
                             62     
                             63 
                             64     ld ix, _entity
                             65     dec _entity_var(ix)
                             66 
                             67     pop af
                             68 .endm
                             69 
                             70 ;;Comprueba si la tecla pasada por parametro se está pulsando
                             71 .macro CHECK_KEYBOARD_INPUT_IN_KEY _key
                             72     call cpct_scanKeyboard_f_asm
                             73     
                             74     ld hl, #_key
                             75     call cpct_isKeyPressed_asm
                             76 .endm 
