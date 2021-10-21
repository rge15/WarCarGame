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
; FUNCION _sys_physics_checkKeyboard
; Cambia el valor de la velocidad en x si se pulsa la tecla : O o P
; Y manda la orden de disparar si pulsa Espacio
; HL : LA entidad a updatear
;===================================================================================================================================================
;;_sys_physics_checkKeyboard::
;;    inc hl
;;    inc hl
;;    inc hl
;;    inc hl
;;    inc hl
;;    inc hl
;;    push hl
;;
;;    call cpct_scanKeyboard_f_asm
;;    
;;    ld hl, #0x0404  ;;Key O
;;    call cpct_isKeyPressed_asm
;;    jr NZ, leftPressed
;;
;;    ld hl, #0x0803 ;;Key P
;;    call cpct_isKeyPressed_asm
;;    jr NZ, rightPressed
;;
;;    pop hl
;;    ld (hl), #0x00
;;
;;    jp stopCheckMovement
;;    leftPressed:
;;        pop hl
;;        ld (hl), #0xFF
;;        jp stopCheckMovement
;;    rightPressed:
;;        pop hl
;;        ld (hl), #0x01
;;
;;    stopCheckMovement:
;;
;;    ld hl, #0x8005 ;;Key SpaceBar
;;    call cpct_isKeyPressed_asm
;;    jr Z, dontShoot
;;    call _m_game_playerShot
;;
;;    dontShoot:
;;    ret


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
    cp #0x4c
    jr nc, skip_x_increment
    ld e_xpos(ix),a
    skip_x_increment:

    ;; A = y_pos + y_vel
    ld a,d
    add a,e
    cp #0xc2
    jr nc, skip_x_increment
    ld e_ypos(ix),a
    skip_y_increment:

   ret
