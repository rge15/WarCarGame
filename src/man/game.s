.module Game
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"

;; TODO:
; .include "sys/render.h.s"
.globl _sys_init_render
.globl _sys_render_update

.include "sys/ai.h.s"
.include "sys/animator.h.s"
.include "sys/input.h.s"
.include "sys/physics.h.s"
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/sprites.h.s"
.include "game.h.s"


;===================================================================================================================================================
; Manager data
;===================================================================================================================================================
;;Descripcion : Saber si el jugador ha disparado ya 
_m_playerShot:
   .db #0x00

;;Descripcion : Posición de memoria de la entidad del jugador
_m_playerEntity:
   .dw #0x0000

;===================================================================================================================================================
; FUNCION _m_game_createInitTemplate   
; Crea la entidad con el template indicado
; BC : Valor de template a crear
;===================================================================================================================================================
_m_game_createInitTemplate::
   call _man_createEntity
   push hl
   ex de,hl
   ld h, b
   ld l, c
   ld b,#0x00
   LOAD_VARIABLE_IN_REGISTER _m_sizeOfEntity, C
   call cpct_memcpy_asm
   pop hl
   ret


;===================================================================================================================================================
; FUNCION _m_game_init   
; Inicializa el juego y sus entidades
; NO llega ningun dato
;===================================================================================================================================================
_m_game_init::
   call  _sys_init_render
   call  _man_entityInit

   ; CreatePlayer & Save in _m_playerEntity   
   CREATE_ENTITY_FROM_TEMPLATE _player_template_e 
   ex de,hl
   ld hl, #_m_playerEntity
   ld (hl), d
   inc hl
   ld (hl), e
   ex de,hl
ret


;===================================================================================================================================================
; FUNCION _m_game_play   
; Bucle del juego
; NO llega ningun dato
;===================================================================================================================================================
_m_game_play::
   updates:
      call _sys_ai_update
      call _sys_input_update
      call _sys_physics_update
      call _sys_animator_update
      call _sys_render_update
      
      call _man_entityUpdate
      call cpct_waitVSYNC_asm
      ; call _wait
   jr updates

ret

;===================================================================================================================================================
; FUNCION _m_game_createEnemy   
; Crea un enemigo
; NO llega ningun dato
;===================================================================================================================================================
_m_game_createEnemy::
   ;Create Enemy
   ;ld bc, #_enemy_template_e   
   ;call _m_game_createInitTemplate   
   
   ret


;===================================================================================================================================================
; FUNCION _m_game_destroyEntity
; Funcion que destruye la entidad indicada
; HL : Llega el valor de la entidad
;===================================================================================================================================================
_m_game_destroyEntity::
   call _man_setEntity4Destroy
   ret


;===================================================================================================================================================
; FUNCION _m_game_bulletDestroyed
; Funcion que indica al player que su bala ha sido destruida
; HL : Llega el valor de la entidad
;===================================================================================================================================================
_m_game_bulletDestroyed::
   ld hl, #_m_playerShot
   ld (hl), #0x00
ret


;===================================================================================================================================================
; FUNCION _m_game_playerShot
; Funcion que dispara si puede
; NO llega nada
;===================================================================================================================================================
_m_game_playerShot::
   ;; Se comprueba si el jugador ha disparado ya
   ld hl,#_m_playerShot
   dec (hl)
   inc (hl)
   ret NZ


   CREATE_ENTITY_FROM_TEMPLATE _bullet_template_e
   ;; HL es la primera pos del array de la bala
   ex de, hl   ;; de = hl
   push de     ;; guardamos la primera pos del array de la bala

   ;; Sacamos la pos del player en el array de entidades
   ld hl, #_m_playerEntity
   ld d, (hl)
   inc hl
   ld e, (hl)
   ;; de ahora es la primera pos. del array del player

   ex de, hl
   
   ;; Guardamos en registros los datos del player
   push hl
   pop ix

   ld b, e_xpos(ix) 
   ld c, e_ypos(ix)

   ld a, e_orient(ix)

   ;; Sacamos la posicion de la bala en el array
   pop de
   ex de,hl
   
   push af  ;; Guardamos la orientación del tanque en la pila

   ;; Actualizamos su pos
   push hl
   pop ix
   ld a, b
   ld e_xpos(ix), a
   ld a, c
   ld e_ypos(ix), a

   ;; ----- ACTUALIZAMOS LA ORIENTACIÓN DE LA BALA -----
   pop de ;; "d" es la orientación del tanque
   ;; A lo mejor no hace falta
   ;; Uso aqui la pila para poder posicionarme en el array (bala)
   push hl
   pop ix

   ld a, #0x00 ;; Right
   sub d
   jr z, righOrientation ;; Si es 0 va a la derecha

   ld a, #0x01 ;; Down
   sub d
   jr z, downOrientation ;; Si es 0 va a la abajo

   ld a, #0x02 ;; Left
   sub d
   jr z, leftOrientation ;; Si es 0 va a la izquierda

   ld a, #0x03 ;; Up
   sub d
   jr z, upOrientation ;; Si es 0 va a la arriba

   jp stopCheckOrientation

   righOrientation:
      ld e_vx(ix), #0x01
      ld e_orient(ix), #0x00
      ld a, e_ypos(ix)
      add a, #0x06
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x02
      ld e_xpos(ix), a
      jp stopCheckOrientation

   downOrientation:
      ld e_vy(ix), #0x02
      ld e_orient(ix), #0x01

      ld e_width(ix),  #0x02
      ld e_heigth(ix), #0x08
      
      ld a, e_ypos(ix)
      add a, #0x2
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x02
      ld e_xpos(ix), a

      ld hl, #_hBullet_1
      ld e_sprite2(ix), h
      ld e_sprite1(ix), l
      jp stopCheckOrientation

   leftOrientation:
      ld e_vx(ix), #0xFF
      ld e_orient(ix), #0x02

      ld a, e_ypos(ix)
      add a, #0x06
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x01
      ld e_xpos(ix), a

      ld hl, #_vBullet_0
      ld e_sprite2(ix), h
      ld e_sprite1(ix), l

      jp stopCheckOrientation

   upOrientation:
      ld e_vy(ix), #0xFE
      ld e_orient(ix), #0x03

      ld e_width(ix),  #0x02
      ld e_heigth(ix), #0x08
      
      ld a, e_ypos(ix)
      add a, #0x01
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x02
      ld e_xpos(ix), a
      
      ld hl, #_hBullet_0
      ld e_sprite2(ix), h
      ld e_sprite1(ix), l
      jp stopCheckOrientation

   stopCheckOrientation:

   ;; Indicamos que ya ha disparado
   ld hl,#_m_playerShot
   ld (hl), #0x01
   ret   

;===================================================================================================================================================
; FUNCION _wait   
; Espera un tiempo antes de realizar otra iteracion del bucle de juego
; NO llega ningun dato
;===================================================================================================================================================

_wait::
   ld h, #0x05
      waitLoop:
         ld b, #0x02
         call cpct_waitHalts_asm
         call cpct_waitVSYNC_asm
         dec h
         jr NZ, waitLoop
   ret
