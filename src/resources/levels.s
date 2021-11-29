;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Aliens'n Tanks: An Amstrad CPC Game 
;;  Copyright (C) 2021 Yaroslav Paslavskiy Danko / Rodrigo Guzmán Escribá / 
;;                     Eduardo David Gómez Saldias / Semag Ohcaco (@SemagOhcaco)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

.include "resources/tilemaps.h.s"
.include "resources/templates.h.s"
.include "resources/patrol_data.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"


; dos seguidos significa fin de levels
level_separator  = 0x00
; despues de esto viene el template de la entity a crear
level_new_entity = 0x01

_level1:

   ;================================================================================
   ; TEST LEVEL
   ;================================================================================

   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4                   ;Entity X
   .db #48                   ;Entity Y

   ; .db #level_new_entity
   ; .dw #t_spawner_from_plist_01
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #spawner_plist_01
   ; .dw #enemy_no_shoot

   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #54
   ; .db #80
   ; ; .dw #_sys_ai_behaviourSpawner_template
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; ; .dw #t_es_01
   ; .dw #spawner_plist_02
   ; .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #48
   .db #156
   .dw #enemy_no_move
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #24
   .db #156
   .dw #enemy_no_move
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_item_heart
   .db #56
   .db #156
   .dw #0
   .db #4                                  ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #0
   .dw #0

   .db #level_new_entity
   .dw #t_item_shield
   .db #56
   .db #124
   .dw #0
   .db #4                                  ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #0
   .dw #0

   .db #level_new_entity
   .dw #t_item_skip
   .db #56
   .db #92
   .dw #0
   .db #4                                  ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #0
   .dw #0

   .db #level_new_entity
   .dw #t_item_restart
   .db #56
   .db #68
   .dw #0
   .db #4                                  ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #0
   .dw #0

   .db #level_separator
   ;================================================================================
   ; LEVEL ALL SPRITES
   ;================================================================================

   ; .dw #_tilemap_01            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #42                   ;Entity X
   ; .db #176                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #24
   ; .db #156
   ; .dw #enemy_no_move
   ; .db #4                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_all_game_zone_m0
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #34
   ; .db #156
   ; .dw #enemy_no_move
   ; .db #4                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_all_game_zone_m0
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #44
   ; .db #156
   ; .dw #enemy_no_move
   ; .db #4                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_all_game_zone_m0
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #54
   ; .db #156
   ; .dw #enemy_no_move
   ; .db #4                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_all_game_zone_m0
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #24
   ; .db #124
   ; .dw #_sys_ai_behaviourSpawner_template
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0                                 ; e_ai_aux_h
   ; .dw #t_enemy_patrol_game_zone
   ; .dw #enemy_no_shoot

   ; .db #level_new_entity
   ; .dw #t_bullet_enemy_l
   ; .db #34
   ; .db #124
   ; .dw #enemy_no_move
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0                                 ; e_ai_aux_h
   ; .dw #patrol_none
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator

   ; ================================================================================
   ; Level numbers test
   ; ================================================================================
   ; .dw #_tilemap_01decoration
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #38                   ;Entity X
   ; .db #160                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #38
   ; .db #136
   ; .dw #enemy_no_move
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;

   ; ================================================================================
   ; Level 1
   ; ================================================================================

   .dw #__tilemap_01controls
   .db #level_new_entity
   .dw #t_player
   .db #38                   ;Entity X
   .db #160                   ;Entity Y                  ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #8
   .db #56
   .dw #_sys_ai_behaviourPatrol_f
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_01
   .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; Level 2
   ;================================================================================

   .dw #_tilemap_01decoration
   .db #level_new_entity
   .dw #t_player
   .db #36                   ;Entity X
   .db #112                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #16
   .db #168
   .dw #_sys_ai_behaviourPatrolRelative
   .db #16                                 ; e_ai_aux_l
   .db #168
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #40
   .db #56
   .dw #_sys_ai_behaviourPatrol
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_06
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_item_heart
   .db #56
   .db #156
   .dw #0
   .db #4                                  ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #0
   .dw #0

   .db #level_separator
   ; ================================================================================
   ; Level 3
   ; ================================================================================

   .dw #_tilemap_01decoration
   .db #level_new_entity
   .dw #t_player
   .db #38                   ;Entity X
   .db #176                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #8
   .db #56
   .dw #_sys_ai_behaviourPatrol
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_03
   .dw #_sys_ai_beh_shoot_x

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #20
   .db #56
   .dw #_sys_ai_behaviourPatrol
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_05
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #40
   .db #72
   .dw #_sys_ai_behaviourPatrolRelative
   .db #40                                 ; e_ai_aux_l
   .db #72
   .dw #patrol_relative_x_24
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 4
   ;================================================================================
   .dw #_tilemap_10            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36
   .db #176

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #48
   .dw #_sys_ai_behaviourPatrolRelative
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36_around
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #16
   .db #48
   .dw #_sys_ai_behaviourPatrolRelative
   .db #16                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36_around
   .dw #_sys_ai_beh_shoot_seekplayer

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #28
   .db #48
   .dw #_sys_ai_behaviourPatrolRelative
   .db #28                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36_around
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 5
   ;================================================================================
   .dw #_tilemap_06            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #8
   .db #56

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #70
   .db #48
   .dw #_sys_ai_beh_follow_player_y
   .db #20
   .db #20                                 ; e_ai_aux_h
   .dw #0
   .dw #_sys_ai_beh_shoot_x

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #70
   .db #176
   .dw #_sys_ai_beh_follow_player_x
   .db #1
   .db #1                                 ; e_ai_aux_h
   .dw #0
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #32
   .db #64
   .dw #_sys_ai_behaviourPatrolRelative
   .db #32                                 ; e_ai_aux_l
   .db #64                                 ; e_ai_aux_h
   .dw #patrol_relative_y_48
   .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; Level 7
   ;================================================================================

   .dw #_tilemap_08            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36                   ;Entity X
   .db #120                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #60
   .db #176
   .dw #_sys_ai_behaviourPatrolRelative
   .db #60                                 ; e_ai_aux_l
   .db #176
   .dw #patrol_relative_x_24
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #52
   .dw #_sys_ai_behaviourPatrolRelative
   .db #4                                 ; e_ai_aux_l
   .db #52
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #76
   .dw #_sys_ai_behaviourPatrolRelative
   .db #4                                 ; e_ai_aux_l
   .db #76
   .dw #patrol_relative_x_16
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 8
   ;================================================================================

   .dw #_tilemap_03            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #6                   ;Entity X
   .db #168                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #8
   .db #56
   .dw #_sys_ai_behaviourPatrol
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_03
   .dw #_sys_ai_beh_shoot_d

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #34
   .db #48
   .dw #_sys_ai_behaviourPatrolRelative
   .db #34
   .db #48
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #68
   .db #56
   .dw #_sys_ai_beh_follow_player_y
   .db #t_follow_timer
   .db #t_follow_timer
   .dw #patrol_03
   .dw #enemy_no_shoot

   .db #level_separator

   ;================================================================================
   ; Level 6
   ;================================================================================
   .dw #_tilemap_01decoration
   .db #level_new_entity
   .dw #t_player
   .db #70
   .db #176

   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #4
   ; .db #64
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0                                 ; e_ai_aux_h
   ; .dw #patrol_11
   ; .dw #_sys_ai_beh_shoot_d

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #38
   .db #96
   .dw #_sys_ai_behaviourSpawner_template
   .db #0                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #t_es_01
   .dw #enemy_no_shoot


   .db #level_separator


   ;================================================================================
   ; Level 9
   ;================================================================================
   .dw #_tilemap_05            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36                   ;Entity X
   .db #156                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #4
   .db #48
   .dw #_sys_ai_beh_follow_player_y
   .db #1
   .db #1
   .dw #patrol_03
   .dw #_sys_ai_beh_shoot_x

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #70
   .db #176
   .dw #_sys_ai_beh_follow_player_y
   .db #1
   .db #1
   .dw #patrol_03
   .dw #_sys_ai_beh_shoot_x

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #4
   .db #48
   .dw #_sys_ai_beh_follow_player_x
   .db #16
   .db #16
   .dw #0
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 10
   ;================================================================================
   .dw #_tilemap_03            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #16
   .db #176

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #8
   .db #52
   .dw #_sys_ai_behaviourSpawner_template
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #t_es_01
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #80
   .dw #_sys_ai_behaviourPatrolRelative
   .db #4
   .db #80
   .dw #patrol_relative_y_48
   .dw #_sys_ai_beh_shoot_x_f

   .db #level_separator
   ;================================================================================
   ; Level 11
   ;================================================================================
   .dw #_tilemap_06            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36
   .db #176

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #12
   .db #64
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #64
   .db #56
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_06
   .dw #_sys_ai_beh_shoot_xy_rand

   .db #level_separator

   ;================================================================================
   ; Level 12
   ;================================================================================
   .dw #_tilemap_0run            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #12
   .db #104

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #70
   .db #176
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #54
   .db #176
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_02
   .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; Level 14
   ;================================================================================
   .dw #_tilemap_02            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #10
   .db #56

   .db #level_new_entity
   .dw #t_spawner_from_plist_01
   .db #70
   .db #176
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #spawner_plist_01
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #36
   .db #168
   .dw #_sys_ai_beh_follow_player_x
   .db #16
   .db #16
   .dw #0
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 15
   ;================================================================================
   .dw #_tilemap_07            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #10
   .db #56

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #54
   .db #80
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #spawner_plist_02
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #28
   .db #160
   .dw #_sys_ai_beh_follow_player_x
   .db #5
   .db #16
   .dw #patrol_all_game_zone_0m
   .dw #_sys_ai_beh_shoot_y

   .db #level_separator
   ;================================================================================
   ; Level 16
   ;================================================================================
   .dw #_tilemap_04            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #70
   .db #176

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #4
   .db #48
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #spawner_plist_03
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #12
   .db #96
   .dw #_sys_ai_beh_follow_player_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #0
   .dw #_sys_ai_beh_shoot_x

   .db #level_separator
   ;================================================================================
   ; Level 17
   ;================================================================================
   ;; TODO: aqui puede pasar lo de pasar de level sin matar al spawner
   .dw #_tilemap_06            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4
   .db #48

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #4
   .db #174
   .dw #_sys_ai_behaviourSpawner_template
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #t_es_04
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #48
   .db #48
   .dw #_sys_ai_beh_follow_player_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #0
   .dw #_sys_ai_beh_shoot_x_f

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #4
   .db #136
   .dw #_sys_ai_behaviourPatrolRelative
   .db #4                                 ; e_ai_aux_l
   .db #136                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36
   .dw #enemy_no_shoot
   ;
   .db #level_separator
   ;================================================================================
   ; Level 18 es jodido igual mas adelante
   ;================================================================================
   .dw #_tilemap_05            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36
   .db #176

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #12
   .db #64
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #70
   .db #48
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_all_game_zone_0m
   .dw #_sys_ai_beh_shoot_seekplayer

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #28
   .db #80
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_08
   .dw #_sys_ai_beh_shoot_d

   .db #level_separator
   ;================================================================================
   ; 19 tres gamezon
   ;================================================================================
   .dw #_tilemap_04            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36                   ;Entity X
   .db #104                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #48
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_all_game_zone_00
   .dw #_sys_ai_beh_shoot_xy_rand

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #70
   .db #48
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_all_game_zone_0m
   .dw #_sys_ai_beh_shoot_seekplayer

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #70
   .db #176
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_all_game_zone_mm
   .dw #_sys_ai_beh_shoot_d

   .db #level_separator
   ;================================================================================
   ; Level 20 rainbow
   ;================================================================================
   .dw #_tilemap_09            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4
   .db #48

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #36
   .db #108
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #spawner_plist_05
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_es_07
   .db #36
   .db #108
   .dw #_sys_ai_behaviourPatrolRelative
   .db #36                                 ; e_ai_aux_l
   .db #108                                 ; e_ai_aux_h
   .dw #patrol_relative_around_01
   .dw #_sys_ai_beh_shoot_d

   .db #level_separator
   ;================================================================================
   ; Level 21 tres rojos
   ;================================================================================
   .dw #_tilemap_0run            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #12
   .db #104

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #70
   .db #176
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_01
   .dw #_sys_ai_beh_shoot_seekplayer

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #54
   .db #176
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_seeknpatrol_02
   .dw #_sys_ai_beh_shoot_xy_rand

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #4
   .db #176
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #25
   .db #25
   .dw #patrol_relative_around_01
   .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; Level 22
   ;================================================================================
   .dw #_tilemap_05            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #36                   ;Entity X
   .db #176                   ;Entity Y

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #36
   .db #108
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #spawner_plist_06
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_es_07
   .db #36
   .db #108
   .dw #_sys_ai_behaviourPatrolRelative
   .db #36                                 ; e_ai_aux_l
   .db #108                                 ; e_ai_aux_h
   .dw #patrol_relative_around_01
   .dw #_sys_ai_beh_shoot_d

   .db #level_separator
   ;================================================================================
   ; Level 23
   ;================================================================================
   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4                   ;Entity X
   .db #176                   ;Entity Y

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #36
   .db #108
   .dw #_sys_ai_behaviourSpawner_template
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #t_es_08
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_es_07
   .db #36
   .db #108
   .dw #_sys_ai_behaviourPatrolRelative
   .db #36                                 ; e_ai_aux_l
   .db #108                                 ; e_ai_aux_h
   .dw #patrol_relative_around_01
   .dw #_sys_ai_beh_shoot_d

   .db #level_separator
   ;================================================================================
   ; Level 24 FINAL
   ;================================================================================
   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4                   ;Entity X
   .db #104                   ;Entity Y

   ; a ver en realidad hay probabilidad de que cuando mates a un spawner
   ; el otro saque 3 enemigos y se realentice el juego, pero para ese momento ya
   ; estas muerto o sea que no pasa nada
   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #70
   .db #176
   .dw #_sys_ai_behaviourSpawner_template_f
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #t_es_08
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #70
   .db #48
   .dw #_sys_ai_behaviourSpawner_template_f
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #t_es_09
   .dw #enemy_no_shoot

   .db #level_separator

   ;================================================================================
   ; TEST END
   ;================================================================================
   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #4                   ;Entity X
   .db #48                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #70
   .db #176
   .dw #enemy_no_move
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   .dw #00
   .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; GAME END
   ;================================================================================
   .db #level_separator



bonus_levels:
   ;================================================================================
   ; Level 13 SUS
   ;================================================================================
   .dw #_tilemap_0sus            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #26                   ;Entity X
   .db #72                   ;Entity Y

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #20
   .db #140
   .dw #_sys_ai_behaviourSpawner_template
   .db #0                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #t_es_06
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_spawner_from_template_01
   .db #54
   .db #176
   .dw #_sys_ai_behaviourSpawner_template_f
   .db #0                                 ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #t_es_05
   .dw #enemy_no_shoot

   .db #level_separator
