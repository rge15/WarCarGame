.module HUD
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/sprites.h.s"
.include "resources/animations.h.s"
.include "cpct_globals.h.s"
.include "man/game.h.s"
.include "sys/render.h.s"

;===================================================================================================================================================
; Manager Data
;===================================================================================================================================================
_m_HUD_life:
    .db #0x01
    .dw #0xF075    ;Life 1
    .db #0x01
    .dw #0xF082     ;Life 2
    .db #0x01
    .dw #0xF08F     ;Life 3

_m_HUD_lifeWidth:
    .db #0x0A

_m_HUD_lifeHeight:
    .db #0x15


;===================================================================================================================================================
; Functions
;===================================================================================================================================================

_m_HUD_initLifes::
    ld hl, #_m_HUD_life
    ld a, #0x03
    ld bc, #0x0003
    rechargeLifes:
    ld (hl) , #0x01
    add hl, bc
    dec a
    jr NZ, rechargeLifes

    ret

_m_HUD_renderLifes::
    ld hl , #_m_HUD_life
    call _sys_render_renderHUDLifes
    ret

_m_HUD_decreaseLife::
    ld hl, #_m_HUD_life
    inc (hl)
    dec (hl)
    jr NZ, changeLife

    ld a, #0x02
    ld bc, #0x0003
    nextLife:
    add hl, bc
    inc (hl)
    dec (hl)
    jr NZ, changeLife
    dec a
    jr NZ, nextLife
    jr Z,  endLifes
    changeLife:
    dec (hl)
    endLifes:

    ret