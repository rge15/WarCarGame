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
    ; .dw #_tilemap_01            ;Tilemap
    ; .db #level_new_entity                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    ; .dw #t_player     ;Entity Template
    ; .db #0x26                   ;Entity X
    ; .db #0xB0                   ;Entity Y
    ; .db #level_new_entity                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    ; .dw #t_enemy_testing     ;Entity Template
    ; .db #50                                 ; Entity X
    ; .db #50                                 ; Entity Y
    ; .db #level_new_entity
    ; .dw #t_spawner_template_01     ;Entity Template
    ; .db #30                                 ; Entity X
    ; .db #60                                 ; Entity Y

    ; Level Test
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

    ;;;; LEVELS

    ; Level 1

    .dw #_tilemap_01            ;Tilemap
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    ; .db #level_new_entity
    ; .dw #t_enemy_basic
    ; .db #58
    ; .db #80
    ; .dw #enemy_no_move
    ; .db #00                                 ; e_ai_aux_l
    ; .db #00                                 ; e_ai_aux_h
    ; .dw #patrol_x_50_20
    ; .dw #_sys_ai_beh_shoot_x_f
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

    ;; Esquema behaviour follow
    ; .db #level_new_entity
    ; .dw #t_enemy_basic
    ; .db #45
    ; .db #60
    ; .dw #_sys_ai_beh_follow_player_y
    ; ;; si es un timer realmente puede ser cualquier valor
    ; .db #t_follow_timer
    ; .db #t_follow_timer
    ; .dw #patrol_x_50_20
    ; .dw #_sys_ai_beh_shoot_x_f

    ;; Esquema patrol relative
    .db #level_new_entity
    .dw #t_enemy_patrol_01
    .db #40
    .db #90
    .dw #_sys_ai_behaviourPatrolRelative
    .db #40
    .db #90                                 ; e_ai_aux_h
    .dw #patrol_relative_x_12
    .dw #_sys_ai_beh_shoot_seekplayer

    ;; Esquema spawner
    ;; TODO: hacer templates para los enemigos a spawnear
    ; .db #level_new_entity
    ; .dw #t_spawner_template_02
    ; .db #55
    ; .db #90
    ; .dw #_sys_ai_behaviourSpawner_template
    ; .db #00                                 ; e_ai_aux_l
    ; .db #00                                 ; e_ai_aux_h
    ; .dw #t_enemy_patrol_relative_02
    ; .dw #enemy_no_shoot

    ; Esquema seeknpatrol
    ; .db #level_new_entity
    ; .dw #t_enemy_basic
    ; .db #45
    ; .db #60
    ; .dw #_sys_ai_behaviourSeekAndPatrol
    ; .db #t_follow_timer
    ; .db #t_follow_timer
    ; ; .dw #patrol_relative_none
    ; .dw #patrol_seeknpatrol_01
    ; .dw #_sys_ai_beh_shoot_xy_rand


    .db #level_separator        ;TODO : ESto quitarlo para cargar más niveles
    ; Level 2

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

    .dw #_tilemap_01            ;Tilemap
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    .db #level_new_entity
    .dw #t_enemy_01_L02
    .db #18
    .db #78

    .db #level_new_entity
    .dw #t_enemy_02_L02
    .db #50
    .db #78

    .db #level_separator
    ; Level 3

    .dw #_tilemap_01
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    .db #level_new_entity
    .dw #t_enemy_01_L03
    .db #20
    .db #50

    .db #level_new_entity
    .dw #t_enemy_02_L03
    .db #10
    .db #50



    .db #level_separator
    ; Game END
    .db #level_separator
