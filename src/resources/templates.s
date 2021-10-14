;===================================================================================================================================================
; Public functions
;===================================================================================================================================================
;; Poner aqui las referencias a métodos de AI
.globl _sys_ai_behaviourLeftRight
.globl _sys_ai_behaviourBullet


;===================================================================================================================================================
; Public data
;===================================================================================================================================================
;;Animations
.globl _man_anim_player
;;Sprites
.globl _sprite_player01
.globl _sprite_bullet01
  

;===================================================================================================================================================
; Templates
;===================================================================================================================================================
_player_template_e:
   .db #0x01               ; type
   .db #0x17               ; cmp
   .db #0x26               ; x
   .db #0xB0               ; y
   .db #0x06               ; width
   .db #0x10               ; heigth = #0x0A
   .db #0x00               ; vx
   .db #0x00               ; vy
   .dw #_sprite_player01   ; sprite
   .db #0x00               ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000             ; prevptr
   .dw #0x0000             ; ai_behaviour
   .db #0x00               ; ai_counter
   .dw #_man_anim_player   ; animator
   .db #0x0A               ; anim. counter
   .dw #0x0000             ; input_behaviour

_bullet_template_e:
   .db #0x01                           ; type
   .db #0x1B                           ; cmp          
   .db #0x00                           ; x
   .db #0x00                           ; y 
   .db #0x04                           ; width
   .db #0x04                           ; heigth
   .db #0x00                           ; vx
   .db #0x00                           ; vy
   .dw #_sprite_bullet01               ; sprite
   .db #0x00                           ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                         ; prevptr
   .dw #_sys_ai_behaviourBullet        ; ai_behaviour    ;; se mete la direccion de la etiqueta a llamar
   .db #0x0A                           ; ai_counter     ;; Probar poner aqui el contador de la bala
   .dw #0x00                           ; animator
   .db #0x00                           ; anim. counter
   .dw #0x0000                         ; input_behaviour