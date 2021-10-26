.module Patrol_Data

.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "resources/templates.h.s"

;===============================================================================
; Regular Patrol
;===============================================================================
patrol_01:
   .db  6, 6
   .db  30, 30
   .db  40, 30
   .db  40, 12
   .db #patrol_invalid_move
   .dw #patrol_01

patrol_02:
   .db  50, 50
   .db  30, 140
   .db  12, 30
   .db  64, 30
   .db  10, 100
   .db #patrol_invalid_move
   .dw #patrol_02

patrol_03:
   .db  50, 80
   .db  20, 80
   .db #patrol_invalid_move
   .dw #patrol_03

patrol_none:
   .db  50, 60
   ; .db  20, 80
   .db #patrol_invalid_move
   .dw #patrol_none

patrol_x_01:
   .db  50, 50
   .db  20, 50
   .db #patrol_invalid_move
   .dw #patrol_x_01

;===============================================================================
; Relative Patrol
;===============================================================================

;; moverse alredeodr de una entidad
patrol_relative_01:
   .db  6, -10
   .db  6, 10
   .db  -6, 10
   .db  -6, -10
   .db #patrol_invalid_move
   .dw #patrol_relative_01

patrol_relative_02:
   ; .db  0, -16
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_02

patrol_relative_03:
   .db  0, 12
   .db  12, 12
   .db  12, 0
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_03


;===============================================================================
; Spawner Patrol
;===============================================================================
; !!!! el tamanyo tiene que ser menor que enemy_max_spawn !!!j
spawner_patrol_01:
   .dw #t_enemy_testing
   .dw #t_enemy_patrol_x_shoot_y
   .dw #t_enemy_testing
   .dw #t_enemy_patrol_x_shoot_y

