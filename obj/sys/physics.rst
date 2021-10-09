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
                             22 ; FUNCION _sys_physics_update
                             23 ; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
                             24 ; NO llega ningun dato
                             25 ;===================================================================================================================================================
   42D7                      26 _sys_physics_update::
   42D7 21 1B 43      [10]   27     ld hl, #_sys_physics_updateOneEntity
   42DA 22 F5 40      [16]   28     ld (_m_functionMemory), hl
   42DD 21 F7 40      [10]   29     ld hl , #_m_signatureMatch 
   42E0 36 02         [10]   30     ld (hl), #0x02  ; e_type_movable
   42E2 CD 27 41      [17]   31     call _man_entityForAllMatching
   42E5 C9            [10]   32     ret
                             33 
                             34 ;===================================================================================================================================================
                             35 ; FUNCION _sys_physics_checkKeyboard
                             36 ; Cambia el valor de la velocidad en x si se pulsa la tecla : O o P
                             37 ; Y manda la orden de disparar si pulsa Espacio
                             38 ; HL : LA entidad a updatear
                             39 ;===================================================================================================================================================
   42E6                      40 _sys_physics_checkKeyboard::
   42E6 23            [ 6]   41     inc hl
   42E7 23            [ 6]   42     inc hl
   42E8 23            [ 6]   43     inc hl
   42E9 23            [ 6]   44     inc hl
   42EA 23            [ 6]   45     inc hl
   42EB 23            [ 6]   46     inc hl
   42EC E5            [11]   47     push hl
                             48 
   42ED CD 93 43      [17]   49     call cpct_scanKeyboard_f_asm
                             50     
   42F0 21 04 04      [10]   51     ld hl, #0x0404  ;;Key O
   42F3 CD FD 43      [17]   52     call cpct_isKeyPressed_asm
   42F6 20 0E         [12]   53     jr NZ, leftPressed
                             54 
   42F8 21 03 08      [10]   55     ld hl, #0x0803 ;;Key P
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   42FB CD FD 43      [17]   56     call cpct_isKeyPressed_asm
   42FE 20 0C         [12]   57     jr NZ, rightPressed
                             58 
   4300 E1            [10]   59     pop hl
   4301 36 00         [10]   60     ld (hl), #0x00
                             61 
   4303 C3 0F 43      [10]   62     jp stopCheckMovement
   4306                      63     leftPressed:
   4306 E1            [10]   64         pop hl
   4307 36 FF         [10]   65         ld (hl), #0xFF
   4309 C3 0F 43      [10]   66         jp stopCheckMovement
   430C                      67     rightPressed:
   430C E1            [10]   68         pop hl
   430D 36 01         [10]   69         ld (hl), #0x01
                             70 
   430F                      71     stopCheckMovement:
                             72 
   430F 21 05 80      [10]   73     ld hl, #0x8005 ;;Key SpaceBar
   4312 CD FD 43      [17]   74     call cpct_isKeyPressed_asm
   4315 28 03         [12]   75     jr Z, dontShoot
   4317 CD FE 41      [17]   76     call _m_game_playerShot
                             77 
   431A                      78     dontShoot:
   431A C9            [10]   79     ret
                             80 
                             81 
                             82 ;===================================================================================================================================================
                             83 ; FUNCION _sys_physics_updateOneEntity
                             84 ; Updatea las posiciones de las entidades en funcion de 
                             85 ; los valores de sus velocidades
                             86 ; HL : Entidad a updatear
                             87 ;===================================================================================================================================================
   431B                      88 _sys_physics_updateOneEntity::    
   431B E5            [11]   89     push hl
   431C 23            [ 6]   90     inc hl
   431D 7E            [ 7]   91     ld a,(hl) 
   431E 2B            [ 6]   92     dec hl
   431F E6 04         [ 7]   93     and #0x04
   4321 44            [ 4]   94     ld b,h
   4322 4D            [ 4]   95     ld c,l
   4323 28 03         [12]   96     jr Z,noInput
   4325 CD E6 42      [17]   97     call _sys_physics_checkKeyboard
   4328                      98     noInput:
   4328 E1            [10]   99     pop hl
                            100 
   4329 23            [ 6]  101     inc hl
   432A 23            [ 6]  102     inc hl
   432B 46            [ 7]  103     ld  b,(hl) ; posX
   432C 23            [ 6]  104     inc hl
   432D 56            [ 7]  105     ld  d,(hl) ; posY 
                            106 
   432E 23            [ 6]  107     inc hl
   432F 23            [ 6]  108     inc hl
   4330 23            [ 6]  109     inc hl
   4331 4E            [ 7]  110     ld c,(hl) ; velX
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   4332 23            [ 6]  111     inc hl
   4333 5E            [ 7]  112     ld e,(hl) ; vely
                            113 
   4334 3E 05         [ 7]  114     ld a, #0x05
   4336                     115     setHLposX:
   4336 2B            [ 6]  116         dec hl
   4337 3D            [ 4]  117         dec a
   4338 20 FC         [12]  118         jr NZ, setHLposX
                            119 
   433A 78            [ 4]  120     ld a,b
   433B 81            [ 4]  121     add a,c
   433C 77            [ 7]  122     ld (hl),a
                            123 
   433D 23            [ 6]  124     inc hl
                            125     
   433E 7A            [ 4]  126     ld a,d
   433F 83            [ 4]  127     add a,e
   4340 77            [ 7]  128     ld (hl),a
                            129     
   4341 C9            [10]  130    ret
