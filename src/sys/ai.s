.module Ai

.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/macros.s"
.include "sys/physics.h.s"
.include "sys/patrol.h.s"
.include "sys/ai.h.s"

;===================================================================================================================================================
; Manager data
;===================================================================================================================================================

_sys_ai_directionMemory::
    .dw #0x0000

enemy_max_spawn = 2
_sys_ai_enemy_count: .db 0


;;--------------------------------------------------------------------------------
;; AI FUNCTIONS
;;--------------------------------------------------------------------------------

_sys_ai_init::
   ; ld hl, #_sys_ai_patrol_pos
   ; ld (_sys_ai_nextPatrolCoords), hl
   ;
   ; ld hl, #_sys_ai_patrol_count
   ; ld (hl), #0
   ret


;===============================================================================
; Actualiza ai_beh
; HL: direction of new behaviour
;===============================================================================
_sys_ai_changeBevaviour::
   ld hl, #_sys_ai_behaviourAutoMoveIn_x
   ld e_aibeh1(ix), l
   ld e_aibeh2(ix), h
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


;===============================================================================
; El enemigo dispara una bala hacia el jugador
; Genera una entidad _bullet_template y le cambia la posicion a la del enemy
; BC: posicon desde dodne sale
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_shootBullet::
   ;; TODO: es para resetear el valor, ver donde meterlo mejor
   ld e_aictr(ix), #0x30

   push bc

   ;; este template tiene el behaviour para hacer seek al player
   CREATE_ENTITY_FROM_TEMPLATE _bullet_template_e2
   ; macro deja posicion en hl
   push hl
   pop ix

   pop bc
   ld e_xpos(ix), b
   ld e_ypos(ix), c

   ret

;===============================================================================
; Genera una entidad _bullet_template y le cambia la posicion a la del enemy
; BC: posicion donde debe sale
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_spawnEnemy::
   push bc
   ld hl, #_sys_ai_enemy_count
   inc (hl)

   ;; TODO[Edu]: pasar por paraetro el template para diferentes enemigos
   ld bc, #_enemy_template_e
   call _m_game_createInitTemplate


   push hl
   pop ix

   pop bc

   ld e_xpos(ix), b
   ld a, c
   add #20
   ; ld e_ypos(ix), c
   ld e_ypos(ix), a

   ;; TODO[Edu]: segun el template del enemy habria que cambiar
   ; call _sys_ai_updateNextPatrolCoords

   ret

;===============================================================================
; actualizar ai_aim a nueva posicion y guardar en ai_last_aim la de antes del cambio
; IX: entidad que va a hacer el seek
; HL: coordenadas nuveas
;===============================================================================
_sys_ai_setAiAim::

   ; ld b, e_ai_aim_x(ix)
   ; ld c, e_ai_aim_y(ix)

   ld e_ai_aim_x(ix), h
   ld e_ai_aim_y(ix), l

   ; ld e_ai_aux_l(ix), b
   ; ld e_ai_aux_h(ix), c
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



;;--------------------------------------------------------------------------------
;; AI BEHAVIOURS
;;--------------------------------------------------------------------------------

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


;; TODO: de momento con array aux
;===============================================================================
; actualiza _sys_ai_nextPatrolCoords
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrol::
   push bc
   pop ix

   ;; guardar el registro f para compara si en seekCoords_x y seekCoords_y se ha llegado 
   ;; a la posicon final y se ha puesto la velocidad a 0
   ;; no entiendo como es que funciona jakdjakjj en serio ??
   ;; vale despues hay que meter una mascara de bits vaya movida
   ;; la mascara de bits tiene que ser 0x40 porque es el flag z
   ;; depues hay que compara que los flags sean iguales y que sean 0x40, en los otros casos no
   ; queremos hacer update de las patrol coords

   CHECK_VX_VY_ZERO _sys_patrol_next

   ld d, #1
   call _sys_ai_seekCoords_x
   ld d, #1
   call _sys_ai_seekCoords_y

   ; dec e_aictr(ix)
   ; ld b, e_xpos(ix)
   ; ld c, e_ypos(ix)
   ;
   ; push ix
   ; call z, _sys_ai_shootBullet
   ; pop ix

   ret


;; TODO: hacer con posicion relativa pasada por parametro
;===============================================================================
; Moverse en el eje X entre e_ai_aim_x y e_ai_aux_l
;; TODO: se podria hacer guardando la posicon inicial y comprobando cada vez pero es mucho coste?
; tambien dispara bala a player segun el tiempo aictr
;
;===============================================================================
_sys_ai_behaviourAutoMoveIn_x::
   push bc
   pop ix

   ld d, #1
   call _sys_ai_seekCoords_x

   ld h, e_ai_aux_l(ix)
   ld l, e_ai_aux_h(ix)
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
; Moverse en el eje Y entre posicon e_ai_aim_y y e_ai_aux_h
;; TODO: se podria hacer guardando la posicon inicial y comprobando cada vez pero es mucho coste?
;===============================================================================
_sys_ai_behaviourAutoMoveIn_y::
   push bc
   pop ix

   ld d, #1
   call _sys_ai_seekCoords_y

   ld h, e_ai_aux_l(ix)
   ld l, e_ai_aux_h(ix)
   call z, _sys_ai_setAiAim
   ret

;; TODO: hacer estructura de datos para generar segun templates con un invalid al finla
_sys_ai_behaviourSpawner::
   push bc
   pop ix

   dec e_aictr(ix)
   ld b, e_xpos(ix)
   ld c, e_ypos(ix)

   ; call z, _sys_ai_spawnEnemy
   jr z, check_if_spawn_enemy
   ret
   check_if_spawn_enemy:
      ld d, #enemy_max_spawn
      ld a, (_sys_ai_enemy_count)
      cp d
      call c, _sys_ai_spawnEnemy
   ret


_sys_ai_behaviourBulletSeektoPlayer::
   push bc
   pop ix

   GET_PLAYER_ENTITY iy


   ;; TODO: mejorar porque en algunos casos puede fallar
   ld a, e_ai_aim_x(ix)
   ld d, e_ai_aim_y(ix)
   ; add a, e_ai_aim_y(ix)
   add a
   or a

   jr nz, skip_set_coords

   ld a, e_xpos(iy)
   ld e_ai_aim_x(ix), a

   ld a, e_ypos(iy)
   ld e_ai_aim_y(ix), a

   skip_set_coords:

   ;; TODO[Edu]: con velociada mayor a veces no llega y se queda
   ; una entidad sin destruir y ya peta un poco todo
   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y
   push ix
   pop hl
   CHECK_VX_VY_ZERO _man_setEntity4Destroy

   ret

;===============================================================================
; Poner el aim de una entidad en la pos de otro
; IX: changes aim
; IY: entity to set as aim
;===============================================================================
_sys_ai_aim_to_entity:
   ld a, e_xpos(iy)
   ld e_ai_aim_x(ix), a

   ld a, e_ypos(iy)
   ld e_ai_aim_y(ix), a
   ret

_sys_ai_behaviourSeekAndPatrol::
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   dec e_aictr(ix)

   push ix
   pop ix
   call z, _sys_patrol_set_relative_origin

   CHECK_VX_VY_ZERO _sys_patrol_next_relative


   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y

   ret

;; TODO: no actulizar el xpos ypos en cada iteracion porque te sigue a cualquier pos
; _sys_ai_behaviourBulletIn_x::
;    push bc
;    pop ix
;
;    GET_PLAYER_ENTITY iy
;
;
;    ;; TODO: si el aim es 0,0 no va supongo<?
;    ld a, e_ai_aim_x(ix)
;    add a, e_ai_aim_y(ix)
;    or a
;    jr nz, skip_set_coords
;
;    ld a, e_xpos(iy)
;    ld e_ai_aim_x(ix), a
;
;    ld a, e_ypos(iy)
;    ld e_ai_aim_y(ix), a
;
;    skip_set_coords:
;
;    ;; TODO[Edu]: con velociada mayor a veces no llega y se queda
;    ; una entidad sin destruir y ya peta un poco todo
;    ld d, #1
;    call _sys_ai_seekCoords_x
;    call _sys_ai_seekCoords_y
;    push ix
;    pop hl
;    CHECK_VX_VY_ZERO _man_setEntity4Destroy
;
;    ret
;
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
