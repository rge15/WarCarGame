ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; CPCTelera functions
                              3 ;===================================================================================================================================================
                              4 .globl cpct_waitHalts_asm
                              5 .globl cpct_waitVSYNC_asm
                              6 .globl cpct_memcpy_asm
                              7 
                              8 ;===================================================================================================================================================
                              9 ; Public functions
                             10 ;===================================================================================================================================================
                             11 .globl _man_entityInit
                             12 .globl _man_entityDestroy
                             13 .globl _man_entityUpdate
                             14 .globl _man_createEntity
                             15 .globl _sys_physics_update
                             16 .globl _sys_init_render
                             17 .globl _sys_render_update
                             18 .globl _sys_animator_update
                             19 .globl _sys_ai_update
                             20 
                             21 ;===================================================================================================================================================
                             22 ; includes
                             23 ;===================================================================================================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             24 .include "resources/macros.s"
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
                             27 ; Templates
                             28 ;===================================================================================================================================================
                             29 .globl _player_template_e
                             30 
                             31 ;===================================================================================================================================================
                             32 ; Manager data
                             33 ;===================================================================================================================================================
                             34 
                             35 ;;Descripcion : Saber si el jugador ha disparado ya 
   41BD                      36 _m_playerShot:
   41BD 00                   37    .db #0x00
                             38 
                             39 ;;Descripcion : Posición de memoria de la entidad del jugador
   41BE                      40 _m_playerEntity:
   41BE 00 00                41    .dw #0x0000
                             42 ;===================================================================================================================================================
                             43 ; FUNCION _m_game_createInitTemplate   
                             44 ; Crea la entidad con el template indicado
                             45 ; BC : Valor de template a crear
                             46 ;===================================================================================================================================================
   41C0                      47 _m_game_createInitTemplate::
   41C0 CD 12 41      [17]   48    call _man_createEntity
   41C3 E5            [11]   49    push hl
   41C4 EB            [ 4]   50    ex de,hl
   41C5 60            [ 4]   51    ld h, b
   41C6 69            [ 4]   52    ld l, c
   41C7 01 10 00      [10]   53    ld bc,#0x0010
   41CA CD DE 44      [17]   54    call cpct_memcpy_asm
   41CD E1            [10]   55    pop hl
   41CE C9            [10]   56    ret
                             57 
                             58 
                             59 ;===================================================================================================================================================
                             60 ; FUNCION _m_game_init   
                             61 ; Inicializa el juego y sus entidades
                             62 ; NO llega ningun dato
                             63 ;===================================================================================================================================================
   41CF                      64 _m_game_init::
   41CF CD 42 43      [17]   65    call  _sys_init_render
   41D2 CD FA 40      [17]   66    call  _man_entityInit
                             67 
                             68    ; CreatePlayer & Save in _m_playerEntity   
   0018                      69    CREATE_ENTITY_FROM_TEMPLATE _player_template_e 
   41D5 01 72 40      [10]    1     ld bc, #_player_template_e
   41D8 CD C0 41      [17]    2     call _m_game_createInitTemplate
   41DB EB            [ 4]   70    ex de,hl
   41DC 21 BE 41      [10]   71    ld hl, #_m_playerEntity
   41DF 72            [ 7]   72    ld (hl), d
   41E0 23            [ 6]   73    inc hl
   41E1 73            [ 7]   74    ld (hl), e
   41E2 EB            [ 4]   75    ex de,hl
   41E3 C9            [10]   76 ret
                             77 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             78 
                             79 ;===================================================================================================================================================
                             80 ; FUNCION _m_game_play   
                             81 ; Bucle del juego
                             82 ; NO llega ningun dato
                             83 ;===================================================================================================================================================
   41E4                      84 _m_game_play::
   41E4                      85    updates:
   41E4 CD 0F 42      [17]   86       call _sys_ai_update
                             87       ;call _sys_input_update
   41E7 CD D7 42      [17]   88       call _sys_physics_update
   41EA CD 7D 42      [17]   89       call _sys_animator_update
   41ED CD 54 43      [17]   90       call _sys_render_update
                             91       
   41F0 CD 98 41      [17]   92       call _man_entityUpdate
   41F3 CD FF 41      [17]   93       call _wait
   41F6 18 EC         [12]   94    jr updates
                             95 
   41F8 C9            [10]   96 ret
                             97 
                             98 ;===================================================================================================================================================
                             99 ; FUNCION _m_game_createEnemy   
                            100 ; Crea un enemigo
                            101 ; NO llega ningun dato
                            102 ;===================================================================================================================================================
   41F9                     103 _m_game_createEnemy::
                            104    ;Create Enemy
                            105    ;ld bc, #_enemy_template_e   
                            106    ;call _m_game_createInitTemplate   
                            107    
   41F9 C9            [10]  108    ret
                            109 
                            110 
                            111 ;===================================================================================================================================================
                            112 ; FUNCION _m_game_destroyEntity
                            113 ; Funcion que destruye la entidad indicada
                            114 ; HL : Llega el valor de la entidad
                            115 ;===================================================================================================================================================
   41FA                     116 _m_game_destroyEntity::
   41FA CD 61 41      [17]  117    call _man_entityDestroy
   41FD C9            [10]  118    ret
                            119 
                            120 
                            121 ;===================================================================================================================================================
                            122 ; FUNCION _m_game_playerShot
                            123 ; Funcion que dispara si puede
                            124 ; NO llega nada
                            125 ;===================================================================================================================================================
   41FE                     126 _m_game_playerShot::
                            127    ;;; TODO : Create Shot
                            128    ;Checkear si se puede crear
                            129    ;Si se puede crear, crear la entidad
                            130    ;ponerle la posicion correcta a la bala en el cañon del tanque saliendo
                            131    ;e incrementar el contador de disparos del jugador
                            132 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            133 ; =================================================  
                            134 ;     PEGAR UN OJO A VER SI SE PUEDE REUTILIZAR
                            135 ; =================================================
                            136 ;    ld hl,#_m_playerShot
                            137 ;    dec (hl)
                            138 ;    inc (hl)
                            139 ;    ret NZ
                            140 
                            141 ;    ld bc, #_shot_template_e   
                            142 ;    call _m_game_createInitTemplate
                            143 
                            144 ;    inc hl
                            145 ;    inc hl      ;; HL lo subo a x del shoot
                            146 ;    ex de,hl
                            147 
                            148 ;    ld hl, #_m_playerEntity ;; Recojo la posicion de la entidad jugador
                            149 ;    ld b,(hl)
                            150 ;    inc hl
                            151 ;    ld c,(hl)
                            152 ;    ld h,b
                            153 ;    ld l,c
                            154 ;    inc hl
                            155 ;    inc hl  ;; Una vez obtenida la direccion del inicio del jugador, cojo si x y le sumo 2 y se la guardo al shoot
                            156 ;    ld a,(hl)
                            157 ;    add #0x02
                            158 ;    ex de,hl
                            159 ;    ld (hl),a
                            160 
                            161 ;    ld hl,#_m_playerShot
                            162 ;    inc (hl)
                            163 
   41FE C9            [10]  164    ret
                            165 
                            166 ;===================================================================================================================================================
                            167 ; FUNCION _wait   
                            168 ; Espera un tiempo antes de realizar otra iteracion del bucle de juego
                            169 ; NO llega ningun dato
                            170 ;===================================================================================================================================================
                            171 
   41FF                     172 _wait::
   41FF 26 05         [ 7]  173    ld h, #0x05
   4201                     174       waitLoop:
   4201 06 02         [ 7]  175          ld b, #0x02
   4203 CD BD 44      [17]  176          call cpct_waitHalts_asm
   4206 CD CE 44      [17]  177          call cpct_waitVSYNC_asm
   4209 25            [ 4]  178          dec h
   420A 20 F5         [12]  179          jr NZ, waitLoop
   420C C9            [10]  180    ret
