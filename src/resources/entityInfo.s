.module EntityInfo
;===================================================================================================================================================
; Entity types   
;===================================================================================================================================================
; #define e_type_invalid     0x00
; #define e_type_player      0x01
; #define e_type_default     0x02 
; #define e_type_bullet      0x04 
; #define e_type_enemy       0x10 
; #define e_type_dead        0x80

;===================================================================================================================================================
; Component types   
;===================================================================================================================================================
; #define e_cmp_render   0x01
; #define e_cmp_movable  0x02
; #define e_cmp_input    0x04
; #define e_cmp_ai       0x08
; #define e_cmp_animated 0x10
; #define e_cmp_collider 0x20

;===================================================================================================================================================
; Entity variables    TODO : MIrar como puedo hacer defines para poder llamar al macro LOAD_ENTITY_VARIABLE_IN_REGISTER
;===================================================================================================================================================
e_type      =  0
e_cmp       =  1
e_xpos      =  2
e_ypos      =  3
e_width     =  4
e_heigth    =  5
e_vx        =  6
e_vy        =  7
e_sprite1   =  8
e_sprite2   =  9
e_orient    = 10

e_prorient  = 11
e_prevptr1  = 12
e_prevptr2  = 13
e_aibeh1    = 14
e_aibeh2    = 15
e_aictr     = 16
e_anim1     = 17
e_anim2     = 18
e_animctr   = 19
e_inputbeh1 = 20
e_inputbeh2 = 21

e_ai_aim_x  = 22
e_ai_aim_y  = 23
e_ai_last_aim_x = 24
e_ai_last_aim_y = 25



;===================================================================================================================================================
; Entity struct       TODO : Investigar si así guay la estruct
;===================================================================================================================================================
; entity:
;    .db #0x00                         ; type
;    .db #0x00                         ; components
;    .db #0x00                         ; x-pos
;    .db #0x00                         ; y-pos
;    .db #0x00                         ; width
;    .db #0x00                         ; heigth
;    .db #0x00                         ; vx
;    .db #0x00                         ; vy
;    .dw #_sprite_spriteExample        ; sprite  
;    .db #0x00                         ; orientation 
;    .dw #_prevptr_prevptrExample      ; prevptr
;    .dw #_man_anim_animExample        ; animator
;    .db #0x00                         ; anim. counter
;    .dw #_sys_ai_behaviourExample     ; ai_behaviour
;    .db #0x00                         ; ai_counter
;    .dw #_sys_input_behaviourExample  ; input_behaviour
