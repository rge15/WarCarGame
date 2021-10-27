.module Templates

.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "animations.h.s"
.include "resources/sprites.h.s"
.include "templates.h.s"
.include "entityInfo.s"

; tiempo hasta que un enemy dispara
t_shoot_timer_enemy = 100

; tiempo hasta que la bala de un enemy se destruye
t_bullet_timer_enemy = 140

; tiempo hasta que la bala del player se destruye
t_bullet_timer_player = 27

player_max_bullets = 3

; tres tiros
t_spawner_max_hp = 3

;===================================================================================================================================================
; Templates
;===================================================================================================================================================
t_player:
   .db #e_type_player
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
   .db #player_max_bullets                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

t_enemy_patrol_relative_01:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #100                                    ; x
   .db #100                                    ; y
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
   ; .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   ; .db #1
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   ;; poner en e_ai_aux mismo valor que position
   ;; para que funcione patrol relativo
   .db #44
   .db #100                                 ; e_ai_aux_h
   .dw #patrol_relative_03
   ; .dw #patrol_relative_x_24

t_enemy_patrol_relative_02:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #100                                    ; x
   .db #100                                    ; y
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
   ; .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   ; .db #1
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   ;; poner en e_ai_aux mismo valor que position
   ;; para que funcione patrol relativo
   .db #40
   .db #80                                 ; e_ai_aux_h
   .dw #patrol_relative_01
   ; .dw #patrol_relative_x_24

test_time_fo = 20
t_enemy_seeknpatrol:
   .db #e_type_enemy                                 ; type
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
   .db #test_time_fo                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #patrol_relative_02

t_enemy_patrol_01:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   ; .db (patrol_02)                           ; x
   ; .db (patrol_02+1)
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
   .dw #_sys_ai_behaviourPatrol; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_02                            ; e_patrol_step

t_enemy_testing:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
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
   .dw #_sys_ai_behaviourPatrol; ai_behaviour
   .db #0x10                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #_sys_ai_shoot_condition_l                               ; input_behaviour
   ; .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

t_enemy_testing2:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
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
   .dw #_sys_ai_behaviourPatrol_shoot_l; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

;; e_ai_aux_l para decir si dispara en x o en y
t_enemy_patrol_x_shoot_y:
   .db #e_type_enemy                                 ; type
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
   .dw #_sys_ai_behaviourPatrol_shoot_l; ai_behaviour
   .db #t_shoot_timer_enemy                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x02                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_03                            ; e_patrol_step

; es como un enemy raealmente
; template porque genera entidades de un template !!
t_spawner_template_01:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_player02                      ; sprite
   .db #t_spawner_max_hp                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_template             ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #40                                    ; e_ai_aux_l
   .db #80                                 ; e_ai_aux_h
   .dw #t_enemy_patrol_relative_02
   ; .db #0x00                                 ; e_patrol_step_l
   ; .db #0x00                                 ; e_patrol_step_h

t_spawner_template_02:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_player02                      ; sprite
   .db #t_spawner_max_hp                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_template             ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #t_enemy_patrol_relative_01
   ; .db #0x00                                 ; e_patrol_step_l
   ; .db #0x00                                 ; e_patrol_step_h

t_spawner_plist_01:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #16                                    ; x
   .db #50                                    ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_player02                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x01                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_plist             ; ai_behaviour
   .db #0x00                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #3                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #spawner_plist_01
   ; .db #0x00                                 ; e_patrol_step_l
   ; .db #0x00                                 ; e_patrol_step_h

t_bullet_player:
   .db #e_type_bullet                                 ; type
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
t_bullet_enemy_sp:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x2B                                 ; cmp
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
   .dw #_sys_ai_behaviourBulletSeektoPlayer  ; ai_behaviour
   .db #t_bullet_timer_enemy                 ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

t_bullet_enemy_l:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x2B                                 ; cmp
   .db #50
   .db #150
   .db #0x03                                 ; width
   .db #0x06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_bullet01                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #_sys_ai_behaviourBulletLinear; ai_behaviour
   .db #t_bullet_timer_enemy                 ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x7                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h


t_shield:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x2B                                 ; cmp
   .db #50
   .db #150
   .db #0x03                                 ; width
   .db #0x06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_bullet01                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #0; ai_behaviour
   .db #t_bullet_timer_enemy                 ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x7                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h


;===============================================================================
; IN GAME ENEMIES DO NOT TOUCH
;===============================================================================

t_enemy_01_L01:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol              ; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

t_enemy_01_L02:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative              ; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #18                                 ; e_ai_aux_l
   .db #78                                 ; e_ai_aux_h
   .dw #patrol_relative_x_12                            ; e_patrol_step

t_enemy_02_L02:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative              ; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #50                                 ; e_ai_aux_l
   .db #78                                 ; e_ai_aux_h
   .dw #patrol_relative_x_12                            ; e_patrol_step

t_enemy_03_L03:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #1                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #patrol_y_50_120                            ; e_patrol_step

t_enemy_01_L03:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol_shoot_l              ; ai_behaviour
   .db #t_shoot_timer_enemy                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

t_enemy_02_L03:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #0                                 ; x
   .db #0                                 ; y
   .db #0x06                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol_shoot_l              ; ai_behaviour
   .db #t_shoot_timer_enemy                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #1                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #patrol_y_50_120                            ; e_patrol_step



