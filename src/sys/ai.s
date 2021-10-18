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

; poner en el counter el valor que pasa hasta disparar una baga 

_sys_ai_generateRandom::
   call cpct_getRandom_mxor_u8_asm
   ret
;===============================================================================
; Seek a unas coordenadas, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
; H: coordenada x
;===============================================================================
_sys_ai_seekCoords_x::
   ld a, h

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

;===============================================================================
; Seek a unas coordenadas, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
; L: coordenada y
; D: velocidad
;===============================================================================
_sys_ai_seekCoords_y::
   ld a, l

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
