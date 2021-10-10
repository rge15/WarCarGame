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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             55 ;    .db #0x00                      ; anim. counter
                             56 ;    .dw #_sys_ai_behaviourExample  ; ai_behaviour
                             57 ;    .db #0x00                      ; ai_counter
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             12 
                             13 ;===================================================================================================================================================
                             14 ; Manager data   
                             15 ;===================================================================================================================================================
                             16 ;; Descripcion : Array de entidades
   409A                      17 _m_entities::
   409A                      18     .ds 112
                             19 
                             20 ;; Descripcion : Memoria vacia al final del array para controlar su final
   410A                      21 _m_emptyMemCheck::
   410A                      22     .ds 1
                             23 
                             24 ;; Descripcion : Direccion de memoria con la siguiente posicion del array libre 
   410B                      25 _m_next_free_entity::
   410B                      26     .ds 2
                             27 
                             28 ;; Descripcion : Direccion de memoria donde este la funcion de inversion de control
   410D                      29 _m_functionMemory::
   410D                      30     .ds 2
                             31 
                             32 ;; Descripcion : Signature para comprobar entidades en el forAllMatching 
   410F                      33 _m_signatureMatch::
   410F                      34     .ds 1
                             35 
                             36 ;; Descripcion : Numero de entidades que caben en el array _m_entities
   4110                      37 _m_numEntities::
   4110                      38     .ds 1
                             39 
                             40 ;; Descripcion : TAmaño en bytes de 1 entity
   4111                      41 _m_sizeOfEntity::
   4111 10                   42     .db #0x10
                             43 
                             44 
                             45 ;===================================================================================================================================================
                             46 ; FUNCION _man_entityInit   
                             47 ; Inicializa el manager de entidades y sus datos
                             48 ; NO llega ningun dato
                             49 ;===================================================================================================================================================
   4112                      50 _man_entityInit::
   4112 11 9A 40      [10]   51     ld  DE, #_m_entities
   4115 3E 00         [ 7]   52     ld  A,  #0x00
   4117 32 0A 41      [13]   53     ld  (_m_emptyMemCheck), a
   411A 32 10 41      [13]   54     ld  (_m_numEntities), a
   411D 01 70 00      [10]   55     ld  BC, #0x0070
   4120 CD DF 44      [17]   56     call    cpct_memset_asm
                             57     
   4123 21 9A 40      [10]   58     ld  hl, #_m_entities
   4126 22 0B 41      [16]   59     ld  (_m_next_free_entity), hl
                             60     
   4129 C9            [10]   61     ret
                             62 
                             63 
                             64 ;===================================================================================================================================================
                             65 ; FUNCION _man_createEntity   
                             66 ; Crea una entidad
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             67 ; NO llega ningun dato
                             68 ;===================================================================================================================================================
   412A                      69 _man_createEntity::
   412A ED 5B 0B 41   [20]   70     ld  de, (_m_next_free_entity)
   412E 26 00         [ 7]   71     ld  h, #0x00
                             72 
   0096                      73     LOAD_VARIABLE_IN_REGISTER _m_sizeOfEntity, l
   4130 3A 11 41      [13]    1     ld a, (#_m_sizeOfEntity)
   4133 6F            [ 4]    2     ld l, a
                             74 
   4134 19            [11]   75     add hl,de
   4135 22 0B 41      [16]   76     ld  (_m_next_free_entity),hl
   4138 21 10 41      [10]   77     ld  hl, #_m_numEntities
   413B 34            [11]   78     inc (hl)
                             79 
   413C 6B            [ 4]   80     ld  l,e
   413D 62            [ 4]   81     ld  h,d
   413E C9            [10]   82     ret
                             83 
                             84 
                             85 
                             86 ;===================================================================================================================================================
                             87 ; FUNCION _man_entityForAllMatching
                             88 ; Ejecuta la funcion  de _m_functionMemory por cada entidad que cumpla con el tipo designado en  _m_signatureMatch
                             89 ; NO llega ningun dato
                             90 ;===================================================================================================================================================
   413F                      91 _man_entityForAllMatching::
   413F 21 9A 40      [10]   92     ld  hl, #_m_entities
                             93     
   4142 7E            [ 7]   94     ld  a,(hl)
                             95     
   4143 B7            [ 4]   96     or a,a
   4144 C8            [11]   97     ret Z
   4145 E5            [11]   98     push hl
   4146 C3 64 41      [10]   99     jp checkSignature
   4149                     100     not_invalid2:
   4149 E1            [10]  101         pop hl
   414A E5            [11]  102         push hl
   414B DD 21 57 41   [14]  103         ld ix, #next_entity2
   414F DD E5         [15]  104         push ix
                            105 
   4151 DD 2A 0D 41   [20]  106         ld ix, (#_m_functionMemory)
   4155 DD E9         [ 8]  107         jp (ix)
                            108 
   4157                     109         next_entity2:
   4157 E1            [10]  110         pop hl
   4158 3A 11 41      [13]  111         ld  a, (#_m_sizeOfEntity)
   415B 4F            [ 4]  112         ld  c, a
   415C 06 00         [ 7]  113         ld  b, #0x00
                            114 
   415E 09            [11]  115         add hl,bc
   415F E5            [11]  116         push hl
   4160 7E            [ 7]  117         ld  a,(hl)
   4161 B7            [ 4]  118         or a,a 
   4162 28 0E         [12]  119         jr  Z, allDone
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4164                     120         checkSignature:
   4164 3A 0F 41      [13]  121         ld a,(#_m_signatureMatch)
   4167 23            [ 6]  122         inc hl
   4168 A6            [ 7]  123         and (hl)
   4169 21 0F 41      [10]  124         ld hl , #_m_signatureMatch
   416C 96            [ 7]  125         sub (hl)
   416D 28 DA         [12]  126         jr Z, not_invalid2
   416F C3 57 41      [10]  127         jp next_entity2
   4172                     128     allDone:
   4172 E1            [10]  129     pop hl
   4173 C9            [10]  130     ret
                            131 
                            132 
                            133 ;===================================================================================================================================================
                            134 ; FUNCION _man_setEntity4Destroy
                            135 ; Establece la entidad para ser destruida
                            136 ; HL : La entidad para ser marcada
                            137 ;===================================================================================================================================================
   4174                     138 _man_setEntity4Destroy::
   4174 3E 80         [ 7]  139     ld a, #0x80
   4176 B6            [ 7]  140     or (hl)
   4177 77            [ 7]  141     ld (hl),a
   4178 C9            [10]  142 ret
                            143 
                            144 ;===================================================================================================================================================
                            145 ; FUNCION _man_entityDestroy
                            146 ; Elimina de las entidades la entidad de HL y arregla el array de entidades 
                            147 ; para establecer la ultima entidad al espacio liberado por la entidad destruida 
                            148 ; HL : La entidad para ser destruida
                            149 ;===================================================================================================================================================
   4179                     150 _man_entityDestroy::
   4179 ED 5B 0B 41   [20]  151     ld de, (#_m_next_free_entity)
   417D EB            [ 4]  152     ex de, hl
                            153     ;; HL = _m_next_free_entity
                            154     ;; DE = entity to destroy
                            155 
                            156 
                            157     ;; Buscamos la ultima entidad
   417E 3A 11 41      [13]  158     ld  a, (#_m_sizeOfEntity)
   4181                     159     setLast:
   4181 2B            [ 6]  160         dec hl
   4182 3D            [ 4]  161         dec a
   4183 20 FC         [12]  162         jr NZ, setLast
                            163     ;; de = e && hl = last
                            164 
                            165 
                            166     ;;Comprobamos que la ultima entidad libre y la entidad a destruir no sea la misma
                            167     ;;if( e != last)
   4185 7B            [ 4]  168     ld a, e
   4186 95            [ 4]  169     sub l
   4187 28 02         [12]  170     jr Z, checkMemory
                            171 
   4189 18 04         [12]  172     jr copy
   418B                     173     checkMemory:
   418B 7A            [ 4]  174     ld a,d
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   418C 94            [ 4]  175     sub h
   418D 28 13         [12]  176     jr Z, no_copy 
                            177 
                            178     ;;Si no es la misma copiamos la ultima entidad al espacio de la entidad a destruir
   418F                     179     copy:
                            180     ; cpct_memcpy(e,last,sizeof(Entity_t));
   418F 06 00         [ 7]  181     ld b, #0x00
   4191 3A 11 41      [13]  182     ld  a, (#_m_sizeOfEntity)
   4194 4F            [ 4]  183     ld c, a
   4195 CD E7 44      [17]  184     call cpct_memcpy_asm
                            185 
                            186     ;;Volvemos a asignar a hl el valor de la ultima entity
   4198 21 0B 41      [10]  187     ld hl, #_m_next_free_entity
   419B 3A 11 41      [13]  188     ld  a, (#_m_sizeOfEntity)
   419E                     189     setLast2:
   419E 2B            [ 6]  190         dec hl
   419F 3D            [ 4]  191         dec a
   41A0 20 FC         [12]  192         jr NZ, setLast2
                            193 
                            194 
                            195     ;;Aquí liberamos el ultimo espacio del array de entidades y lo seteamos como el proximo espacio libre 
   41A2                     196     no_copy:
                            197     ;last->type = e_type_invalid;
   41A2 36 00         [10]  198     ld (hl),#0x00
                            199     ;m_next_free_entity = last;
   41A4 11 0B 41      [10]  200     ld de, #_m_next_free_entity
   41A7 EB            [ 4]  201     ex de, hl
   41A8 73            [ 7]  202     ld (hl), e
   41A9 23            [ 6]  203     inc hl
   41AA 72            [ 7]  204     ld (hl), d
                            205     ;    --m_num_entities;      
   41AB 21 10 41      [10]  206     ld  hl, #_m_numEntities
   41AE 35            [11]  207     dec (hl)
   41AF C9            [10]  208     ret
                            209 
                            210 
                            211 ;===================================================================================================================================================
                            212 ; FUNCION _man_entityUpdate
                            213 ; Recorre todas las entidades y destruye las entidades marcadas
                            214 ; NO llega ningun dato 
                            215 ;===================================================================================================================================================
   41B0                     216 _man_entityUpdate::
   41B0 21 9A 40      [10]  217     ld hl, #_m_entities
                            218 
   41B3 34            [11]  219     inc (hl)
   41B4 35            [11]  220     dec (hl)
   41B5 C8            [11]  221     ret Z 
   41B6 3A 11 41      [13]  222     ld a, (#_m_sizeOfEntity)
   41B9 4F            [ 4]  223     ld c, a
   41BA 06 00         [ 7]  224     ld b, #0x00    
   41BC 3E 80         [ 7]  225     ld a, #0x80    
   41BE                     226     valid:
   41BE A6            [ 7]  227         and (hl)
   41BF 28 04         [12]  228         jr Z, _next_entity
   41C1 20 B6         [12]  229         jr NZ, _man_entityDestroy
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   41C3 18 01         [12]  230         jr continue
                            231 
   41C5                     232         _next_entity:
   41C5 09            [11]  233             add hl, bc
                            234             ; jr continue
   41C6                     235         continue:
   41C6 3E 80         [ 7]  236             ld a, #0x80
   41C8 34            [11]  237             inc (hl)
   41C9 35            [11]  238             dec (hl)
   41CA 20 F2         [12]  239             jr NZ, valid
   41CC C9            [10]  240     ret
                            241 
                            242 
                            243 ;===================================================================================================================================================
                            244 ; FUNCION _man_entity_freeSpace
                            245 ; Devuelve en a si hay espacio libre en las entidades para poder generar
                            246 ; NO llega ningun dato 
                            247 ;===================================================================================================================================================
   41CD                     248 _man_entity_freeSpace::
   41CD 21 10 41      [10]  249         ld hl, #_m_numEntities
   41D0 3A 10 41      [13]  250         ld a, (#_m_numEntities)
   41D3 96            [ 7]  251         sub (hl)
   41D4 C9            [10]  252     ret
                            253 
