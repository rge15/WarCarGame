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

;; ptr to next coord
_sys_ai_nextPatrolCoords::
   .dw #0x0000

_sys_ai_patrol_pos:
   ; .dw #0x0102
   ; .dw #0x0304
   ; .dw #0x0506
   ; .dw #0x0708
   .dw #0x0000
   .dw #0x0040
   .dw #0x4040
   .dw #0x4000

_sys_ai_patrol_size:
   .db #4

_sys_ai_patrol_count:
   .db #0

_sys_ai_init::
   ld hl, #_sys_ai_patrol_pos
   ld (_sys_ai_nextPatrolCoords), hl

   ld hl, #_sys_ai_patrol_count
   ld (hl), #0x0000

_sys_ai_resetPatrolInitial::
   ret


_sys_ai_inc_next_patrol::
   ld bc, (_sys_ai_nextPatrolCoords)
   ld hl, #2
   add hl, bc

   ld (_sys_ai_nextPatrolCoords), hl

   ;; check if last
   ld hl, (_sys_ai_patrol_count)
   inc l
   ld (_sys_ai_patrol_count), hl

   ld a, (_sys_ai_patrol_size)
   cp l
   ;; TODO: acutalizar si ia tiene mas inicializadores
   call z, _sys_ai_init

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

    ld a, e_aictr(ix)
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
    ld e_aictr(ix), a
ret

;===============================================================================
; El enemigo dispara una bala hacia el jugador
; Genera una entidad _bullet_template y le cambia la posicion a la del enemy
; BC: posicon desde dodne sale
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_shootBullet::
   ;; TODO: es para resetear el valor, ver donde meterlo mejor
   ; ld e_aictr(ix), #0x16

   push bc

   ;; este template tiene el behaviour para hacer seek al player
   CREATE_ENTITY_FROM_TEMPLATE _bullet_template_e2
   ; macro deja posicion en hl
   push hl
   pop ix

   pop bc
   ld e_xpos(ix), b
   ld e_ypos(ix), c

   ;; TODO: destruir la bala
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

   ld hl, (_sys_ai_nextPatrolCoords)
   ld d, (hl)
   inc hl
   ld e, (hl)
   ex de, hl

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

   ;; TODO: arreglar, tiene que ser cuando X y Y son 0, ahora hace cuando el ultimo es 0
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
; Moverse en el eje X entre e_ai_aim_x y e_ai_last_aim_x
;; TODO: se podria hacer guardando la posicon inicial y comprobando cada vez pero es mucho coste?
; tambien dispara bala a player segun el tiempo aictr
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

   ; ld a, e_aictr(ix)
   ; dec a
   ; ld e_aictr(ix), a
   dec e_aictr(ix)
   ld b, e_xpos(ix)
   ld c, e_ypos(ix)
   call z, _sys_ai_shootBullet
   ret

;===============================================================================
; Moverse en el eje Y entre posicon e_ai_aim_y y e_ai_last_aim_y
;; TODO: se podria hacer guardando la posicon inicial y comprobando cada vez pero es mucho coste?
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

;; TODO: no actulizar el xpos ypos en cada iteracion porque te sigue a cualquier pos
_sys_ai_behaviourSeektoPlayer::
   push bc
   pop ix

   ;; TODO: usar _m_playerEntity
   ; ld bc, #_m_playerEntity
   ; ld iy, (bc)
   ld iy, #_m_entities

   ;; TODO: si el aim es 0,0 no va supongo<?
   ld a, e_ai_aim_x(ix)
   add a, e_ai_aim_y(ix)
   or a
   jr nz, skip_set_coords

   ld a, e_xpos(iy)
   ld e_ai_aim_x(ix), a

   ld a, e_ypos(iy)
   ld e_ai_aim_y(ix), a

   skip_set_coords:

   ld d, #2
   call _sys_ai_seekCoords_x
   ld d, #4
   call _sys_ai_seekCoords_y

   ret

; poner en el counter el valor que pasa hasta disparar una baga 

;===============================================================================
; Seek a unas coordenadas segun e_ai_aim_x, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
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
; Seek a unas coordenadas segun e_ai_aim_y, usando CP(con unsigned en principio)
; IX: entidad que va a hacer el seek
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
