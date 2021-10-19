.module Ai

.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/macros.h.s"
.include "resources/macros.s"
.include "sys/physics.h.s"
.include "sys/ai.h.s"

;===================================================================================================================================================
; Manager data
;===================================================================================================================================================
_sys_ai_behaviourMemory::
    .ds 2

_sys_ai_directionMemory::
    .dw #0x0000

;; xy coords
;; aprox max: 4ec5                 por el render, depende de la dimension tambien
_sys_ai_seek_to_pos::
   ; .dw #0x4e00
   ; .dw #0xcccc
   .dw #0x2020

_sys_ai_nextPatrolCoords::
   .ds 1

_sys_ai_patrol_pos:
   .dw #0x3000
   .dw #0x2000
   .dw #0x2020
   .dw #0x0050


_sys_ai_init::
   ld hl, #_sys_ai_patrol_pos
   ld (_sys_ai_nextPatrolCoords), hl


_sys_ai_inc_next_patrol::
   ld bc, (_sys_ai_nextPatrolCoords)
   ld hl, #2
   add hl, bc
   ld (_sys_ai_nextPatrolCoords), hl

   ret

;===================================================================================================================================================
; FUNCION _sys_ai_update
; Llama a la inversión de control para updatear el comportamiento de 
; las entidades que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_ai_update::
    ld hl, #_sys_ai_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x0A ;;  e_type_movable | e_type_ai
    call _man_entityForAllMatching
    ret

;===================================================================================================================================================
; FUNCION _sys_ai_updateOneEntity
; Busca el comportamiento de la entidad y lo ejecuta 
; HL : LA entidad a updatear
;   - Sale BC que es la entidad a updatear
;===================================================================================================================================================
_sys_ai_updateOneEntity::    

    ld b, h
    ld c, l
    push hl
    pop ix
    ld d, e_aibeh2(ix)
    ld e, e_aibeh1(ix)

    ld (#_sys_ai_directionMemory), de

    ld hl, (#_sys_ai_directionMemory)
    jp (hl)    

    ret


;===================================================================================================================================================
; FUNCION _sys_ai_behaviourBullet
; Updatea el contador de existencia de la bala y la destruye si hace falta
; BC : Entidad a updatear
;===================================================================================================================================================
_sys_ai_behaviourBullet::    
    ld h, b
    ld l, c
    push hl
    pop ix

    ld a, e_anctr(ix)
    dec a
    jr z, destroyBullet ;; Si es 0 se destruye la bala

    jp stopUpdateBullet

    destroyBullet:
        ;; Volvemos a indicar que no tiene balas y re-seteamos el contador
        push hl
        call _m_game_destroyEntity
        pop hl
        call _m_game_bulletDestroyed


    stopUpdateBullet:
    ld e_anctr(ix), a
ret


;===================================================================================================================================================
; FUNCION _sys_ai_behaviourEnemy
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_ai_behaviourEnemy::

   push bc
   pop ix

   ;; TODO: con la velocidad va regular
   ld d, #1
   ld hl, (_sys_ai_seek_to_pos)

   ; call cpct_getRandom_mxor_u8_asm
   ;; TODO: entiendo que hay que comproba en cada iteracion no hay otra forma???
   ; calcular las posiciones desde un principio
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y

   ret


; por parametro el array a las posociones a las que tiene que hacer patrool
; beh patrol
; beh x right left
; beh y up down
;===============================================================================
; actualiza _sys_ai_nextPatrolCoords
; Destroy: HL
;===============================================================================
_sys_ai_updateNextPatrolCoords::
   ; ld de, (_sys_ai_nextPatrolCoords)
   ; inc de
   ; inc de
   ; ld (_sys_ai_nextPatrolCoords), de
   ;
   ; ; ld #_sys_ai_nextPatrolCoords, de
   ; ; ld h, d
   ; ; ld l, e

   ld hl, (_sys_ai_nextPatrolCoords)
   call _sys_ai_setAiAim
   call _sys_ai_inc_next_patrol
   ret

;; TODO: de momento con array aux
_sys_ai_behaviourPatrol::
   push bc
   pop ix

   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y

   ;; TODO: salta cuando y lleag a 0
   call z, _sys_ai_updateNextPatrolCoords
   ret

;===============================================================================
; actualizar ai_aim a nueva posicion y guardar en ai_last_aim la de antes del cambio
; IX: entidad que va a hacer el seek
; HL: coordenadas nuveas
;===============================================================================
_sys_ai_setAiAim::

   ld b, e_ai_aim_x(ix)
   ld c, e_ai_aim_y(ix)

   ld e_ai_aim_x(ix), h
   ld e_ai_aim_y(ix), l

   ld e_ai_last_aim_x(ix), b
   ld e_ai_last_aim_y(ix), c
   ret


;===============================================================================
; Moverse en el eje X entre posicon inicial y e_ai_aim_x
;
;===============================================================================
_sys_ai_behaviourAutoMoveIn_x::
   push bc
   pop ix

   ld d, #1
   call _sys_ai_seekCoords_x

   ld h, e_ai_last_aim_x(ix)
   ld l, e_ai_last_aim_y(ix)
   call z, _sys_ai_setAiAim
   ret

;===============================================================================
; Moverse en el eje Y entre posicon inicial y e_ai_aim_y
;
;===============================================================================
_sys_ai_behaviourAutoMoveIn_y::
   push bc
   pop ix

   ld d, #1
   call _sys_ai_seekCoords_y

   ld h, e_ai_last_aim_x(ix)
   ld l, e_ai_last_aim_y(ix)
   call z, _sys_ai_setAiAim
   ret

; poner en el counter el valor que pasa hasta disparar una baga 

;===============================================================================
; Seek a unas coordenadas, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
; H: coordenada x
; D: velocidad
;===============================================================================
_sys_ai_seekCoords_x::
   ld a, e_ai_aim_x(ix)

   ld b, e_xpos(ix)
   cp b
   ;; b:actual, a: destino
   jr z, set_zero_x
   jr c, set_negative_x
   jr set_positive_x

   set_negative_x:
      NEGATE_NUMBER d
      ld e_vx(ix), a
      ret

   set_positive_x:
      ld e_vx(ix), d
      ret

   set_zero_x:
      ld e_vx(ix), #0
      ret

   ret

;===============================================================================
; Seek a unas coordenadas, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
; L: coordenada y
; D: velocidad
;===============================================================================
_sys_ai_seekCoords_y::
   ld a, e_ai_aim_y(ix)

   ld b, e_ypos(ix)
   cp b
   ;; b:actual, a: destino
   jr z, set_zero_y
   jr c, set_negative_y
   jr set_positive_y

   set_negative_y:
      NEGATE_NUMBER d
      ld e_vy(ix), a
      ret

   set_positive_y:
      ld e_vy(ix), d
      ret

   set_zero_y:
      ld e_vy(ix), #0
      ;; TODO: change beh
      ; ld hl, #3020
      ; ld (_sys_ai_seek_to_pos), hl
      ; ld hl, #_sys_ai_seek_to_pos
      ret



;===================================================================================================================================================
; FUNCION _sys_ai_behaviourLeftRight
; Si llega a alguno de los bordes establece su velocidad en la direccion contraria
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_ai_behaviourLeftRight::
    ld a, #0x50
    inc hl
    inc hl
    ld b,(hl) ;; b = x
    inc hl
    inc hl
    sub (hl)  ;; a = right bound
    inc hl
    inc hl 
    inc b
    dec b
    jr Z, leftPart

    ld c,a
    ld a,b
    ld b,c

    sub b
    jr Z, rightPart

    jp exitUpdate
    leftPart:
        ld (hl), #0x01
        jp exitUpdate

    rightPart:
        ld (hl), #0xFF

    exitUpdate:
    ret



;===================================================================================================================================================
; FUNCION _sys_ai_behaviourAutoDestroy
; Destruye la entidad pasado el tiempo del contador de la IA
; HL : Entidad a updatear
;===================================================================================================================================================

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;Esto lo dejo aquí pero dudo que lo usemos
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

_sys_ai_behaviourAutoDestroy::
    ld a,#0x0C
    searchAICounter:
        inc hl
        dec a
        jr NZ, searchAICounter

    dec (hl)
    jr NZ, dontDestroy

    ld a,#0x0C
    searchType:
        dec hl
        dec a
        jr NZ, searchType

    call _m_game_destroyEntity

    dontDestroy:

    ret
