ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; CPCTelera functions
                              3 ;===================================================================================================================================================
                              4 .globl cpct_scanKeyboard_f_asm
                              5 .globl cpct_isKeyPressed_asm
                              6 
                              7 ;===================================================================================================================================================
                              8 ; includes
                              9 ;===================================================================================================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             10 .include "resources/entityInfo.s"
                              1 ;===================================================================================================================================================
                              2 ; Entity types   
                              3 ;===================================================================================================================================================
                              4 ; #define e_type_invalid     0x00
                              5 ; #define e_type_player      0x01
                              6 ; #define e_type_default     0x02 
                              7 ; #define e_type_dead        0x80
                              8 
                              9 ;===================================================================================================================================================
                             10 ; Component types   
                             11 ;===================================================================================================================================================
                             12 ; #define e_cmp_render   0x01
                             13 ; #define e_cmp_movable  0x02
                             14 ; #define e_cmp_input    0x04
                             15 ; #define e_cmp_ai       0x08
                             16 ; #define e_cmp_animated 0x10
                             17 ; #define e_cmp_collider 0x20
                             18 
                             19 ;===================================================================================================================================================
                             20 ; Entity variables    TODO : MIrar como puedo hacer defines para poder llamar al macro LOAD_ENTITY_VARIABLE_IN_REGISTER
                             21 ;===================================================================================================================================================
                     0000    22 e_type    =  0
                     0001    23 e_cmp     =  1
                     0002    24 e_xpos    =  2
                     0003    25 e_ypos    =  3
                     0004    26 e_width   =  4
                     0005    27 e_heigth  =  5
                     0006    28 e_vx      =  6
                     0007    29 e_vy      =  7
                     0008    30 e_sprite1 =  8
                     0009    31 e_sprite2 =  9
                     000A    32 e_aibeh1  = 10
                     000B    33 e_aibeh2  = 11
                     000C    34 e_anctr   = 12
                     000D    35 e_anim1   = 13
                     000E    36 e_anim2   = 14
                     000F    37 e_animctr = 15
                             38 
                             39 
                             40 
                             41 ;===================================================================================================================================================
                             42 ; Entity struct       TODO : Investigar si así guay la estruct
                             43 ;===================================================================================================================================================
                             44 ; entity:
                             45 ;    .db #0x00                      ; type
                             46 ;    .db #0x00                      ; components
                             47 ;    .db #0x00                      ; x-pos
                             48 ;    .db #0x00                      ; y-pos
                             49 ;    .db #0x00                      ; vx
                             50 ;    .db #0x00                      ; vy
                             51 ;    .db #0x00                      ; width
                             52 ;    .db #0x00                      ; heigth
                             53 ;    .dw #_sprite_spriteExample     ; sprite          
                             54 ;    .dw #_man_anim_animExample     ; animator
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 ;    .db #0x00                      ; anim. counter
                             56 ;    .dw #_sys_ai_behaviourExample  ; ai_behaviour
                             57 ;    .db #0x00                      ; ai_counter
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             11 
                             12 ;===================================================================================================================================================
                             13 ; Public functions
                             14 ;===================================================================================================================================================
                             15 .globl _man_entityForAllMatching
                             16 .globl _man_entityDestroy
                             17 .globl _man_setEntity4Destroy
                             18 .globl _m_game_playerShot
                             19 
                             20 ;===================================================================================================================================================
                             21 ; Public data
                             22 ;===================================================================================================================================================
                             23 .globl _m_functionMemory
                             24 .globl _m_signatureMatch
                             25 
                             26 ;===================================================================================================================================================
                             27 ; FUNCION _sys_physics_update
                             28 ; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
                             29 ; NO llega ningun dato
                             30 ;===================================================================================================================================================
   42F0                      31 _sys_physics_update::
   42F0 21 34 43      [10]   32     ld hl, #_sys_physics_updateOneEntity
   42F3 22 0D 41      [16]   33     ld (_m_functionMemory), hl
   42F6 21 0F 41      [10]   34     ld hl , #_m_signatureMatch 
   42F9 36 02         [10]   35     ld (hl), #0x02  ; e_type_movable
   42FB CD 3F 41      [17]   36     call _man_entityForAllMatching
   42FE C9            [10]   37     ret
                             38 
                             39 ;===================================================================================================================================================
                             40 ; FUNCION _sys_physics_checkKeyboard
                             41 ; Cambia el valor de la velocidad en x si se pulsa la tecla : O o P
                             42 ; Y manda la orden de disparar si pulsa Espacio
                             43 ; HL : LA entidad a updatear
                             44 ;===================================================================================================================================================
   42FF                      45 _sys_physics_checkKeyboard::
   42FF 23            [ 6]   46     inc hl
   4300 23            [ 6]   47     inc hl
   4301 23            [ 6]   48     inc hl
   4302 23            [ 6]   49     inc hl
   4303 23            [ 6]   50     inc hl
   4304 23            [ 6]   51     inc hl
   4305 E5            [11]   52     push hl
                             53 
   4306 CD 9C 43      [17]   54     call cpct_scanKeyboard_f_asm
                             55     
   4309 21 04 04      [10]   56     ld hl, #0x0404  ;;Key O
   430C CD 06 44      [17]   57     call cpct_isKeyPressed_asm
   430F 20 0E         [12]   58     jr NZ, leftPressed
                             59 
   4311 21 03 08      [10]   60     ld hl, #0x0803 ;;Key P
   4314 CD 06 44      [17]   61     call cpct_isKeyPressed_asm
   4317 20 0C         [12]   62     jr NZ, rightPressed
                             63 
   4319 E1            [10]   64     pop hl
   431A 36 00         [10]   65     ld (hl), #0x00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             66 
   431C C3 28 43      [10]   67     jp stopCheckMovement
   431F                      68     leftPressed:
   431F E1            [10]   69         pop hl
   4320 36 FF         [10]   70         ld (hl), #0xFF
   4322 C3 28 43      [10]   71         jp stopCheckMovement
   4325                      72     rightPressed:
   4325 E1            [10]   73         pop hl
   4326 36 01         [10]   74         ld (hl), #0x01
                             75 
   4328                      76     stopCheckMovement:
                             77 
   4328 21 05 80      [10]   78     ld hl, #0x8005 ;;Key SpaceBar
   432B CD 06 44      [17]   79     call cpct_isKeyPressed_asm
   432E 28 03         [12]   80     jr Z, dontShoot
   4330 CD 16 42      [17]   81     call _m_game_playerShot
                             82 
   4333                      83     dontShoot:
   4333 C9            [10]   84     ret
                             85 
                             86 
                             87 ;===================================================================================================================================================
                             88 ; FUNCION _sys_physics_updateOneEntity
                             89 ; Updatea las posiciones de las entidades en funcion de 
                             90 ; los valores de sus velocidades
                             91 ; HL : Entidad a updatear
                             92 ;===================================================================================================================================================
   4334                      93 _sys_physics_updateOneEntity::    
                             94     ; push hl
                             95     ; inc hl
                             96     ; ld a,(hl) 
                             97     ; dec hl
                             98     ; and #0x04
                             99     ; ld b,h
                            100     ; ld c,l
                            101     ; jr Z,noInput
                            102     ; call _sys_physics_checkKeyboard
                            103     ; noInput:
                            104     ; pop hl
                            105 
   4334 E5            [11]  106     push hl
   4335 DD E1         [14]  107     pop ix
   4337 DD 46 02      [19]  108     ld  b, e_xpos(ix) 
   433A DD 56 03      [19]  109     ld  d, e_ypos(ix) 
                            110 
   433D DD 4E 06      [19]  111     ld  c, e_vx(ix) 
   4340 DD 5E 07      [19]  112     ld  e, e_vy(ix) 
                            113 
   4343 78            [ 4]  114     ld a,b
   4344 81            [ 4]  115     add a,c
   4345 DD 77 02      [19]  116     ld e_xpos(ix),a
                            117 
                            118     
   4348 7A            [ 4]  119     ld a,d
   4349 83            [ 4]  120     add a,e
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   434A DD 77 03      [19]  121     ld e_ypos(ix),a
                            122     
   434D C9            [10]  123    ret
