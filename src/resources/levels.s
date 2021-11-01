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

   ; .dw #_tilemap_0sus            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #4                   ;Entity X
   ; .db #48                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_plist_01
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #spawner_plist_01
   ; .dw #enemy_no_shoot
   ;
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
   ;
   ;
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
   ; Level 1
   ; ================================================================================
   
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
   ; ================================================================================
   ; Level 3
   ; ================================================================================
   
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

   ; .dw #_tilemap_08            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36                   ;Entity X
   ; .db #120                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #60
   ; .db #176
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #60                                 ; e_ai_aux_l
   ; .db #176
   ; .dw #patrol_relative_x_24
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #4
   ; .db #52
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #4                                 ; e_ai_aux_l
   ; .db #52
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #4
   ; .db #76
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #4                                 ; e_ai_aux_l
   ; .db #76
   ; .dw #patrol_relative_x_16
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 5
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
   ; .dw #t_enemy_basic_blue
   ; .db #34
   ; .db #48
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #34
   ; .db #48
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
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
   ; Level 6
   ;================================================================================
   ; .dw #_tilemap_05            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36                   ;Entity X
   ; .db #152                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #4
   ; .db #48
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db #1
   ; .db #1
   ; .dw #patrol_03
   ; .dw #_sys_ai_beh_shoot_x
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db #1
   ; .db #1
   ; .dw #patrol_03
   ; .dw #_sys_ai_beh_shoot_x
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #36
   ; .db #48
   ; .dw #_sys_ai_beh_follow_player_x
   ; .db #16
   ; .db #16
   ; .dw #0
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 7
   ;================================================================================
   ; .dw #_tilemap_03            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36
   ; .db #176
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #8
   ; .db #52
   ; .dw #_sys_ai_behaviourSpawner_template
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #t_es_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #4
   ; .db #80
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #4
   ; .db #80
   ; .dw #patrol_relative_y_48
   ; .dw #_sys_ai_beh_shoot_x_f
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 8
   ;================================================================================
   ; .dw #_tilemap_06            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36
   ; .db #176
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #12
   ; .db #64
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #64
   ; .db #56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0
   ; .db #0
   ; .dw #patrol_06
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 9
   ;================================================================================
   ; .dw #_tilemap_0run            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #12
   ; .db #104
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #54
   ; .db #176
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_02
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 10 SUS
   ; ================================================================================
   ; .dw #_tilemap_0sus            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #26                   ;Entity X
   ; .db #72                   ;Entity Y
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #54
   ; .db #176
   ; .dw #_sys_ai_behaviourSpawner_template
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0                                 ; e_ai_aux_h
   ; .dw #t_es_05
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #20
   ; .db #140
   ; .dw #_sys_ai_behaviourSpawner_template
   ; .db #0                                 ; e_ai_aux_l
   ; .db #0                                 ; e_ai_aux_h
   ; .dw #t_es_06
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 11
   ;================================================================================
   ; .dw #_tilemap_02            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #10
   ; .db #56
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_plist_01
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #spawner_plist_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #12
   ; .db #168
   ; .dw #_sys_ai_beh_follow_player_x
   ; .db #16
   ; .db #16
   ; .dw #0
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 12
   ;================================================================================
   ; .dw #_tilemap_07            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #10
   ; .db #56
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #54
   ; .db #80
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #spawner_plist_02
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #28
   ; .db #160
   ; .dw #_sys_ai_beh_follow_player_x
   ; .db #5
   ; .db #16
   ; .dw #patrol_all_game_zone_0m
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 13
   ;================================================================================
   ; .dw #_tilemap_04            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #70
   ; .db #176
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #4
   ; .db #48
   ; .dw #_sys_ai_behaviourSpawner_plist
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #spawner_plist_03
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #12
   ; .db #96
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db #t_follow_timer                                 ; e_ai_aux_l
   ; .db #t_follow_timer                                 ; e_ai_aux_h
   ; .dw #0
   ; .dw #_sys_ai_beh_shoot_x
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #20
   ; .db #64
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #20                                 ; e_ai_aux_l
   ; .db #64                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 14
   ;================================================================================
   ;; TODO: aqui puede pasar lo de pasar de level sin matar al spawner
   ; .dw #_tilemap_06            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #4
   ; .db #48
   ;
   ; .db #level_new_entity
   ; .dw #t_spawner_from_template_01
   ; .db #4
   ; .db #174
   ; .dw #_sys_ai_behaviourSpawner_template
   ; .db #00                                 ; e_ai_aux_l
   ; .db #00                                 ; e_ai_aux_h
   ; .dw #t_es_04
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #48
   ; .db #48
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db #t_follow_timer                                 ; e_ai_aux_l
   ; .db #t_follow_timer                                 ; e_ai_aux_h
   ; .dw #0
   ; .dw #_sys_ai_beh_shoot_x_f
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_green
   ; .db #4
   ; .db #136
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #4                                 ; e_ai_aux_l
   ; .db #136                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #enemy_no_shoot
   ; ;
   ; .db #level_separator
   ;================================================================================
   ; Level 15 es jodido igual mas adelante
   ;================================================================================
   ; .dw #_tilemap_05            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #36
   ; .db #176
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #12
   ; .db #64
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_purple
   ; .db #70
   ; .db #48
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0
   ; .db #0
   ; .dw #patrol_all_game_zone_0m
   ; .dw #_sys_ai_beh_shoot_seekplayer
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #28
   ; .db #80
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0
   ; .db #0
   ; .dw #patrol_08
   ; .dw #_sys_ai_beh_shoot_d
   ;
   ; .db #level_separator
   ;================================================================================
   ; Level 16
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
   ; 17 Level mas adelantes esmuy chungo
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

   ; .db #level_new_entity
   ; .dw #t_enemy_basic_blue
   ; .db #4
   ; .db #176
   ; .dw #_sys_ai_behaviourPatrol
   ; .db #0
   ; .db #0
   ; .dw #patrol_all_game_zone_m0
   ; .dw #enemy_no_shoot

   .db #level_separator
   ;================================================================================
   ; Level 18 tres rojos
   ;================================================================================
   ; .dw #_tilemap_0run            ;Tilemap
   ; .db #level_new_entity
   ; .dw #t_player
   ; .db #12
   ; .db #104
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #70
   ; .db #176
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_01
   ; .dw #_sys_ai_beh_shoot_seekplayer
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #54
   ; .db #176
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_seeknpatrol_02
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ; .db #level_new_entity
   ; .dw #t_enemy_basic_red
   ; .db #4
   ; .db #176
   ; .dw #_sys_ai_behaviourSeekAndPatrol
   ; .db #25
   ; .db #25
   ; .dw #patrol_relative_around_01
   ; .dw #enemy_no_shoot
   ;
   ; .db #level_separator
   ;================================================================================
   ; GAME END
   ;================================================================================
   .db #level_separator
