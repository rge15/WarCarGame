.module Templates

.include "sys/ai.h.s"
.include "animations.h.s"
.include "resources/sprites.h.s"
.include "templates.h.s"


;===================================================================================================================================================
; Templates
;===================================================================================================================================================
_player_template_e:
   .db #0x01                                 ; type
   .db #0x37                                 ; cmp
   .db #0x26                                 ; x
   .db #0xB0                                 ; y
   .db #0x06                                 ; width
   .db #0x10                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_tanque_0                            ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0x0000                               ; ai_behaviour
   .db #0x00                                 ; ai_counter
   .dw #_man_anim_player_x_right             ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .dw #0x0000                               ; ai_aim_position
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y

_enemy_template_e:
   .db #0x10                                 ; type
   .db #0x0b                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourAutoMoveIn_x        ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x25                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y

_enemy_template_e2:
   .db #0x10                                 ; type
   .db #0x0b                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourAutoMoveIn_x              ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y

_enemy_template_e3:
   .db #0x10                                 ; type
   .db #0x0b                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol              ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y

; es como un enemy raealmente
_spawner_template_e:
   .db #0x10                                 ; type
   .db #0x0b                                 ; cmp
   .db #15                                    ; x
   .db #50                                    ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_player02                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner             ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y

_bullet_template_e:
   .db #0x04                                 ; type
   .db #0x3B                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x03                                 ; width
   .db #0x06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_vBullet_1                           ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourBullet              ; ai_behaviour
   .db #0x01B                                ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .dw #0x0000                               ; ai_aim_position
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y


;; la bullet del enemey
_bullet_template_e2:
   .db #0x04                                 ; type
   .db #0x1B                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x04                                 ; width
   .db #0x04                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_bullet01                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #_sys_ai_behaviourBulletSeektoPlayer  ; ai_behaviour
   .db #0x01B                                ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_last_aim_x
   .db #0x00                                 ; e_ai_last_aim_y
