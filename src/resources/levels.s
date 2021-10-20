.include "resources/tilemaps.h.s"
.include "resources/templates.h.s"

_level1:
    .dw #_tilemap_01            ;Tilemap
    .db #0x01                   ;Mark entity (Si no estuviera esto y alguna template estubiera en memoria 0 saldría de cargar el nivel)
    .dw #_player_template_e     ;Entity Template
    .db #0x26                   ;Entity X
    .db #0xB0                   ;Entity Y
    .db #0x00                   ;With 00 we mark the end of level array
    .db #0x00                   ;With 00 we mark the end of level array