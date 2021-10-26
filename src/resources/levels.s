.include "resources/tilemaps.h.s"
.include "resources/templates.h.s"

; balas player tiempo
; spawn con numplayer de game
; crear niveles sin a sacco de templates?
; diagonales debug
; shield con type diferente

_level1:
    .dw #_tilemap_01            ;Tilemap
    .db #0x01                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    .dw #t_player     ;Entity Template
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y
    .db #0x01                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    .dw #t_enemy_testing     ;Entity Template
    .db #50                                 ; Entity X
    .db #50                                 ; Entity Y
    .db #0x01
    .dw #t_enemy_testing2     ;Entity Template
    .db #20                                 ; Entity X
    .db #60                                 ; Entity Y
    .db #0x00                   ;With 00 we mark the end of level array
   ; .db #0x00                   ;With 00 we mark the end of level array

; _level2:
    .dw #_tilemap_01            ;Tilemap
    .db #0x01                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    .dw #t_player     ;Entity Template
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y
    ; .db #0x01                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    ; .dw #t_enemy_testing     ;Entity Template
    ; .db #50                                 ; Entity X
    ; .db #50                                 ; Entity Y
    ; .db #0x01
    .dw #t_enemy_testing2     ;Entity Template
    .db #20                                 ; Entity X
    .db #60                                 ; Entity Y
    .db #0x00                   ;With 00 we mark the end of level array

    .db #0x00                   ;With 00 we mark the end of level array
