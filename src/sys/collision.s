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
.include "resources/macros.s"

;===================================================================================================================================================
; FUNCION _sys_collision_update
; Llama a la inversión de control para updatear las colisiones
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
; Comprueba si la entidad colisiona con alguna tile y en ese caso quita su velocidad
; HL : Entidad a updatear
;===================================================================================================================================================
;; Si la orientacion es hacia abajo, que compruebe la suma hacia abajo
;; Hacer macro que se gun que orientación, devuelva en D 
;; - #0xFF (comprueba parte arriba sprite) - #0x10 (comprueba abajo sprite)

_sys_collision_updateOneEntity::    
    push hl
    pop ix
    ;; tx = x/4
    ;; ty = y/8
    ;; tw = tilemap-width (0x14, 20)
    ;; p = tilemap + ty * tw + tx
    
    ;; A = y  
    CHECK_ORIENTATION_PLAYER_FOR_COLLISION_Y e_orient(ix) e_heigth(ix)
    ld  a, e_ypos(ix)
    add d   ;; Sumo el alto de mi personaje 10
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
    CHECK_ORIENTATION_PLAYER_FOR_COLLISION_X e_orient(ix) e_width(ix)
    ld  a, e_xpos(ix)
    add d
    srl a ;; | A = tx(x/4)
    srl a ;; |

    add_hl_a    ;; HL = ty * tw + tx
    ld  de, #_tilemap_01
    add hl, de

    ;; HL = tilemap + ty * tw + tx
    ;; Ya tenemos a hl apuntando al byte que queríamos
    ld  a, (hl) ;; A ld a, #0x03
    and #0b11111110

    ret nz
    ;; COLISION DETECTADA
    
    ;; Dependiendo de la colision del axis setea a 0 la vel. 
    CHECK_ORIENTATION_AXIS_PLAYER e_orient(ix)
    inc a
    dec a
    jp z, _stop_x_axis
    ld  e_vy(ix), #0    ;; Para a la entidad
    jp _is_none_axis

    _stop_x_axis:
    ld  e_vx(ix), #0    ;; Para a la entidad

    _is_none_axis:

   ret
