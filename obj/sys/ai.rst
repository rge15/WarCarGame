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
                             11 .globl _m_game_createEnemy
                             12 .globl _m_game_destroyEntity
                             13 .globl _m_functionMemory
                             14 .globl _m_signatureMatch
                             15 
                             16 
                             17 ;===================================================================================================================================================
                             18 ; Manager data
                             19 ;===================================================================================================================================================
   420D                      20 _sys_ai_behaviourMemory::
   420D                      21     .ds 2
                             22 
                             23 ;===================================================================================================================================================
                             24 ; FUNCION _sys_ai_update
                             25 ; Llama a la inversión de control para updatear el comportamiento de 
                             26 ; las entidades que coincida con e_type_movable
                             27 ; NO llega ningun dato
                             28 ;===================================================================================================================================================
   420F                      29 _sys_ai_update::
   420F 21 1E 42      [10]   30     ld hl, #_sys_ai_updateOneEntity
   4212 22 F5 40      [16]   31     ld (_m_functionMemory), hl
   4215 21 F7 40      [10]   32     ld hl , #_m_signatureMatch 
   4218 36 0A         [10]   33     ld (hl), #0x0A ;;  e_type_movable | e_type_ai
   421A CD 27 41      [17]   34     call _man_entityForAllMatching
   421D C9            [10]   35     ret
                             36 
                             37 ;===================================================================================================================================================
                             38 ; FUNCION _sys_ai_updateOneEntity
                             39 ; Busca el comportamiento de la entidad y lo ejecuta 
                             40 ; HL : LA entidad a updatear
                             41 ;===================================================================================================================================================
   421E                      42 _sys_ai_updateOneEntity::    
                             43     ; ex de, hl
   421E 3E 0A         [ 7]   44     ld a,#0x0A
   4220                      45     searchBehaviour:
   4220 23            [ 6]   46         inc hl
   4221 3D            [ 4]   47         dec a
   4222 20 FC         [12]   48         jr NZ, searchBehaviour
                             49     
   4224 DD 21 46 42   [14]   50     ld ix, #updatedOneEntity
   4228 DD E5         [15]   51     push ix
                             52 
                             53     ;ex de, hl
   422A E5            [11]   54     push hl
   422B 7E            [ 7]   55     ld a, (hl)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   422C 21 0D 42      [10]   56     ld hl, #_sys_ai_behaviourMemory
   422F 77            [ 7]   57     ld (hl),a
   4230 E1            [10]   58     pop hl
   4231 E5            [11]   59     push hl
   4232 23            [ 6]   60     inc hl
   4233 7E            [ 7]   61     ld a, (hl)
   4234 21 0D 42      [10]   62     ld hl, #_sys_ai_behaviourMemory
   4237 23            [ 6]   63     inc hl
   4238 77            [ 7]   64     ld (hl),a
   4239 E1            [10]   65     pop hl
                             66 
   423A 3E 0A         [ 7]   67     ld a,#0x0A
   423C                      68     searchEntityType:
   423C 2B            [ 6]   69         dec hl
   423D 3D            [ 4]   70         dec a
   423E 20 FC         [12]   71         jr NZ, searchEntityType
                             72 
   4240 DD 2A 0D 42   [20]   73     ld ix, (#_sys_ai_behaviourMemory)
   4244 DD E9         [ 8]   74     jp (ix)
                             75 
   4246                      76     updatedOneEntity:
                             77     
   4246 C9            [10]   78     ret
                             79 
                             80 
                             81 ;===================================================================================================================================================
                             82 ; FUNCION _sys_ai_behaviourEnemy
                             83 ; Comportamiento de la MotherShip
                             84 ; 1º Intenta crear un enemigo hijo
                             85 ; 2º Se mueve de derecha a izquierda hasta los bordes
                             86 ; HL : Entidad a updatear
                             87 ;===================================================================================================================================================
   4247                      88 _sys_ai_behaviourEnemy::
                             89 
                             90     ;; TODO : IA del enemigo
   4247 CD 4B 42      [17]   91     call _sys_ai_behaviourLeftRight
                             92 
   424A C9            [10]   93     ret
                             94 
                             95 
                             96 
                             97 
                             98 ;===================================================================================================================================================
                             99 ; FUNCION _sys_ai_behaviourLeftRight
                            100 ; Si llega a alguno de los bordes establece su velocidad en la direccion contraria
                            101 ; HL : Entidad a updatear
                            102 ;===================================================================================================================================================
   424B                     103 _sys_ai_behaviourLeftRight::
   424B 3E 50         [ 7]  104     ld a, #0x50
   424D 23            [ 6]  105     inc hl
   424E 23            [ 6]  106     inc hl
   424F 46            [ 7]  107     ld b,(hl) ;; b = x
   4250 23            [ 6]  108     inc hl
   4251 23            [ 6]  109     inc hl
   4252 96            [ 7]  110     sub (hl)  ;; a = right bound
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   4253 23            [ 6]  111     inc hl
   4254 23            [ 6]  112     inc hl 
   4255 04            [ 4]  113     inc b
   4256 05            [ 4]  114     dec b
   4257 28 09         [12]  115     jr Z, leftPart
                            116 
   4259 4F            [ 4]  117     ld c,a
   425A 78            [ 4]  118     ld a,b
   425B 41            [ 4]  119     ld b,c
                            120 
   425C 90            [ 4]  121     sub b
   425D 28 08         [12]  122     jr Z, rightPart
                            123 
   425F C3 69 42      [10]  124     jp exitUpdate
   4262                     125     leftPart:
   4262 36 01         [10]  126         ld (hl), #0x01
   4264 C3 69 42      [10]  127         jp exitUpdate
                            128 
   4267                     129     rightPart:
   4267 36 FF         [10]  130         ld (hl), #0xFF
                            131 
   4269                     132     exitUpdate:
   4269 C9            [10]  133     ret
                            134 
                            135 
                            136 
                            137 ;===================================================================================================================================================
                            138 ; FUNCION _sys_ai_behaviourAutoDestroy
                            139 ; Destruye la entidad pasado el tiempo del contador de la IA
                            140 ; HL : Entidad a updatear
                            141 ;===================================================================================================================================================
                            142 
                            143 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            144 ;Esto lo dejo aquí pero dudo que lo usemos
                            145 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                            146 
   426A                     147 _sys_ai_behaviourAutoDestroy::
   426A 3E 0C         [ 7]  148     ld a,#0x0C
   426C                     149     searchAICounter:
   426C 23            [ 6]  150         inc hl
   426D 3D            [ 4]  151         dec a
   426E 20 FC         [12]  152         jr NZ, searchAICounter
                            153     
   4270 35            [11]  154     dec (hl)
   4271 20 09         [12]  155     jr NZ, dontDestroy
                            156     
   4273 3E 0C         [ 7]  157     ld a,#0x0C
   4275                     158     searchType:
   4275 2B            [ 6]  159         dec hl
   4276 3D            [ 4]  160         dec a
   4277 20 FC         [12]  161         jr NZ, searchType
                            162 
   4279 CD FA 41      [17]  163     call _m_game_destroyEntity
                            164     
   427C                     165     dontDestroy:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            166     
   427C C9            [10]  167     ret
