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
   .db #0x37               ; cmp
   .db #0x26               ; x
   .db #0xB0               ; y
   .db #0x06               ; width
   .db #0x10               ; heigth
   .db #0x00               ; vx
   .db #0x00               ; vy
   .dw #_tanque_0          ; sprite
   .db #0x00               ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00               ; prev. orientation  
   .dw #0x0000             ; prevptr
   .dw #0x0000             ;ai_behaviour
   .db #0x00               ;ai_counter    ;; Cooldwon de la bala
   .dw #_man_anim_player_x_right ;animator
   .db #0x0A               ;anim. counter
   .dw #0x0000             ;input_behaviour

_bullet_template_e:
   .db #0x04                           ; type
   .db #0x3B                           ; cmp          
   .db #0x00                           ; x
   .db #0x00                           ; y 
   .db #0x03                           ; width
   .db #0x06                           ; heigth
   .db #0x00                           ; vx
   .db #0x00                           ; vy
   .dw #_vBullet_1                     ; sprite
   .db #0x00                           ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                           ; prev. orientation  
   .dw #0x0000                         ; prevptr
   .dw #_sys_ai_behaviourBullet        ; ai_behaviour    
   .db #0x01B                          ; ai_counter   ;; Contador de la bala
   .dw #0x00                           ; animator
   .db #0x00                           ; anim. counter
   .dw #0x0000                         ; input_behaviour
