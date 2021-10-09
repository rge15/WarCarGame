ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; CPCTelera functions
                              3 ;===================================================================================================================================================
                              4 .globl cpct_scanKeyboard_f_asm
                              5 .globl cpct_isKeyPressed_asm
                              6 
                              7 ;===================================================================================================================================================
                              8 ; Public functions
                              9 ;===================================================================================================================================================
                             10 .globl _man_entityForAllMatching
                             11 .globl _man_entityDestroy
                             12 .globl _man_setEntity4Destroy
                             13 .globl _m_game_playerShot
                             14 
                             15 ;===================================================================================================================================================
                             16 ; Public data
                             17 ;===================================================================================================================================================
                             18 .globl _m_functionMemory
                             19 .globl _m_signatureMatch
                             20 
                             21 ;===================================================================================================================================================
                             22 ; Includes
                             23 ;===================================================================================================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             24 .include "resources/macros.s" ;;Info : Hay un macro todo wapo para ver si se pulsan la tecla indicada
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             25 
                             26 ;===================================================================================================================================================
                             27 ; Keyboard  TODO : Intentar hacerlo con el joystick sería la polla lironda
                             28 ;===================================================================================================================================================
                             29 .globl Key_D
                             30 .globl Key_A
                             31 .globl Key_W
                             32 .globl Key_S
                             33 .globl Key_Space
                             34 
                             35 ;===================================================================================================================================================
                             36 ; FUNCION _sys_input_update
                             37 ; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
                             38 ; NO llega ningun dato
                             39 ;===================================================================================================================================================
   42C7                      40 _sys_input_update::
   42C7 21 D6 42      [10]   41     ld hl, #_sys_input_updateOneEntity
   42CA 22 F5 40      [16]   42     ld (_m_functionMemory), hl
   42CD 21 F7 40      [10]   43     ld hl , #_m_signatureMatch 
   42D0 36 04         [10]   44     ld (hl), #0x04  ; e_type_input
   42D2 CD 27 41      [17]   45     call _man_entityForAllMatching
   42D5 C9            [10]   46     ret
                             47 
                             48 ;===================================================================================================================================================
                             49 ; FUNCION _sys_input_updateOneEntity
                             50 ; Updatea cada una de las entidades que tiene componente input
                             51 ; HL : Entidad a updatear
                             52 ;===================================================================================================================================================
   42D6                      53 _sys_input_updateOneEntity::    
                             54     
   42D6 C9            [10]   55    ret
