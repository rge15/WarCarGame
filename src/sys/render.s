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
.include "man/HUD.h.s"


;===================================================================================================================================================
; Assets
;===================================================================================================================================================
;.globl _tilemap_01
;.globl _tileset_00
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

_m_render_tileset:
    .ds 2


;===================================================================================================================================================
; FUNCION _sys_init_render
; Se encarga de iniciar el color y el modo de video de Amstrad(?)
; NO llega ningun dato
;===================================================================================================================================================
_sys_init_render::
    ld  c, #0x00
    call  cpct_setVideoMode_asm

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm

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

    push hl
    pop ix
    ;Aqui vemos si hay q borrar el prevptr
    ld a, #0x21
    and e_type(ix)
    call NZ, _sys_render_erasePrevPtr

    ;; Conseguimos la direccion de memoria donde dibujar con las pos de la entity
    ld de, #0xC000

    
    ld  c, e_xpos(ix) 
    ld  b, e_ypos(ix) 

    call cpct_getScreenPtr_asm

    ex de,hl

    ld e_prevptr1(ix),d
    ld e_prevptr2(ix),e

    dontSavePrevPtr:
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

        jp endRender

    endRender:

    pop hl

    ret

_sys_render_erasePrevPtr::
        ld  a, e_prevptr1(ix)
        dec a
        inc a
        ret Z
        ld  d, e_prevptr1(ix)
        ld  e, e_prevptr2(ix)
        ; dec de
        ; inc de
        or e
        ret Z
        ld  c, e_width(ix) 
        ld  b, e_heigth(ix)
        ld  a, #0x3F

        call cpct_drawSolidBox_asm
    ret


;===================================================================================================================================================
; FUNCION _sys_render_renderTileMap
; Renderiza un tilemap con el tilesheet y el tilemap asignado
; HL : Entidad a renderizar
; 
;===================================================================================================================================================
_sys_render_renderTileMap::

    ld  hl, #_m_render_tileset  ; Tileset to draw with
    ld e, (hl)
    inc hl
    ld d, (hl)
    ex de, hl
    ld  bc, #0x1914             ; Height & Width of screen in bytes
    ld  de, #0x14               ; Width of the Tilemap in bytes
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld  hl, #_m_render_tilemap  ; Tileset to draw with
    ld e, (hl)
    inc hl
    ld d, (hl)
    ld hl, #0xC000             ; Video mem. to draw tilemap
    call cpct_etm_drawTilemap4x8_ag_asm

    ret


;===================================================================================================================================================
; FUNCION _sys_render_renderHUDLifes
; Función encargada renderizar las vidaz en funcion de su estado
; HL : Llega el inicio del array de vidas
;===================================================================================================================================================
_sys_render_renderHUDLifes::
    ld a, #0x03
    renderHUDLife:
    push af
    
    inc (hl)
    dec (hl)
    push hl
    jr Z , setEmptyLife
    jr NZ , setLife
    
    setEmptyLife:
    ld hl, #_HUDLife_1
    jp startDraw
    setLife:
    ld hl, #_HUDLife_0
    startDraw:
    pop de
    push de
    push hl
    ex de, hl
    inc hl
    ld e, (hl)
    inc hl
    ld d, (hl)
    inc hl
    ld hl, #_m_HUD_lifeHeight
    ld b, (hl)
    ld hl, #_m_HUD_lifeWidth
    ld c, (hl)
    pop hl     

    call cpct_drawSprite_asm
    pop hl
    inc hl
    inc hl
    inc hl
    pop af
    dec a
    jr NZ, renderHUDLife


    ret

_sys_render_renderHUDScore::

    inc a
    dec a
    jr Z, value0
    dec a
    jr Z, value1
    dec a
    jr Z, value2
    dec a
    jr Z, value3
    dec a
    jr Z, value4
    dec a
    jr Z, value5
    dec a
    jr Z, value6
    dec a
    jr Z, value7
    dec a
    jr Z, value8
    dec a
    jr Z, value9
    ; jr NZ, dontRender

    value0:
    ld hl, #_spriteScore_00
    jp render

    value1:
    ld hl, #_spriteScore_01
    jp render

    value2:
    ld hl, #_spriteScore_02
    jp render

    value3:
    ld hl, #_spriteScore_03
    jp render

    value4:
    ld hl, #_spriteScore_04
    jp render

    value5:
    ld hl, #_spriteScore_05
    jp render

    value6:
    ld hl, #_spriteScore_06
    jp render

    value7:
    ld hl, #_spriteScore_07
    jp render

    value8:
    ld hl, #_spriteScore_08
    jp render

    value9:
    ld hl, #_spriteScore_09

    render:
    call cpct_drawSprite_asm

    dontRender:

    ret


_sys_render_level_counter:

   ld de, #0xC000
   ld c, #0x22
   ld b, #0x34
   call cpct_getScreenPtr_asm

   ex de, hl

   ; ld hl, #_spriteScore_00
   ; ld c, #4
   ; ld b, #8

   ld hl, #_numback
   ld c, #12
   ld b, #16

   call cpct_drawSprite_asm

   ret

;===================================================================================================================================================
; FUNCION _m_game_StartMenu   
; Funcion que renderiza los items de los menus que le llegan
;       - HL: Puntero a dirección de memoria de pantalla
;       - DE: El sprite a dinujar
;       - B: Width
;       - C: Height
;===================================================================================================================================================
_renderMenuItems::
    ex de, hl
    call cpct_drawSprite_asm

ret
