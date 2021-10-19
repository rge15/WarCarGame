.module Animations

.include "resources/sprites.h.s"
.include "animations.h.s"

;===================================================================================================================================================
; Animations
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
