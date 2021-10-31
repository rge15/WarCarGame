.module Animations

.include "resources/sprites.h.s"
.include "animations.h.s"

;===================================================================================================================================================
; Player Animations
;===================================================================================================================================================
_man_anim_player_x_right:
    .db #0x0A
    .dw #_tanque_0
    .db #0x0A
    .dw #_tanque_2
    .db #0x00
    .dw #_man_anim_player_x_right

_man_anim_player_y_up:
    .db #0x0A
    .dw #_tanque_1
    .db #0x0A
    .dw #_tanque_3
    .db #0x00
    .dw #_man_anim_player_y_up

_man_anim_player_x_left:
    .db #0x0A
    .dw #_tanque_4
    .db #0x0A
    .dw #_tanque_6
    .db #0x00
    .dw #_man_anim_player_x_left

_man_anim_player_y_down:
    .db #0x0A
    .dw #_tanque_5
    .db #0x0A
    .dw #_tanque_7
    .db #0x00
    .dw #_man_anim_player_y_down


;===================================================================================================================================================
; Enemy Animations
;===================================================================================================================================================
_man_anim_enemy_green:
    .db #0x0A
    .dw #_ovni_green_0
    .db #0x0A
    .dw #_ovni_green_1
    .db #0x0A
    .dw #_ovni_green_2
    .db #0
    .dw #_man_anim_enemy_green

_man_anim_enemy_blue:
    .db #0x0A
    .dw #_ovni_blue_0
    .db #0x0A
    .dw #_ovni_blue_1
    .db #0x0A
    .dw #_ovni_blue_2
    .db #0
    .dw #_man_anim_enemy_blue

_man_anim_enemy_purple:
    .db #0x0A
    .dw #_ovni_purple_0
    .db #0x0A
    .dw #_ovni_purple_1
    .db #0x0A
    .dw #_ovni_purple_2
    .db #0
    .dw #_man_anim_enemy_purple

_man_anim_enemy_red:
    .db #0x0A
    .dw #_ovni_red_0
    .db #0x0A
    .dw #_ovni_red_1
    .db #0x0A
    .dw #_ovni_red_2
    .db #0
    .dw #_man_anim_enemy_red

_man_anim_exp:
    .db #2
    .dw #_ovni_exp_0
    .db #2
    .dw #_ovni_exp_1
    .db #2
    .dw #_ovni_exp_2
    .db #2
    .dw #_ovni_exp_3
    .db #0
    .dw #_man_anim_exp


;===================================================================================================================================================
; Enemy Bullet Animations
;===================================================================================================================================================
_man_anim_enemy_bullet:
    .db #0x06
    .dw #_ovni_bullet_0
    .db #0x06
    .dw #_ovni_bullet_1
    .db #0
    .dw #_man_anim_enemy_bullet

