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

    ; .db #level_separator

    .dw #_tilemap_01            ;Tilemap
    .db #level_new_entity
    .dw #t_player
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y

    ; enemies
    ; .db #level_new_entity
    ; .dw #t_spawner_template_01
    ; .db #0x40                   ;Entity X
    ; .db #0x80                   ;Entity Y

    .db #level_new_entity
    .dw #t_enemy_patrol_relative_01
    .db #0x40                   ;Entity X
    .db #0x80                   ;Entity Y


    .db #level_separator
    .db #level_separator
