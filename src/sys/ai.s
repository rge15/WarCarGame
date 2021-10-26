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

enemy_max_spawn = 4
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
; El enemigo dispara una bala hacia el jugador, se destruye al llegar
; Genera una entidad _bullet_template y le cambia la posicion a la del enemy
; BC: posicon desde dodne sale
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_shootBulletSeek::
   call _sys_ai_reset_shoot_aictr

   push bc

   CREATE_ENTITY_FROM_TEMPLATE t_bullet_enemy_sp
   ; macro deja posicion en hl
   push hl
   pop ix

   pop bc
   ld e_xpos(ix), b
   ld e_ypos(ix), c

   GET_PLAYER_ENTITY iy
   call _sys_ai_aim_to_entity

   ; call _sys_ai_seekCoords_x
   ; call _sys_ai_seekCoords_y

   ret

;===============================================================================
; Esta bala muere cuando aictr llega a 0
; valores de e_ai_aux_l:
; 0: disapar x
; 1: dispara y
; TODO: hacer una tercera opcion para calcular solo
; Destroy: BC, DE, HL, IX, IY
;===============================================================================
_sys_ai_shootBulletLinear:
   ; viene con IX de entidad que dispara
   call _sys_ai_reset_shoot_aictr
   ld e, e_ai_aux_l(ix)
   push de

   push bc

   CREATE_ENTITY_FROM_TEMPLATE t_bullet_enemy_l
   ; macro deja posicion en hl
   push hl
   pop ix

   inc b
   inc c

   ;; TODO: calcular margen para no collision
   pop bc
   ; ld a, e_heigth(ix)
   ; ld a, #12
   ; add a, c
   ; ld c, a

   ld e_xpos(ix), b
   ld e_ypos(ix), c

   GET_PLAYER_ENTITY iy
   call _sys_ai_aim_to_entity

   pop de
   ld d, #1

   ;; comprobar si es 2
   ld a, #2
   cp e
   call z, _sys_ai_movida

   ;; comprobar si es 0 o 1
   dec e

   jr z, shoot_linear_b_x
   call _sys_ai_seekCoords_y
   ret
   shoot_linear_b_x:
      call _sys_ai_seekCoords_x
   ret

_sys_ai_movida:
   ld d, #1
   call _sys_ai_seekCoords_x
   ld d, #2
   call _sys_ai_seekCoords_y

   ret

;===============================================================================
; Genera un patron de entidades que hay en patrol_step
; BC: posicion donde debe sale
; Destroy: IX, IY, HL, BC
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_spawnEnemy_patrol::
   push bc
   ld hl, #_sys_ai_enemy_count
   inc (hl)

   ;; En el spawner los valores patrol_step son el template de la entidad a spawnear
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ld c, (hl)
   inc hl
   ld b, (hl)
   push ix
   pop iy

   call _m_game_createInitTemplate

   push hl
   pop ix

   pop bc

   ;; posicion del spawner al enemy que spawnea
   ld e_xpos(ix), b
   ld e_ypos(ix), c

   push iy
   pop ix
   call _sys_patrol_next_spawner

   ret

;===============================================================================
; Genera entidades de un template que esta en patrol_step
; BC: posicion donde debe sale
; Destroy: IX, IY, HL, BC
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_spawnEnemy_template:
   push bc
   ld hl, #_sys_ai_enemy_count
   inc (hl)

   ;; En el spawner los valores patrol_step son el template de la entidad a spawnear
   ld b, e_patrol_step_h(ix)
   ld c, e_patrol_step_l(ix)

   call _m_game_createInitTemplate

   push hl
   pop ix

   pop bc

   ;; posicion del spawner al enemy que spawnea
   ld e_xpos(ix), b
   ld e_ypos(ix), c

   ret


_sys_ai_behaviourShield:
   ret

; IX: spawner entity
_sys_ai_decrement_spawner_hp:
   ;; TODO: o lo que sae
   dec e_ai_aux_l(ix)
   push ix
   pop hl
   call z, _man_setEntity4Destroy
   ret

;===============================================================================
; actualizar ai_aim a nueva posicion y guardar en ai_last_aim la de antes del cambio
; IX: entidad que va a hacer el seek
; HL: coordenadas nuveas
;===============================================================================
_sys_ai_setAiAim::

   ld e_ai_aim_x(ix), h
   ld e_ai_aim_y(ix), l
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
;; Shoot Conditions
;;--------------------------------------------------------------------------------

;===============================================================================
; dec e_aictr y si es cero llama a un shoot
; Destroy: BC
;===============================================================================
_sys_ai_shoot_condition_common:
   dec e_aictr(ix)
   ld b, e_xpos(ix)
   ld c, e_ypos(ix)
   ret

;===============================================================================
; dispara bala tipo Linear
; Destroy: BC
;===============================================================================
_sys_ai_shoot_condition_l:
   call _sys_ai_shoot_condition_common

   push ix
   call z, _sys_ai_shootBulletLinear
   pop ix
   ret

;===============================================================================
; dispara bala tipo SeektoPlayer
; Destroy: BC
;===============================================================================
_sys_ai_shoot_condition_sp:
   call _sys_ai_shoot_condition_common

   push ix
   call z, _sys_ai_shootBulletSeek
   pop ix
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

    ;; Compruebo si tiene velocidad
    ;; Se comprueba que la velocidad de la bala no sea 0
    ;; En caso de que lo sea, sea manda a destruir
    ; CHECK_HAS_MOVEMENT e_vx(ix), e_vy(ix)
    ld a, #0x01
    sub b
    jr z, destroyBullet ;; Si no tiene vel. se destruye

    ;; Se comprueba que el contador de mov. restantes de las
    ;; balas sea 0. En ese caso se manda a destruir
    ld a, e_aictr(ix)
    dec a
    jr z, destroyBullet ;; Si es 0 se destruye la bala

    jp stopUpdateBullet

    destroyBullet:
        ;; Volvemos a indicar que no tiene balas y re-seteamos el contador
        push hl
        call _m_game_bulletDestroyed
        pop hl
        call _m_game_destroyEntity


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


;===============================================================================
; actualiza _sys_ai_nextPatrolCoords
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrol::
   push bc
   pop ix

   CHECK_VX_VY_ZERO _sys_patrol_next

   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y

   ret

_sys_ai_behaviourPatrol_shoot_l::
   call _sys_ai_behaviourPatrol
   call _sys_ai_shoot_condition_l

   ret

_sys_ai_behaviourPatrol_shoot_sp::
   call _sys_ai_behaviourPatrol
   call _sys_ai_shoot_condition_sp

   ret


;===============================================================================
; Patron con posiones relativas a xy, actualiza _sys_ai_nextPatrolCoords
; !!! Necesario poner en e_ai_aux mismas posiciones que en xpos ypos
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrolRelative::
   push bc
   pop ix
   ;; TODO: ver como poner el origen solo una vez 
   push ix
   pop iy
   dec e_aictr(ix)
   ; call z, _sys_patrol_set_relative_origin
   ; ld e_aictr(ix), #2

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #1
   call _sys_ai_seekCoords_x
   ld d, #2
   call _sys_ai_seekCoords_y

   ret

;; TODO: tipo de shoot_linear y posicion relativa comparten aictr !!
;===============================================================================
; actualiza _sys_ai_nextPatrolCoords
; de momoento shoot_linear
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrolRelative_shoot:
   call _sys_ai_behaviourPatrolRelative
   call _sys_ai_shoot_condition_l
   ret

_sys_ai_behaviourSpawner_template::
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_template
   ret

_sys_ai_behaviourSpawner_patrol::
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_patrol
   ret

;; TODO: hacer estructura de datos para generar segun templates con un invalid al finla
;; TODO: comprobar que tengas 3 vidas y si tiene 0 4destroy
_sys_ai_beh_spawner_commmon::
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
   ret

;===============================================================================
; Esta bala muere cuado aictr llega a 0
;===============================================================================
_sys_ai_behaviourBulletLinear::
   push bc
   pop ix

   dec e_aictr(ix)
   jr z, has_to_destroy_bullet
   ret

   has_to_destroy_bullet:
      push ix
      pop hl
      call _man_setEntity4Destroy
      ; call _sys_ai_reset_bullet_aictr
   ret

;===============================================================================
; Esta bala muere cuado llega al ai_aim
;===============================================================================
_sys_ai_behaviourBulletSeektoPlayer::
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   ;; TODO: mejorar porque en algunos casos puede fallar
   ld a, e_ai_aim_x(ix)
   ld d, e_ai_aim_y(ix)
   ; add a, e_ai_aim_y(ix)
   add a
   or a

   jr nz, skip_set_coords

   call _sys_ai_aim_to_entity
   skip_set_coords:

   ; TODO[Edu]: con velociada mayor a veces no llega y se queda
   ; una entidad sin destruir y ya peta un poco todo
   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_seekCoords_y

   ; dec e_aictr(ix)
   ; jr z, set_zero_vel
   ; ret
   ; set_zero_vel:
   ;    ld e_vx(ix), #0
   ;    ld e_vy(ix), #0

   push ix
   pop hl
   CHECK_VX_VY_ZERO _man_setEntity4Destroy

   ;; Compruebo si tiene velocidad
   ;; Se comprueba que la velocidad de la bala no sea 0
   ;; En caso de que lo sea, sea manda a destruir
   ; CHECK_HAS_MOVEMENT e_vx(ix), e_vy(ix)
   ; ld a, #0x01
   ; sub b
   ; jr z, destroyBullet2 ;; Si no tiene vel. se destruye
   ; ret
   ; destroyBullet2:
   ;    push hl
   ;    call _m_game_bulletDestroyed
   ;    pop hl
   ;    call _m_game_destroyEntity
   ;

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

_sys_ai_reset_shoot_aictr:
   ld e_aictr(ix), #t_shoot_timer_enemy
   ret

_sys_ai_reset_bullet_aictr:
   ld e_aictr(ix), #t_bullet_timer_enemy
   ret

;; TODO: si pos inicial 1 peta no se
;===============================================================================
; Sigue al jugador cambiando y se para a hacer un patron
;===============================================================================
_sys_ai_behaviourSeekAndPatrol::
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity


   dec e_aictr(ix)
   call z, _sys_patrol_set_relative_origin

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ; ld a, e_aictr(ix)
   ; ld h, #1
   ; cp h
   ;
   ; ld b, e_xpos(ix)
   ; ld c, e_ypos(ix)
   ;
   ; push ix
   ; call z, _sys_ai_shootBullet
   ; pop ix

   ld d, #1
   call _sys_ai_seekCoords_x
   ld d, #2
   call _sys_ai_seekCoords_y

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
