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


   ; .dw #_tilemap_01            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #0x26                   ;Entity X
   ; .db #0xB0                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_patrol_relative_01
   ; .db #44
   ; .db #90

   ; .db #level_separator
   ; .db #level_separator

   ; .db #level_new_entity
   ; .dw #t_bullet_enemy_l
   ; .db #50
   ; .db #50
   ; .dw #enemy_no_move
   ; .db #4                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_all_game_zone
   ; .dw #enemy_no_move
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic
   ; .db #20
   ; .db #50
   ; .dw #_sys_ai_behaviourPatrol 
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; ; .dw #patrol_x_50_20 ;; pstrol_step
   ; .dw #_sys_ai_beh_shoot_x


   ; .db #level_separator
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
   ; .dw #t_enemy_basic_blue
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
   ;
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


   ;================================================================================
   ; Level 1
   ;================================================================================
   ;
   ; .dw #_tilemap_01            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #38                   ;Entity X
   ; .db #176                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #8
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #64
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_02
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 2
   ;================================================================================

   ; .dw #_tilemap_01            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36                   ;Entity X
   ; .db #104                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #16
   ; .db #168
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #16                                 ; e_ai_aux_l
   ; .db #168
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #40
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_06
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 3
   ;================================================================================
   ;
   ; .dw #_tilemap_01            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #38                   ;Entity X
   ; .db #176                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #8
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_03
   ; .dw #_sys_ai_beh_shoot_x
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #20
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_05
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #40
   ; .db #72
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #40                                 ; e_ai_aux_l
   ; .db #72
   ; .dw #patrol_relative_x_24
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 4
   ;================================================================================

   ; .dw #_tilemap_03            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #6                   ;Entity X
   ; .db #168                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #8
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0
   ; .dw #patrol_03
   ; .dw #_sys_ai_beh_shoot_d
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #34
   ; .db #48
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #34
   ; .db #48
   ; .dw #patrol_relative_x_24
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #68
   ; .db #56
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db #t_follow_timer
   ; .db #t_follow_timer
   ; .dw #patrol_03
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level mas adelantes esmuy chungo
   ;================================================================================

   ; 4 zonas de gamezone
   .dw #_tilemap_01            ;Tilemap
   ; .dw #_tilemap_04            ;Tilemap
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

   .db #level_new_entity
   .dw #t_enemy_basic_blue
   .db #4
   .db #176
   .dw #_sys_ai_behaviourPatrol
   .db #0
   .db #0
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot


   .db #level_separator
   ;================================================================================
   ; Level SUS
   ;================================================================================
   .dw #_tilemap_01            ;Tilemap
   ; .dw #_tilemap_0sus            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #26                   ;Entity X
   .db #72                   ;Entity Y

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #54
   .db #156
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #15
   .dw #patrol_seeknpatrol_01
   .dw #_sys_ai_beh_shoot_xy_rand

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #54
   .db #124
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #patrol_seeknpatrol_02
   .dw #_sys_ai_beh_shoot_d

   .db #level_new_entity
   .dw #t_enemy_basic_green
   .db #26
   .db #140
   .dw #_sys_ai_behaviourPatrolRelative
   .db #26
   .db #140
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y_f

   .db #level_separator
   ;================================================================================
   ; GAME END
   ;================================================================================
   .db #level_separator
