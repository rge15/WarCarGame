ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; CPCTelera functions
                              3 ;===================================================================================================================================================
                              4 .globl cpct_memset_asm
                              5 .globl cpct_memcpy_asm
                              6 
                              7 ;===================================================================================================================================================
                              8 ; includes
                              9 ;===================================================================================================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             10 .include "resources/macros.s"
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



                             11 .include "resources/entityInfo.s"
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
                     000A    32 e_anim1   = 10
                     000B    33 e_anim2   = 11
                     000C    34 e_animctr = 12
                     000D    35 e_aibeh1  = 13
                     000E    36 e_aibeh2  = 14
                     000F    37 e_anctr   = 15
                             38 
                             39 
                             40 
                             41 
                             42 ;===================================================================================================================================================
                             43 ; Entity struct       TODO : Investigar si así guay la estruct
                             44 ;===================================================================================================================================================
                             45 ; entity:
                             46 ;    .db #0x00                      ; type
                             47 ;    .db #0x00                      ; components
                             48 ;    .db #0x00                      ; x-pos
                             49 ;    .db #0x00                      ; y-pos
                             50 ;    .db #0x00                      ; vx
                             51 ;    .db #0x00                      ; vy
                             52 ;    .db #0x00                      ; width
                             53 ;    .db #0x00                      ; heigth
                             54 ;    .dw #_sprite_spriteExample     ; sprite          
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             55 ;    .dw #_man_anim_animExample     ; animator
                             56 ;    .db #0x00                      ; anim. counter
                             57 ;    .dw #_sys_ai_behaviourExample  ; ai_behaviour
                             58 ;    .db #0x00                      ; ai_counter
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             12 
                             13 ;===================================================================================================================================================
                             14 ; Manager data   
                             15 ;===================================================================================================================================================
                             16 ;; Descripcion : Array de entidades
   4082                      17 _m_entities::
   4082                      18     .ds 112
                             19 
                             20 ;; Descripcion : Memoria vacia al final del array para controlar su final
   40F2                      21 _m_emptyMemCheck::
   40F2                      22     .ds 1
                             23 
                             24 ;; Descripcion : Direccion de memoria con la siguiente posicion del array libre 
   40F3                      25 _m_next_free_entity::
   40F3                      26     .ds 2
                             27 
                             28 ;; Descripcion : Direccion de memoria donde este la funcion de inversion de control
   40F5                      29 _m_functionMemory::
   40F5                      30     .ds 2
                             31 
                             32 ;; Descripcion : Signature para comprobar entidades en el forAllMatching 
   40F7                      33 _m_signatureMatch::
   40F7                      34     .ds 1
                             35 
                             36 ;; Descripcion : Numero de entidades que caben en el array _m_entities
   40F8                      37 _m_numEntities::
   40F8                      38     .ds 1
                             39 
                             40 ;; Descripcion : TAmaño en bytes de 1 entity
   40F9                      41 _m_sizeOfEntity::
   40F9 10                   42     .db #0x10
                             43 
                             44 
                             45 ;===================================================================================================================================================
                             46 ; FUNCION _man_entityInit   
                             47 ; Inicializa el manager de entidades y sus datos
                             48 ; NO llega ningun dato
                             49 ;===================================================================================================================================================
   40FA                      50 _man_entityInit::
   40FA 11 82 40      [10]   51     ld  DE, #_m_entities
   40FD 3E 00         [ 7]   52     ld  A,  #0x00
   40FF 32 F2 40      [13]   53     ld  (_m_emptyMemCheck), a
   4102 32 F8 40      [13]   54     ld  (_m_numEntities), a
   4105 01 70 00      [10]   55     ld  BC, #0x0070
   4108 CD D6 44      [17]   56     call    cpct_memset_asm
                             57     
   410B 21 82 40      [10]   58     ld  hl, #_m_entities
   410E 22 F3 40      [16]   59     ld  (_m_next_free_entity), hl
                             60     
   4111 C9            [10]   61     ret
                             62 
                             63 
                             64 ;===================================================================================================================================================
                             65 ; FUNCION _man_createEntity   
                             66 ; Crea una entidad
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             67 ; NO llega ningun dato
                             68 ;===================================================================================================================================================
   4112                      69 _man_createEntity::
   4112 ED 5B F3 40   [20]   70     ld  de, (_m_next_free_entity)
   4116 26 00         [ 7]   71     ld  h, #0x00
                             72 
   0096                      73     LOAD_VARIABLE_IN_REGISTER _m_sizeOfEntity, l
   4118 3A F9 40      [13]    1     ld a, (#_m_sizeOfEntity)
   411B 6F            [ 4]    2     ld l, a
                             74 
   411C 19            [11]   75     add hl,de
   411D 22 F3 40      [16]   76     ld  (_m_next_free_entity),hl
   4120 21 F8 40      [10]   77     ld  hl, #_m_numEntities
   4123 34            [11]   78     inc (hl)
                             79 
   4124 6B            [ 4]   80     ld  l,e
   4125 62            [ 4]   81     ld  h,d
   4126 C9            [10]   82     ret
                             83 
                             84 
                             85 
                             86 ;===================================================================================================================================================
                             87 ; FUNCION _man_entityForAllMatching
                             88 ; Ejecuta la funcion  de _m_functionMemory por cada entidad que cumpla con el tipo designado en  _m_signatureMatch
                             89 ; NO llega ningun dato
                             90 ;===================================================================================================================================================
   4127                      91 _man_entityForAllMatching::
   4127 21 82 40      [10]   92     ld  hl, #_m_entities
                             93     
   412A 7E            [ 7]   94     ld  a,(hl)
                             95     
   412B B7            [ 4]   96     or a,a
   412C C8            [11]   97     ret Z
   412D E5            [11]   98     push hl
   412E C3 4C 41      [10]   99     jp checkSignature
   4131                     100     not_invalid2:
   4131 E1            [10]  101         pop hl
   4132 E5            [11]  102         push hl
   4133 DD 21 3F 41   [14]  103         ld ix, #next_entity2
   4137 DD E5         [15]  104         push ix
                            105 
   4139 DD 2A F5 40   [20]  106         ld ix, (#_m_functionMemory)
   413D DD E9         [ 8]  107         jp (ix)
                            108 
   413F                     109         next_entity2:
   413F E1            [10]  110         pop hl
   4140 3A F9 40      [13]  111         ld  a, (#_m_sizeOfEntity)
   4143 4F            [ 4]  112         ld  c, a
   4144 06 00         [ 7]  113         ld  b, #0x00
                            114 
   4146 09            [11]  115         add hl,bc
   4147 E5            [11]  116         push hl
   4148 7E            [ 7]  117         ld  a,(hl)
   4149 B7            [ 4]  118         or a,a 
   414A 28 0E         [12]  119         jr  Z, allDone
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   414C                     120         checkSignature:
   414C 3A F7 40      [13]  121         ld a,(#_m_signatureMatch)
   414F 23            [ 6]  122         inc hl
   4150 A6            [ 7]  123         and (hl)
   4151 21 F7 40      [10]  124         ld hl , #_m_signatureMatch
   4154 96            [ 7]  125         sub (hl)
   4155 28 DA         [12]  126         jr Z, not_invalid2
   4157 C3 3F 41      [10]  127         jp next_entity2
   415A                     128     allDone:
   415A E1            [10]  129     pop hl
   415B C9            [10]  130     ret
                            131 
                            132 
                            133 ;===================================================================================================================================================
                            134 ; FUNCION _man_setEntity4Destroy
                            135 ; Establece la entidad para ser destruida
                            136 ; HL : La entidad para ser marcada
                            137 ;===================================================================================================================================================
   415C                     138 _man_setEntity4Destroy::
   415C 3E 80         [ 7]  139     ld a, #0x80
   415E B6            [ 7]  140     or (hl)
   415F 77            [ 7]  141     ld (hl),a
   4160 C9            [10]  142 ret
                            143 
                            144 ;===================================================================================================================================================
                            145 ; FUNCION _man_entityDestroy
                            146 ; Elimina de las entidades la entidad de HL y arregla el array de entidades 
                            147 ; para establecer la ultima entidad al espacio liberado por la entidad destruida 
                            148 ; HL : La entidad para ser destruida
                            149 ;===================================================================================================================================================
   4161                     150 _man_entityDestroy::
   4161 ED 5B F3 40   [20]  151     ld de, (#_m_next_free_entity)
   4165 EB            [ 4]  152     ex de, hl
                            153     ;; HL = _m_next_free_entity
                            154     ;; DE = entity to destroy
                            155 
                            156 
                            157     ;; Buscamos la ultima entidad
   4166 3A F9 40      [13]  158     ld  a, (#_m_sizeOfEntity)
   4169                     159     setLast:
   4169 2B            [ 6]  160         dec hl
   416A 3D            [ 4]  161         dec a
   416B 20 FC         [12]  162         jr NZ, setLast
                            163     ;; de = e && hl = last
                            164 
                            165 
                            166     ;;Comprobamos que la ultima entidad libre y la entidad a destruir no sea la misma
                            167     ;;if( e != last)
   416D 7B            [ 4]  168     ld a, e
   416E 95            [ 4]  169     sub l
   416F 28 02         [12]  170     jr Z, checkMemory
                            171 
   4171 18 04         [12]  172     jr copy
   4173                     173     checkMemory:
   4173 7A            [ 4]  174     ld a,d
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   4174 94            [ 4]  175     sub h
   4175 28 13         [12]  176     jr Z, no_copy 
                            177 
                            178     ;;Si no es la misma copiamos la ultima entidad al espacio de la entidad a destruir
   4177                     179     copy:
                            180     ; cpct_memcpy(e,last,sizeof(Entity_t));
   4177 06 00         [ 7]  181     ld b, #0x00
   4179 3A F9 40      [13]  182     ld  a, (#_m_sizeOfEntity)
   417C 4F            [ 4]  183     ld c, a
   417D CD DE 44      [17]  184     call cpct_memcpy_asm
                            185 
                            186     ;;Volvemos a asignar a hl el valor de la ultima entity
   4180 21 F3 40      [10]  187     ld hl, #_m_next_free_entity
   4183 3A F9 40      [13]  188     ld  a, (#_m_sizeOfEntity)
   4186                     189     setLast2:
   4186 2B            [ 6]  190         dec hl
   4187 3D            [ 4]  191         dec a
   4188 20 FC         [12]  192         jr NZ, setLast2
                            193 
                            194 
                            195     ;;Aquí liberamos el ultimo espacio del array de entidades y lo seteamos como el proximo espacio libre 
   418A                     196     no_copy:
                            197     ;last->type = e_type_invalid;
   418A 36 00         [10]  198     ld (hl),#0x00
                            199     ;m_next_free_entity = last;
   418C 11 F3 40      [10]  200     ld de, #_m_next_free_entity
   418F EB            [ 4]  201     ex de, hl
   4190 73            [ 7]  202     ld (hl), e
   4191 23            [ 6]  203     inc hl
   4192 72            [ 7]  204     ld (hl), d
                            205     ;    --m_num_entities;      
   4193 21 F8 40      [10]  206     ld  hl, #_m_numEntities
   4196 35            [11]  207     dec (hl)
   4197 C9            [10]  208     ret
                            209 
                            210 
                            211 ;===================================================================================================================================================
                            212 ; FUNCION _man_entityUpdate
                            213 ; Recorre todas las entidades y destruye las entidades marcadas
                            214 ; NO llega ningun dato 
                            215 ;===================================================================================================================================================
   4198                     216 _man_entityUpdate::
   4198 21 82 40      [10]  217     ld hl, #_m_entities
                            218 
   419B 34            [11]  219     inc (hl)
   419C 35            [11]  220     dec (hl)
   419D C8            [11]  221     ret Z 
   419E 3A F9 40      [13]  222     ld a, (#_m_sizeOfEntity)
   41A1 4F            [ 4]  223     ld c, a
   41A2 06 00         [ 7]  224     ld b, #0x00    
   41A4 3E 80         [ 7]  225     ld a, #0x80    
   41A6                     226     valid:
   41A6 A6            [ 7]  227         and (hl)
   41A7 28 04         [12]  228         jr Z, _next_entity
   41A9 20 B6         [12]  229         jr NZ, _man_entityDestroy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   41AB 18 01         [12]  230         jr continue
                            231 
   41AD                     232         _next_entity:
   41AD 09            [11]  233             add hl, bc
                            234             ; jr continue
   41AE                     235         continue:
   41AE 3E 80         [ 7]  236             ld a, #0x80
   41B0 34            [11]  237             inc (hl)
   41B1 35            [11]  238             dec (hl)
   41B2 20 F2         [12]  239             jr NZ, valid
   41B4 C9            [10]  240     ret
                            241 
                            242 
                            243 ;===================================================================================================================================================
                            244 ; FUNCION _man_entity_freeSpace
                            245 ; Devuelve en a si hay espacio libre en las entidades para poder generar
                            246 ; NO llega ningun dato 
                            247 ;===================================================================================================================================================
   41B5                     248 _man_entity_freeSpace::
   41B5 21 F8 40      [10]  249         ld hl, #_m_numEntities
   41B8 3A F8 40      [13]  250         ld a, (#_m_numEntities)
   41BB 96            [ 7]  251         sub (hl)
   41BC C9            [10]  252     ret
                            253 
