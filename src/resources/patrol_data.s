.module Patrol_Data

.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "resources/templates.h.s"

;===============================================================================
; Regular Patrol
;===============================================================================

; !! se puede hacer que un patrol redirija  a otro !!

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

patrol_x_50_20:
   .db  50, 50
   .db  20, 50
   .db #patrol_invalid_move
   .dw #patrol_x_50_20

patrol_y_50_120:
   .db  10, 50
   .db  10, 120
   .db #patrol_invalid_move
   .dw #patrol_y_50_120


; m for max
patrol_all_game_zone_00:
   .db   4, 48
   .db  70, 48
   .db  70, 176
   .db   4, 176
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_00

patrol_all_game_zone_0m:
   .db  70, 48
   .db  70, 176
   .db   4, 176
   .db   4, 48
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_0m

patrol_all_game_zone_mm:
   .db  70, 176
   .db   4, 176
   .db   4, 48
   .db  70, 48
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_mm

patrol_all_game_zone_m0:
   .db   4, 176
   .db   4, 48
   .db  70, 48
   .db  70, 176
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_m0


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
   .db  0, -16
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_02

patrol_seeknpatrol_01:
   .db  0, -16
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_seeknpatrol_01

patrol_relative_03:
   .db  0, 0
   .db  0, 12
   .db  24, 12
   .db  24, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_03


patrol_relative_none:
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_none

patrol_relative_x_12:
   .db  0, 0
   .db  12, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_12

patrol_relative_y_12:
   .db  0, 0
   .db  0, 12
   .db #patrol_invalid_move
   .dw #patrol_relative_y_12

patrol_relative_x_24:
   .db  0, 0
   .db  24, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_24

patrol_relative_y_24:
   .db  0, 0
   .db  0, 24
   .db #patrol_invalid_move
   .dw #patrol_relative_y_24

;===============================================================================
; Spawner Patrol List
;===============================================================================
; !!!! el tamanyo tiene que ser menor que enemy_max_spawn !!!j
spawner_plist_01:
   .dw #t_enemy_testing
   .dw #t_enemy_patrol_x_shoot_y
   .dw #t_enemy_testing
   .dw #t_enemy_patrol_x_shoot_y

; que saque enemigos que se qeuden alredeodr del spawner
; y otros que vayan a hacer un patrol o un seeknpatrol
spawner_plist_02:
   .dw #t_enemy_patrol_relative_02
   .dw #t_enemy_patrol_relative_01
   .dw #t_enemy_seeknpatrol
   .dw #t_enemy_patrol_relative_02
   ; .dw #t_enemy_patrol_x_shoot_y

