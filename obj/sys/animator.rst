ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; includes
                              3 ;===================================================================================================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "resources/entityInfo.s"
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



                              5 
                              6 ;===================================================================================================================================================
                              7 ; Public functions
                              8 ;===================================================================================================================================================
                              9 .globl _man_entityForAllMatching
                             10 .globl _m_functionMemory
                             11 .globl _m_signatureMatch
                             12 
                             13 ;===================================================================================================================================================
                             14 ; Animations
                             15 ;===================================================================================================================================================
                             16 .globl _man_anim_player
                             17 
                             18 ;===================================================================================================================================================
                             19 ; FUNCION _sys_animator_update   
                             20 ; Llama a la inversión de control para updatear las animaciones de cada entidad que coincida con e_type_animator
                             21 ; NO llega ningun dato
                             22 ;===================================================================================================================================================
   4295                      23 _sys_animator_update::
   4295 21 A4 42      [10]   24     ld hl, #_sys_animator_updateOneEntity
   4298 22 0D 41      [16]   25     ld (_m_functionMemory), hl
   429B 21 0F 41      [10]   26     ld hl , #_m_signatureMatch 
   429E 36 10         [10]   27     ld (hl), #0x10  ; e_type_animator
   42A0 CD 3F 41      [17]   28     call _man_entityForAllMatching
   42A3 C9            [10]   29     ret
                             30 
                             31 ;===================================================================================================================================================
                             32 ; FUNCION _sys_animator_updateOneEntity   
                             33 ; Si toca cambiar el sprite de la animacion establece el siguiente sprite como el nuevo y,
                             34 ; pone tambien el counter de la animacion con la duración del nuevo sprite.
                             35 ; En caso de que no haya sprite y sea la dirección de memoria de la animacion, 
                             36 ; resetea la animación y establece los datos como el paso descrito antes.
                             37 ; HL : Entidad a updatear
                             38 ;===================================================================================================================================================
                             39 
                             40 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             41 ;IMPORTANTE : ESTE ANIMATOR SOLO SIRVE DEPENDIENDO DEL STRUCT DE LA ENITY
                             42 ;             REVISAR EN FUNCION DEL STRUCT QUE DECIDAMOS
                             43 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             44 
   42A4                      45 _sys_animator_updateOneEntity::    
                             46     ;/
                             47     ;|Comprobamos comprobamos y debcrementamos el valor de anim. counter
                             48     ;\
   42A4 E5            [11]   49     push hl
   42A5 DD E1         [14]   50     pop ix
   42A7 DD 35 0F      [23]   51     dec e_animctr(ix)
   42AA C0            [11]   52     ret NZ
   42AB E5            [11]   53     push hl
                             54 
                             55     ;/
                             56     ;| Cargamos en DE el valor de la animacion de la entidad en este momento
                             57     ;\
   42AC DD 56 0E      [19]   58     ld d, e_anim2(ix)
   42AF DD 5E 0D      [19]   59     ld e, e_anim1(ix)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             60 
                             61     ;/
                             62     ;| Hacemos que DE apunte a la siguiente parte de la animacion
                             63     ;\
   42B2 13            [ 6]   64     inc de
   42B3 13            [ 6]   65     inc de
   42B4 13            [ 6]   66     inc de
                             67 
                             68     ;/
                             69     ;| Guardamos en la entidad la nueva parte de la animacion
                             70     ;\
   42B5 DD 73 0D      [19]   71     ld e_anim1(ix), e
   42B8 DD 72 0E      [19]   72     ld e_anim2(ix), d
                             73 
   42BB EB            [ 4]   74     ex de,hl  ;HL tiene la direccion de la anim
                             75 
                             76     ;/
                             77     ;| En caso que el valor de la duracion de esta parte de la animacion sea 0,
                             78     ;| cargaremos de nuevo la animacion en la entidad desde el principio
                             79     ;\
   42BC 35            [11]   80     dec (hl)
   42BD 34            [11]   81     inc (hl)
   42BE 20 0A         [12]   82     jr NZ, noRepeatAnim
                             83 
                             84     ;/
                             85     ;| HL llega apuntando a la nueva parte de la animacion que sabemos que se acaba.
                             86     ;| Así que cargamos el inicio de la animacion en la animacion de la entity
                             87     ;\
   42C0 23            [ 6]   88     inc hl
   42C1 5E            [ 7]   89     ld e, (hl)
   42C2 23            [ 6]   90     inc hl
   42C3 56            [ 7]   91     ld d, (hl)
                             92 
   42C4 DD 72 0E      [19]   93     ld e_anim2(ix),d
   42C7 DD 73 0D      [19]   94     ld e_anim1(ix),e
                             95 
                             96     ;/
                             97     ;| Aqui ya está en la Entity asignado el inicio de la anim
                             98     ;\
   42CA                      99     noRepeatAnim:
                            100     ;pop hl   ;;Aqui en HL está el inicio de la animacion en la memoria de la entity
                            101 
                            102     ;/
                            103     ;| Aqui seteamos los valores de la entidad con los 
                            104     ;| valores de la nueva parte de la animacion
                            105     ;\    
   42CA DD 66 0E      [19]  106     ld h, e_anim2(ix)
   42CD DD 6E 0D      [19]  107     ld l, e_anim1(ix)
                            108 
                            109     ;/
                            110     ;| El valor del tiempo
                            111     ;\    
   42D0 7E            [ 7]  112     ld a, (hl) ; a = newTIME
   42D1 DD 77 0F      [19]  113     ld e_animctr(ix),a
                            114 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            115     ;/
                            116     ;| El valor del sprite
                            117     ;\    
   42D4 23            [ 6]  118     inc hl
   42D5 7E            [ 7]  119     ld a,(hl)
   42D6 DD 77 08      [19]  120     ld e_sprite1(ix),a
   42D9 23            [ 6]  121     inc hl
   42DA 7E            [ 7]  122     ld a,(hl)
   42DB DD 77 09      [19]  123     ld e_sprite2(ix),a
                            124 
                            125     ;/
                            126     ;| Devolvemos el valor de Hl del inicio
                            127     ;\    
   42DE E1            [10]  128     pop hl
   42DF C9            [10]  129    ret
