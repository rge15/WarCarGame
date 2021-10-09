ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
                             55 ;    .dw #_man_anim_animExample     ; animator
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;    .db #0x00                      ; anim. counter
                             57 ;    .dw #_sys_ai_behaviourExample  ; ai_behaviour
                             58 ;    .db #0x00                      ; ai_counter
