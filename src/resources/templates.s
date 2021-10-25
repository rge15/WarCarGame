.module Templates

.include "sys/ai.h.s"
.include "sys/patrol.h.s"
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
   .db #0xa0                                 ; y
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
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

_enemy_template_e:
   .db #0x08                                 ; type
   .db #0x2b                                 ; cmp
   .db #16                                    ; x
   .db #50                                    ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   .db #1
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x25                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_relative_02                            ; e_patrol_step

ai_counter01 = 20
_enemy_template_e2:
   .db #0x08                                 ; type
   .db #0x2b                                 ; cmp
   .db #50                                 ; x
   .db #80                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSeekAndPatrol              ; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #0                                 ; e_ai_aim_y
   .db #0                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #patrol_relative_02

_enemy_template_e3:
   .db #0x8                                ; type
   .db #0x2b                                 ; cmp
   .db #40                                 ; x
   .db #40                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_04                            ; e_patrol_step

; es como un enemy raealmente
_spawner_template_e:
   .db #0x08                                 ; type
   .db #0x0b                                 ; cmp
   .db #16                                    ; x
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
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

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
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h


;; la bullet del enemey
_bullet_template_e2:
   .db #0x04                                 ; type
   .db #0x3B                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x04                                 ; width
   .db #0x04                                 ; heigth
   .db #0x01                                 ; vx
   .db #0x01                                 ; vy
   .dw #_sprite_bullet01                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   ; .dw #_sys_ai_behaviourBulletSeektoPlayer  ; ai_behaviour
   .dw #_sys_ai_behaviourBulletSeektoPlayer  ; ai_behaviour
   .db #0x1b                                ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h
