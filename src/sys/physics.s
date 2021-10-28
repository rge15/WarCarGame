.module Physics
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "physics.h.s"

;===================================================================================================================================================
; FUNCION _sys_physics_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_physics_update::
    ld hl, #_sys_physics_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x02  ; e_type_movable
    call _man_entityForAllMatching
    ret


;===================================================================================================================================================
; FUNCION _sys_physics_updateOneEntity
; Updatea las posiciones de las entidades en funcion de 
; los valores de sus velocidades
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_physics_updateOneEntity::    
    push hl
    pop ix

    ;; BD = x_pos y_pos
    ld  b, e_xpos(ix) 
    ld  d, e_ypos(ix) 

    ;; CE = x_vel y_vel
    ld  c, e_vx(ix) 
    ld  e, e_vy(ix) 

    ;; A = x_pos + x_vel
    ld a,b
    add a,c
    ld e_xpos(ix),a

    ;; A = y_pos + y_vel
    ld a,d
    add a,e
    ld e_ypos(ix),a
    
   ret
