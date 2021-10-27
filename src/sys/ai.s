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
.include "resources/sprites.h.s"
.include "collision.h.s"

;===================================================================================================================================================
; Manager data
;===================================================================================================================================================

_sys_ai_directionMemory::
    .dw #0x0000

;; TODO: mejorar igual
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

    ; ex de, hl
    ld (#_sys_ai_directionMemory), de
    ld hl, (#_sys_ai_directionMemory)

    ld de, #ai_back_from_jp
    push de
    jp (hl)    

    ai_back_from_jp:

   ;; TODO: lasdsos 0000
   ld e, e_inputbeh1(ix)
   ld d, e_inputbeh2(ix)

   ld (#_sys_ai_directionMemory), de
   ld hl, (#_sys_ai_directionMemory)

   ld a, d
   or a
   jr nz, low_no_zero_zero
   jr low_is_zero_zero
   low_no_zero_zero:
      ld a, e
      or a
      jr nz, exe_shoot_beh
   low_is_zero_zero:
   ret

   exe_shoot_beh:
      jp (hl)

    ret

;;--------------------------------------------------------------------------------
;; FUNCTIONS OF BEHAVIOURS
;;--------------------------------------------------------------------------------

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

;; Crea la bala, le pone la posicion del enemigo que la dispara
;; y le pone en ai_aim las coords del player
_sys_ai_shoot_bullet_l_common:
   call _sys_ai_reset_shoot_aictr
   push bc

   CREATE_ENTITY_FROM_TEMPLATE t_bullet_enemy_l
   push hl
   pop ix

   inc b
   inc c

   ;; TODO: calcular margen para centro
   pop bc

   ld e_xpos(ix), b
   ld e_ypos(ix), c

   GET_PLAYER_ENTITY iy
   call _sys_ai_aim_to_entity

   ret

_sys_ai_shoot_bullet_l_x:
   call _sys_ai_shoot_bullet_l_common
   ld d, #1
   call _sys_ai_seekCoords_x
   ret

_sys_ai_shoot_bullet_l_y:
   call _sys_ai_shoot_bullet_l_common
   ld d, #2
   call _sys_ai_seekCoords_y
   ret

_sys_ai_shoot_bullet_l_xy_rand:
   call _sys_ai_shoot_bullet_l_common
   ld h, e_xpos(ix)
   ld l, e_ypos(ix)

   call _sys_ai_random_0_1
   dec a

   jr z, shoot_on_y_axis
   jr shoot_on_x_axis
   ret

   shoot_on_x_axis:
      ld d, #1
      call _sys_ai_seekCoords_x
      ret
   shoot_on_y_axis:
      ld d, #1
      call _sys_ai_seekCoords_y

   ret

;===============================================================================
; Esta bala muere cuando aictr llega a 0

;===============================================================================
; Genera un patron de entidades que hay en patrol_step
; BC: posicion donde debe sale
; Destroy: IX, IY, HL, BC
;; TODO[Edu]: no sale del centro de la entidad
;===============================================================================
_sys_ai_spawnEnemy_plist::
   push bc
   ld hl, #_m_enemyCounter
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
   ld hl, #_m_enemyCounter
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
   ; call _sys_patrol_set_relative_origin

   ret


_sys_ai_behaviourShield:
   ret

;===============================================================================
; Usamos orient para hp spawner ya que nunca se va a mover
; IX: spawner entity
;===============================================================================
_sys_ai_decrement_spawner_hp:
   ;; TODO: cargar animacion para dar feedback de menor vida
   dec e_orient(ix)

   push ix
   pop hl
   jr z, _sys_ai_spawner_has_to_die

   ld a, #2
   cp e_orient(ix)
   jr z, spawner_has_2_hp

   ld a, #1
   cp e_orient(ix)
   jr z, spawner_has_1_hp

   ;; Esto no es muy ECS pero bueno
   spawner_has_2_hp:
      ld e_sprite1(ix), #_sprite_enemy01
      ret

   spawner_has_1_hp:
      ld e_sprite1(ix), #_sprite_player02
      ret

   ret

_sys_ai_spawner_has_to_die:
   call _m_game_destroyEntity
   call _man_game_decreaseEnemyCounter
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
      ld e_orient(ix), #2
      ret

   set_positive_x:
      ld e_vx(ix), d
      ld e_orient(ix), #0
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
      ld e_orient(ix), #3
      ret

   set_positive_y:
      ld e_vy(ix), d
      ld e_orient(ix), #1
      ret

   set_zero_y:
      ld e_vy(ix), #0
      ret

;;--------------------------------------------------------------------------------
;; Shoot Conditions
;;--------------------------------------------------------------------------------



;; Destroy: L
;; Return: A 1 or 0
_sys_ai_random_0_1:
   ld a, r
   ld l, a
   ld a, #62
   cp l
   jr c, prandom_zero
   ld a, #0
   ret
   prandom_zero:
      ld a, #1
   ret



