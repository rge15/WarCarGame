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
    .dw #0xE880   ;Life 1
    .db #0x01
    .dw #0xE889     ;Life 2
    .db #0x01
    .dw #0xE892     ;Life 3

;;Descripcion : Width de cada vida en pantalla
_m_HUD_lifeWidth:
    .db #0x06

;;Descripcion : Height de cada vida en pantalla
_m_HUD_lifeHeight:
    .db #0x10

;;Descripcion : Width de cada digito de la puntuacion en pantalla
_m_HUD_scoreWidth:
    .db #0x04

;;Descripcion : Height de cada digito de la puntuacion en pantalla
_m_HUD_scoreHeight:
    .db #0x08

;; Descripcion: Posicion en la pantalla donde se va a imprimir la score
_m_HUD_scorePosition:
    .dw 1

;;Descripcion : Puntuacion jugador
_m_playerScore:
   .ds 2

;;Descripcion : Puntuacion jugador
_m_startLevelPlayerScore:
   .dw #0x0000

;===================================================================================================================================================
; Functions
;===================================================================================================================================================

_m_HUD_saveScore::
    ld de, #_m_playerScore
    ld hl, #_m_startLevelPlayerScore
    ld a, (de)
    ld (hl),a
    inc hl
    inc de
    ld a, (de)
    ld (hl),a


    ret

_m_HUD_resetLevelScore::
    ld hl, #_m_playerScore
    ld de, #_m_startLevelPlayerScore
    ld a, (de)
    ld (hl),a
    inc hl
    inc de
    ld a, (de)
    ld (hl),a

    ret

;===================================================================================================================================================
; FUNCION _m_HUD_initHUD
; Función encargada de iniciar las variables de HUD (Videas y Score)
; NO llega ningun dato
;===================================================================================================================================================
_m_HUD_initHUD::
    call _m_HUD_initLifes
    call _m_HUD_initScore
    ret

;===================================================================================================================================================
; FUNCION _m_HUD_initLifes
; Función encargada de iniciar las vidas
; NO llega ningun dato
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

;===================================================================================================================================================
; FUNCION _m_HUD_initScore
; Función encargada de iniciar el valor de la puntuación
; NO llega ningun dato
;===================================================================================================================================================
_m_HUD_initScore::
    ld hl, #_m_playerScore
    ld (hl), #0x00
    inc hl
    ld (hl), #0x00
    ld hl, #_m_startLevelPlayerScore
    ld (hl), #0x00
    inc hl
    ld (hl), #0x00

    ret


;===================================================================================================================================================
; FUNCION _m_HUD_renderHUD
; Función encargada de llamar al render del HUD
; NO llega ningun dato
;===================================================================================================================================================
_m_HUD_renderHUD::
    call _m_HUD_renderLifes
    ld a, #0x01
    call _m_HUD_renderScore
    ret

;===================================================================================================================================================
; FUNCION _m_HUD_renderLifes
; Función encargada de renderizar las vidas
; NO llega ningun dato
;===================================================================================================================================================
_m_HUD_renderLifes::
    ld hl , #_m_HUD_life
    call _sys_render_renderHUDLifes
    ret

;===================================================================================================================================================
; FUNCION _m_HUD_renderLifes
; Función encargada de renderizar las vidas
;       - a = 1 -> Es para imprimir mid-game
;       - a = 0 -> Es para imprimir al acabar partida
;===================================================================================================================================================
_m_HUD_renderScore::
    ;; Comprobamos de donde se llama la función
    inc a
    dec a
    jp nz, _midGamePos

    ld de, #0xC000
    ld c, #0x1C    ;; X
    ld b, #0x5C   ;; Y
    call cpct_getScreenPtr_asm
    jp _avoidMidGamePos

    _midGamePos:
    ld hl, #0xC0A8

    _avoidMidGamePos:

    ld (_m_HUD_scorePosition), hl

    ld hl , #_m_playerScore
    ld a, (hl)
    rra
    rra
    rra
    rra
    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)
    ld hl, (_m_HUD_scorePosition)
    inc hl
    inc hl
    inc hl
    inc hl
    ld (_m_HUD_scorePosition), hl

    call _sys_render_renderHUDScore

    ld hl , #_m_playerScore
    ld a, (hl)
    
    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)
    ld hl, (_m_HUD_scorePosition)
    inc hl
    inc hl
    inc hl
    inc hl
    ld (_m_HUD_scorePosition), hl
    

    call _sys_render_renderHUDScore
    
    ld hl , #_m_playerScore
    inc hl
    ld a, (hl)
    rra
    rra
    rra
    rra
    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)
    ld hl, (_m_HUD_scorePosition)
    inc hl
    inc hl
    inc hl
    inc hl
    ld (_m_HUD_scorePosition), hl

    call _sys_render_renderHUDScore


    ld hl , #_m_playerScore
    inc hl
    ld a, (hl)

    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)
    ld hl, (_m_HUD_scorePosition)
    inc hl
    inc hl
    inc hl
    inc hl
    ld (_m_HUD_scorePosition), hl

    call _sys_render_renderHUDScore

    ld a, #0x00
    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)
    ld hl, (_m_HUD_scorePosition)
    inc hl
    inc hl
    inc hl
    inc hl
    ld (_m_HUD_scorePosition), hl

    call _sys_render_renderHUDScore

    ld a, #0x00
    PREPARE_SCORE_DIGIT_TO_RENDER (_m_HUD_scorePosition)

    call _sys_render_renderHUDScore

    ret



;===================================================================================================================================================
; FUNCION _m_HUD_decreaseLife
; Función encargada de restar las vidas
; NO llega ningun dato
;===================================================================================================================================================
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


;===================================================================================================================================================
; FUNCION _m_HUD_addPoints
; Función encargada de sumar puntos
; BC : Llegan los puntos a sumar
;===================================================================================================================================================
_m_HUD_addPoints::
    ;Cargamos la primera parte del Score en A 
    ld hl, #_m_playerScore
    ; ld bc, #0x0002
    inc hl
    ld a, (hl)

    ;Subimos la puntuación
    add c
    daa
    ld (hl), a
    dec hl
    ld a,(hl)
    adc b
    daa
    ld (hl), a
    
    ret