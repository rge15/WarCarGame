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
   4225                      20 _sys_ai_behaviourMemory::
   4225                      21     .ds 2
                             22 
                             23 ;===================================================================================================================================================
                             24 ; FUNCION _sys_ai_update
                             25 ; Llama a la inversión de control para updatear el comportamiento de 
                             26 ; las entidades que coincida con e_type_movable
                             27 ; NO llega ningun dato
                             28 ;===================================================================================================================================================
   4227                      29 _sys_ai_update::
   4227 21 36 42      [10]   30     ld hl, #_sys_ai_updateOneEntity
   422A 22 0D 41      [16]   31     ld (_m_functionMemory), hl
   422D 21 0F 41      [10]   32     ld hl , #_m_signatureMatch 
   4230 36 0A         [10]   33     ld (hl), #0x0A ;;  e_type_movable | e_type_ai
   4232 CD 3F 41      [17]   34     call _man_entityForAllMatching
   4235 C9            [10]   35     ret
                             36 
                             37 ;===================================================================================================================================================
                             38 ; FUNCION _sys_ai_updateOneEntity
                             39 ; Busca el comportamiento de la entidad y lo ejecuta 
                             40 ; HL : LA entidad a updatear
                             41 ;===================================================================================================================================================
   4236                      42 _sys_ai_updateOneEntity::    
                             43     ; ex de, hl
   4236 3E 0A         [ 7]   44     ld a,#0x0A
   4238                      45     searchBehaviour:
   4238 23            [ 6]   46         inc hl
   4239 3D            [ 4]   47         dec a
   423A 20 FC         [12]   48         jr NZ, searchBehaviour
                             49     
   423C DD 21 5E 42   [14]   50     ld ix, #updatedOneEntity
   4240 DD E5         [15]   51     push ix
                             52 
                             53     ;ex de, hl
   4242 E5            [11]   54     push hl
   4243 7E            [ 7]   55     ld a, (hl)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4244 21 25 42      [10]   56     ld hl, #_sys_ai_behaviourMemory
   4247 77            [ 7]   57     ld (hl),a
   4248 E1            [10]   58     pop hl
   4249 E5            [11]   59     push hl
   424A 23            [ 6]   60     inc hl
   424B 7E            [ 7]   61     ld a, (hl)
   424C 21 25 42      [10]   62     ld hl, #_sys_ai_behaviourMemory
   424F 23            [ 6]   63     inc hl
   4250 77            [ 7]   64     ld (hl),a
   4251 E1            [10]   65     pop hl
                             66 
   4252 3E 0A         [ 7]   67     ld a,#0x0A
   4254                      68     searchEntityType:
   4254 2B            [ 6]   69         dec hl
   4255 3D            [ 4]   70         dec a
   4256 20 FC         [12]   71         jr NZ, searchEntityType
                             72 
   4258 DD 2A 25 42   [20]   73     ld ix, (#_sys_ai_behaviourMemory)
   425C DD E9         [ 8]   74     jp (ix)
                             75 
   425E                      76     updatedOneEntity:
                             77     
   425E C9            [10]   78     ret
                             79 
                             80 
                             81 ;===================================================================================================================================================
                             82 ; FUNCION _sys_ai_behaviourEnemy
                             83 ; Comportamiento de la MotherShip
                             84 ; 1º Intenta crear un enemigo hijo
                             85 ; 2º Se mueve de derecha a izquierda hasta los bordes
                             86 ; HL : Entidad a updatear
                             87 ;===================================================================================================================================================
   425F                      88 _sys_ai_behaviourEnemy::
                             89 
                             90     ;; TODO : IA del enemigo
   425F CD 63 42      [17]   91     call _sys_ai_behaviourLeftRight
                             92 
   4262 C9            [10]   93     ret
                             94 
                             95 
                             96 
                             97 
                             98 ;===================================================================================================================================================
                             99 ; FUNCION _sys_ai_behaviourLeftRight
                            100 ; Si llega a alguno de los bordes establece su velocidad en la direccion contraria
                            101 ; HL : Entidad a updatear
                            102 ;===================================================================================================================================================
   4263                     103 _sys_ai_behaviourLeftRight::
   4263 3E 50         [ 7]  104     ld a, #0x50
   4265 23            [ 6]  105     inc hl
   4266 23            [ 6]  106     inc hl
   4267 46            [ 7]  107     ld b,(hl) ;; b = x
   4268 23            [ 6]  108     inc hl
   4269 23            [ 6]  109     inc hl
   426A 96            [ 7]  110     sub (hl)  ;; a = right bound
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   426B 23            [ 6]  111     inc hl
   426C 23            [ 6]  112     inc hl 
   426D 04            [ 4]  113     inc b
   426E 05            [ 4]  114     dec b
   426F 28 09         [12]  115     jr Z, leftPart
                            116 
   4271 4F            [ 4]  117     ld c,a
   4272 78            [ 4]  118     ld a,b
   4273 41            [ 4]  119     ld b,c
                            120 
   4274 90            [ 4]  121     sub b
   4275 28 08         [12]  122     jr Z, rightPart
                            123 
   4277 C3 81 42      [10]  124     jp exitUpdate
   427A                     125     leftPart:
   427A 36 01         [10]  126         ld (hl), #0x01
   427C C3 81 42      [10]  127         jp exitUpdate
                            128 
   427F                     129     rightPart:
   427F 36 FF         [10]  130         ld (hl), #0xFF
                            131 
   4281                     132     exitUpdate:
   4281 C9            [10]  133     ret
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
   4282                     147 _sys_ai_behaviourAutoDestroy::
   4282 3E 0C         [ 7]  148     ld a,#0x0C
   4284                     149     searchAICounter:
   4284 23            [ 6]  150         inc hl
   4285 3D            [ 4]  151         dec a
   4286 20 FC         [12]  152         jr NZ, searchAICounter
                            153     
   4288 35            [11]  154     dec (hl)
   4289 20 09         [12]  155     jr NZ, dontDestroy
                            156     
   428B 3E 0C         [ 7]  157     ld a,#0x0C
   428D                     158     searchType:
   428D 2B            [ 6]  159         dec hl
   428E 3D            [ 4]  160         dec a
   428F 20 FC         [12]  161         jr NZ, searchType
                            162 
   4291 CD 12 42      [17]  163     call _m_game_destroyEntity
                            164     
   4294                     165     dontDestroy:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            166     
   4294 C9            [10]  167     ret
