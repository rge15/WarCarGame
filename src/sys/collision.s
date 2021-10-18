.module Collision
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "cpctelera.h.s"
.include "collision.h.s"
.include "assets/maps/map01.h.s"

;===================================================================================================================================================
; FUNCION _sys_collision_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_collision_update::
    ld hl, #_sys_collision_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x21  ; e_type_movable | e_cmp_collider = #0x21
    call _man_entityForAllMatching
    ret

;===================================================================================================================================================
; FUNCION _sys_collision_updateOneEntity
; Updatea las posiciones de las entidades en funcion de 
; los valores de sus velocidades
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_collision_updateOneEntity::    
    push hl
    pop ix
    ;; tx = x/4
    ;; ty = y/8
    ;; tw = tilemap-width (0x14, 20)
    ;; p = tilemap + ty * tw + tx
    
    ;; A = y  
    ld  a, e_ypos(ix)
    add #0x0F     ;; Sumo el alto de mi personaje
    ;; Desplazo a la derecha 3 veces el bit 
    ;;(Si deplazo a la derecha 1 bit divido entre 2)
    ;; A = ty (y/8)
    srl a ;; |
    srl a ;; | A = A/8
    srl a ;; |
    ;; HL = A (HL = ty)
    ld  h, #0
    ld  l, a
    ;; HL = 20*HL
    add hl, hl  ;; HL = 2*ty
    add hl, hl  ;; HL = 4*ty
    ld  d, h    ;; | DE = 4*ty
    ld  e, l    ;; |
    add hl, hl  ;; HL = 8*ty
    add hl, hl  ;; HL = 16*ty
    add hl, de  ;; HL = 20*ty

    ;; A = x
    ld  a, e_xpos(ix)
    srl a ;; | A = tx(x/4)
    srl a ;; |

    add_hl_a    ;; HL = ty * tw + tx
    ld  de, #_tilemap_01
    add hl, de

    ;; HL = tilemap + ty * tw + tx
    ;; Ya tenemos a hl apuntando al byte que queríamos
    ld  a, (hl) ;; A = indice del tile debajo de mi pj
    and #0b11111110

    ret nz
    ;; COLISION DETECTADA

    ld  e_vy(ix), #0    ;; Para a la entidad
    
   ret
