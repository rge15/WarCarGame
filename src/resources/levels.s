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
   ; Level all Sprites
   ;================================================================================

   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #42                   ;Entity X
   .db #176                   ;Entity Y

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
   .dw #t_enemy_basic_blue
   .db #34
   .db #156
   .dw #enemy_no_move
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_purple
   .db #44
   .db #156
   .dw #enemy_no_move
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot

   .db #level_new_entity
   .dw #t_enemy_basic_red
   .db #54
   .db #156
   .dw #enemy_no_move
   .db #4                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_all_game_zone_m0
   .dw #enemy_no_shoot





   .db #level_separator        ;TODO : ESto quitarlo para cargar más niveles
   ;================================================================================
   ; Level 2
   ;================================================================================

   .dw #_tilemap_01            ;Tilemap
   .db #level_new_entity
   .dw #t_player
   .db #0x26                   ;Entity X
   .db #0xB0                   ;Entity Y

   ;; spaner bichong
   .db #level_new_entity
   .dw #t_spawner_template_02
   .db #55
   .db #90
   .dw #_sys_ai_behaviourSpawner_plist
   .db #00                                 ; e_ai_aux_l
   .db #00                                 ; e_ai_aux_h
   ; .dw #t_enemy_testing
   .dw #spawner_plist_02
   .dw #enemy_no_shoot

   .db #level_separator        ;TODO : ESto quitarlo para cargar más niveles
   .db #level_separator
   ; Level 3

   .db #level_separator
   ;================================================================================
   ; Level SUS
   ;================================================================================
   .dw #_tilemap_0sus            ;Tilemap
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
