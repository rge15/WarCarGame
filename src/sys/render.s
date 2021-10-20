.module Render

;===================================================================================================================================================
; CPCTelera functions
;===================================================================================================================================================
.globl cpct_getScreenPtr_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm
.globl cpct_setPalette_asm
.globl cpct_drawSprite_asm
.globl cpct_etm_setDrawTilemap4x8_ag_asm
.globl cpct_etm_drawTilemap4x8_ag_asm

;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "man/entity.h.s"
.include "cpct_globals.h.s"
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/sprites.h.s"
.include "resources/animations.h.s"


;===================================================================================================================================================
; Assets
;===================================================================================================================================================
.globl _tilemap_01
.globl _tileset_0
.globl _g_palette

;===================================================================================================================================================
; Public functions
;===================================================================================================================================================
.globl _man_entityForAllMatching

;===================================================================================================================================================
; Public data
;===================================================================================================================================================
.globl _m_functionMemory
.globl _m_signatureMatch

;===================================================================================================================================================
; Manager data
;===================================================================================================================================================
_m_render_tilemap:
    .ds 2


;===================================================================================================================================================
; FUNCION _sys_init_render
; Se encarga de iniciar el color y el modo de video de Amstrad(?)
; NO llega ningun dato
;===================================================================================================================================================
_sys_init_render::
    ;;Destroyed : HL 
    ld  c, #0x00
    call  cpct_setVideoMode_asm
    ;;Destroyed : AF & BC & HL 
    ; ld hl, #0x1410
    ; call  cpct_setPALColour_asm
    ; ;;Destroyed : F & BC & HL  

    ; ld hl, #0x1400
    ; call  cpct_setPALColour_asm
    ;;Destroyed : F & BC & HL  

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm

    ;call _sys_render_renderTileMap  
    ret

;===================================================================================================================================================
; FUNCION _sys_render_update
; Llama a la inversión de control para renderizar los sprites de cada entidad que coincida con e_type_render
; NO llega ningun dato
;===================================================================================================================================================
_sys_render_update::
    ld hl, #_sys_render_renderOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x01   ; e_type_render
    call _man_entityForAllMatching
    ret


;===================================================================================================================================================
; FUNCION _sys_render_renderOneEntity
; Renderiza los sprites de las entidades renderizables
; HL : Entidad a renderizar
;===================================================================================================================================================
_sys_render_renderOneEntity::
    ;; Si es una entidad marcada para destruir no se renderiza
    push hl
    push hl
    ;; Conseguimos la direccion de memoria donde dibujar con las pos de la entity
    ld de, #0xC000

    push hl
    pop ix
    ld  c, e_xpos(ix) 
    ld  b, e_ypos(ix) 

    call cpct_getScreenPtr_asm

    ex de,hl

    pop hl

    ld a, (hl)
    and #0x80    
    jr NZ, eraseSprite

    push de
    ;; Con la direccion de memoria dibujamos el sprite de la entidad
    ld  c, e_width(ix) 
    ld  b, e_heigth(ix) 
    ld  d, e_sprite1(ix) 
    ld  e, e_sprite2(ix) 

    ld h,e
    ld l,d
    pop de
    
    call cpct_drawSprite_asm

    jp endRender
    eraseSprite:
        ;DE has already de V_Memo
        ld  c, e_width(ix) 
        ld  b, e_heigth(ix)
        ld  a, #0x3F

        call cpct_drawSolidBox_asm
    endRender:

    pop hl

    ret


;===================================================================================================================================================
; FUNCION _sys_render_renderTileMap
; Renderiza un tilemap con el tilesheet y el tilemap asignado
; HL : Entidad a renderizar
; 
;===================================================================================================================================================
_sys_render_renderTileMap::
    ld  bc, #0x1914            ; Height & Width of screen in bytes
    ld  de, #0x14              ; Width of the Tilemap in bytes
    ld  hl, #_tileset_0        ; Tileset to draw with
    call cpct_etm_setDrawTilemap4x8_ag_asm
    
    ld hl, #0xC000             ; Video mem. to draw tilemap
    ld de, #_tilemap_01        ; Tilemap to be draw
    call cpct_etm_drawTilemap4x8_ag_asm

    ret