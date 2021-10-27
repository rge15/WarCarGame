.include "resources/tilemaps.h.s"
.include "resources/templates.h.s"

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
    .dw #_tilemap_01            ;Tilemap
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    ; ya tiraok

    ; .db #level_new_entity
    ; ; .dw #t_spawner_template_02
    ; .dw #t_spawner_template_02
    ; .db #40                   ;Entity X
    ; .db #80                   ;Entity Y

    .db #level_new_entity
    ; .dw #t_enemy_patrol_01
    ; .dw #t_enemy_seeknpatrol
    .dw #t_enemy_testing
    .db #20                   ;Entity X
    .db #90                   ;Entity Y
    ;
    ; .db #level_new_entity
    ; .dw #t_enemy_patrol_01
    ; .db #0x40                   ;Entity X
    ; .db #0x80                   ;Entity Y
    ;
    ; .db #level_new_entity
    ; .dw #t_enemy_patrol_relative_01
    ; .db #44
    ; .db #90

    .db #level_separator

    ;;;; LEVELS

    ; Level 1

    .dw #_tilemap_01            ;Tilemap
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    .db #level_new_entity
    .dw #t_enemy_01_L01
    .db #20
    .db #50

    .db #level_separator
    ; Level 2

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
