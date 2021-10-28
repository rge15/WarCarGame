.include "sys/ai.h.s"

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


;;--------------------------------------------------------------------------------
;; BULLET
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

;===============================================================================
; Esta bala muere cuado aictr llega a 0
;===============================================================================
_sys_ai_behaviourBulletLinear::
   push bc
   pop ix

   ; call _sys_ai_check_tile_collision_from_ai
   ;; si colisiona
   ; CHECK_VX_VY_ZERO_JR has_to_destroy_bullet

   dec e_aictr(ix)
   jr z, has_to_destroy_bullet
   ret


   has_to_destroy_bullet:
      push ix
      pop hl
      call _m_game_destroyEntity
      ; call _man_setEntity4Destroy
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
   call _sys_ai_seekCoords_y

   call _sys_ai_check_tile_collision_from_ai

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


;;--------------------------------------------------------------------------------
;; AI MOVE BEHAVIOURS
;;--------------------------------------------------------------------------------

enemy_no_move:
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
   ; el orden importa para la colision no se
   call _sys_ai_seekCoords_y
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

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
   ; dec e_aictr(ix)
   ; call z, _sys_patrol_set_relative_origin
   ; ld e_aictr(ix), #2

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #2
   call _sys_ai_seekCoords_y
   ld d, #1
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

   ret

;; TODO: si pos inicial 1 peta no se
;===============================================================================
; Sigue al jugador cambiando y se para a hacer un patron
; Usa el aictr
;===============================================================================
_sys_ai_behaviourSeekAndPatrol::
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   dec e_ai_aux_l(ix)
   call z, _sys_patrol_set_relative_origin

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ld d, #2
   call _sys_ai_seekCoords_y

   call _sys_ai_check_tile_collision_from_ai

   ret

;; FOLLOW PLAYER IN AXIS

; require e_ai_aux_l
_sys_ai_beh_follow_player_x:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_x
   ret

; require e_ai_aux_l
_sys_ai_beh_follow_player_y:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_y
   ret

_sys_ai_beh_follow_player_xy_rand:
   call _sys_ai_beh_follow_player
   ; dec e_ai_aux_l(ix)
   jr z, xy_rand_go
   ret
   xy_rand_go:
      call _sys_ai_random_0_1
      dec a
      jr z, xy_rand_go_x
      jr xy_rand_go_y
      ret
      xy_rand_go_x:
         call do_follow_player_x
         ret
      xy_rand_go_y:
         call do_follow_player_y
         ret
      ; jp z, do_follow_player_x
      ; jp nz, do_follow_player_y
      ; ld e_ai_aux_l(ix), #test_time_fo2
      ret

; deja en z la condicion
_sys_ai_beh_follow_player:
   push bc
   pop ix
   GET_PLAYER_ENTITY iy
   call _sys_ai_aim_to_entity
   dec e_ai_aux_l(ix)
   ret

do_follow_player_x:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ret

do_follow_player_y:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #2
   call _sys_ai_seekCoords_y
   call _sys_ai_check_tile_collision_from_ai
   ret

; IX: entidad
_sys_ai_check_tile_collision_from_ai:
   push ix
   pop hl
   ;; haciendo un buen uso de nuestro maravilloso ECS
   ;; porque sino en la siguiente itereacion se mete en el tilemap
   call _sys_collision_updateOneEntity
   ret


;===============================================================================
; SPAWNER
;===============================================================================

_sys_ai_behaviourSpawner_template::
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_template
   ret

_sys_ai_behaviourSpawner_plist::
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_plist
   ret

;; TODO: hacer estructura de datos para generar segun templates con un invalid al finla
_sys_ai_beh_spawner_commmon::
   push bc
   pop ix

   ;; TODO: menor tiempo de spawn
   ; ld h, e_orient(ix)
   ; ld l, e_aictr(ix)
   ; dec hl
   dec e_aictr(ix)
   ld b, e_xpos(ix)
   ld c, e_ypos(ix)

   jr z, check_if_spawn_enemy
   ret
   check_if_spawn_enemy:
      ld d, #enemy_max_spawn
      ld a, (_m_enemyCounter)
      cp d
   ret


;;--------------------------------------------------------------------------------
;; AI SHOOT BEHAVIOURS
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
; dispara bala tipo SeektoPlayer
; Destroy: BC
;===============================================================================
;; TODO: revisar !!
_sys_ai_shoot_condition_sp:
   call _sys_ai_shoot_condition_common

   push ix
   call z, _sys_ai_shootBulletSeek
   pop ix
   ret



_sys_ai_beh_shoot_x:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_x
   ret

;; fast version
_sys_ai_beh_shoot_x_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_x_f
   ret

_sys_ai_beh_shoot_y:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_y
   ret

;; fast version
_sys_ai_beh_shoot_y_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_y_f
   ret

; no diagonal x y un poco cuando quiere
_sys_ai_beh_shoot_xy_rand:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_xy_rand
   ret

;;--------------------------------------------------------------------------------
;; PRIVATE FUNCS
;;--------------------------------------------------------------------------------

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

