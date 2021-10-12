.module Templates

.include "sys/ai.h.s"
.include "animations.h.s"
.include "resources/sprites.h.s"
.include "templates.h.s"


;===================================================================================================================================================
; Templates
;===================================================================================================================================================
_player_template_e:
   .db #0x01               ; type
   .db #0x13               ; cmp
   .db #0x26               ; x
   .db #0xB0               ; y
   .db #0x06               ; width
   .db #0x0A               ; heigth
   .db #0x00               ; vx
   .db #0x00               ; vy
   .dw #_sprite_player01   ; sprite
   .db #0x00               ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000             ; prevptr
   .dw #0x0000             ;ai_behaviour
   .db #0x00               ;ai_counter
   .dw #_man_anim_player   ;animator
   .db #0x0A               ;anim. counter
   .dw #0x0000             ;input_behaviour
