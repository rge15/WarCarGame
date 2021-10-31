.module Game
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/HUD.h.s"
.include "resources/sprites.h.s"
.include "resources/levels.h.s"
.include "man/interruptions.h.s"
.include "assets/music/ArcadeGameSong.h.s"
.include "assets/compress/screenmenu.h.s"
.include "assets/compress/screenend.h.s"
.include "assets/compress/screenvictory.h.s"
 
.include "sys/render.h.s"
.include "sys/ai.h.s"
.include "sys/animator.h.s"
.include "sys/collision.h.s"
.include "sys/input.h.s"
.include "sys/physics.h.s"
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/sprites.h.s"
.include "game.h.s"
.include "resources/tilemaps.h.s"


;===================================================================================================================================================
; Manager data
;===================================================================================================================================================

;;Descripcion : Contador de las interrupciones por la que vamos
_m_irCtr:
   .db 1

; ;;Descripcion : Saber si el jugador ha disparado ya 
_m_playerShot:
   .db #0x01

;;Descripcion : Posición de memoria de la entidad del jugador
_m_playerEntity:
   .dw #0x0000

;;Descripcion : Número de vidas restantes
_m_lifePlayer:
   .ds 1

;;Descripcion : Nivel actual del juego
_m_gameLevel:
   .ds 2

;;Descripcion : Siguiente nivel del juego
_m_nextLevel:
   .ds 2

;;Descripcion : Numero enemigos
_m_enemyCounter:
   .ds 1

; ;;Descripcion : Texto que sale en la pantalla de inicio
; press_str:
   ; .asciz "PRESS ENTER"

; restart_str:
   ; .asciz "PRESS ENTER TO RESTART GAME"

; victory_str:
;    .asciz "Has ganao suprimo, dale a enter pa volver a generar endorcinas"

player_shoot_cooldown_l = 0x10
player_shoot_cooldown_h = 0x40
player_bullet_vel_x = #1
player_bullet_vel_y = #2
;===================================================================================================================================================
; FUNCION _m_game_createInitTemplate   
; ; Crea la entidad con el template indicado
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

   ;; TODO: me salia undefined
   ; ld de, #_GameSong
   ld de, #_gameSong
   call cpct_akp_musicInit_asm

   call _man_int_setIntHandler
   
   ret

;===================================================================================================================================================
; FUNCION waitKeyPressed
; Funcion encargada de esperar a que se pulse de forma única la tecla pasada por registro
; HL = Tecla para pulsar
;===================================================================================================================================================
waitKeyPressed::
   push hl
   call cpct_isKeyPressed_asm
   pop hl
   jr  nz, waitKeyPressed

   loopWaitKey:
      push hl
      call cpct_isKeyPressed_asm
      pop hl
      jr  z, loopWaitKey
   
   ret

;===================================================================================================================================================
; FUNCION _m_game_play   
; Bucle del juego
; NO llega ningun dato
;===================================================================================================================================================
_m_game_play::
;==================
;Pantalla inicio
;==================
startGame:

   call _m_game_StartMenu

   ld hl, #Key_Return
   call waitKeyPressed

   cpctm_clearScreen_asm 0

;Set de variables de juego (Num Vidas / Num Nivel / Num Enemy / Puntuacion)
call _man_game_initGameVar
call _m_HUD_initHUD


;==================
;Carga de Nivel
;==================
restartLevel:
di
SET_TILESET _tileset_00
ld hl, #_m_enemyCounter
ld (hl), #0x00
call _man_entityInit
call _man_game_loadLevel
call _sys_render_renderTileMap
call _m_HUD_renderLifes

ld a, #0x01
call _m_HUD_renderScore

;==================
;Inicio Juego
;==================
ei

   call _man_int_setIntHandler

   testIr:

      ld a, (_man_int_current)
      cp #0
      jr nz, testIr
      cpctm_setBorder_asm HW_GREEN
      call _sys_render_update
      cpctm_setBorder_asm HW_WHITE
      call _man_entityUpdate
      cpctm_setBorder_asm HW_GREEN
      call _sys_physics_update
      cpctm_setBorder_asm HW_RED
      call _sys_input_update
      cpctm_setBorder_asm HW_PINK
      call _sys_animator_update
      cpctm_setBorder_asm HW_YELLOW
      call _sys_ai_update
      cpctm_setBorder_asm HW_BLACK
      call _sys_collision_update
      


      cpctm_setBorder_asm HW_YELLOW
      call _man_game_updateGameStatus
      cpctm_setBorder_asm HW_BLACK

      
      ld a, (_man_int_current)
      cp #0
      jr nz, testIr
      halt
      

   jr testIr
   

   endGame:
   ;TODO : Hacer una pantalla de endgame bonica y cargarla aquí
   ld hl, #_screenend_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

   ld a, #0x00
   call _m_HUD_renderScore
   
   ld hl, #Key_Return
   call waitKeyPressed
   cpctm_clearScreen_asm 0
   jp startGame


   victoryScreen:
   ;TODO : Hacer una pantalla de victoria bonica y cargarla aquí
   cpctm_clearScreen_asm 0

   ld hl, #_screenvictory_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

   ld a, #0x00
   call _m_HUD_renderScore

   
   ld hl, #Key_Return
   call waitKeyPressed
   cpctm_clearScreen_asm 0
   jp startGame

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
; ; Funcion que indica al player que su bala ha sido destruida
; HL : Llega el valor de la entidad
;===================================================================================================================================================
_m_game_bulletDestroyed::
   ld hl, #_m_playerShot
   ld (hl), #0x00
ret

;===================================================================================================================================================
; FUNCION _m_game_playerShot
; ; Funcion que dispara si puede
; NO llega nada
;===================================================================================================================================================
_m_game_playerShot::
   ; ;; Se comprueba si el jugador ha disparado ya
   ; ;; Si el ai_counter del player es != 0 es que está en cooldown (ha disparado)
   GET_ENTITY_POSITION #_m_playerEntity
   push de
   pop ix
   ld a, e_aictr(ix)
   ld b, #0x00
   sub b
   ret NZ ;; Si ha disparado se sale de la etiqueta


   CREATE_ENTITY_FROM_TEMPLATE t_bullet_player
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
      ld e_vx(ix), #player_bullet_vel_x
      ld e_orient(ix), #0x00
      ld a, e_ypos(ix)
      add a, #0x06
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x02
      ld e_xpos(ix), a
      jp stopCheckOrientation

   downOrientation:
      ld e_vy(ix), #player_bullet_vel_y
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
      ld d, #player_bullet_vel_x
      NEGATE_NUMBER d
      ld e_vx(ix), a
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
      ld d, #player_bullet_vel_y
      NEGATE_NUMBER d
      ld e_vy(ix), a
      ld e_orient(ix), #0x03

      ld e_width(ix),  #0x02
      ld e_heigth(ix), #0x08
      
      ld a, e_ypos(ix)
      add a, #0x02
      ld e_ypos(ix), a
      ld a, e_xpos(ix)
      add a, #0x02
      ld e_xpos(ix), a
      
      ld hl, #_hBullet_0
      ld e_sprite2(ix), h
      ld e_sprite1(ix), l
      jp stopCheckOrientation

   stopCheckOrientation:

   ; ; ;; Indicamos que ya ha disparado
   GET_ENTITY_POSITION, #_m_playerEntity
   push de
   pop ix
   ; contador de balas 
   dec e_ai_aux_l(ix)
   jr z, cooldown_high

   ld e_aictr(ix), #player_shoot_cooldown_l
   ret

   cooldown_high:
      ld e_aictr(ix), #player_shoot_cooldown_h
      ld e_ai_aux_l(ix), #player_max_bullets

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


;===================================================================================================================================================
; FUNCION _man_game_initGameVar   
; Función encargada de iniciar/resetear los valores del juego
; NO llega ningun dato
;===================================================================================================================================================
_man_game_initGameVar::

   ld hl, #_m_lifePlayer
   ld (hl), #0x03

   ld hl, #_m_gameLevel 
   ld de, #_level1
   ld (hl), e
   inc hl
   ld (hl), d

   ld hl, #_m_enemyCounter
   ld (hl), #0x00

   ret


;===================================================================================================================================================
; FUNCION _man_game_loadLevel   
; Función encargada de cargar los datos y crear entidades del nivel
; NO llega ningun dato
;===================================================================================================================================================
_man_game_loadLevel::
   ld hl, #_m_gameLevel
   ld e, (hl)
   inc hl
   ld d, (hl)
   ex de, hl ; En HL tengo el inicio del array del nivel asignado
   
   ;En de cargo el tilemap y se lo paso a _m_render_tilemap
   ;y dejo hl apuntando al inicio de las entidades para crear
   ld e, (hl)
   inc hl
   ld d, (hl)
   inc hl
   push hl
   ld hl, #_m_render_tilemap
   ld (hl), e
   inc hl
   ld (hl), d
   pop hl

   inc (hl)
   dec (hl)
   jr Z, endLoadLevel

   loopCreateEntities:      
      ;;Creamos la entidad de la template que pase el nivel
      inc hl
      ld c, (hl)
      inc hl
      ld b, (hl)
      ;CREATE_ENTITY_FROM_TEMPLATE de
      push hl
      call _m_game_createInitTemplate
      push hl
      pop ix
      pop hl

      ;Una vez creada la entidad le ponemos mas coordenadas del nivel
      inc hl
      ld a, (hl)
      ld e_xpos(ix), a
      inc hl
      ld a, (hl)
      ld e_ypos(ix), a

      ld a, e_type(ix)
      dec a
      jr Z, playerCreated ; Si no entra aqui crea un enemigo pq no hay más entityType del level así que sumamos uno a los enemigos

      push hl
      ld hl, #_m_enemyCounter
      inc (hl)
      pop  hl
      ;/=======================
      ;| Al ser enemy tiene más datos que cargar
      ;\=======================
      inc hl
      ld a, (hl)
      ld e_aibeh1(ix), a
      inc hl
      ld a, (hl)
      ld e_aibeh2(ix), a
      inc hl
      ld a, (hl)
      ld e_ai_aux_l(ix), a
      inc hl
      ld a, (hl)
      ld e_ai_aux_h(ix), a
      inc hl
      ld a, (hl)
      ld e_patrol_step_l(ix), a
      inc hl
      ld a, (hl)
      ld e_patrol_step_h(ix), a
      inc hl
      ld a, (hl)
      ld e_inputbeh1(ix), a
      inc hl
      ld a, (hl)
      ld e_inputbeh2(ix), a

      jp checkNextLevelEntity

      playerCreated:
      ; ;Aqui guardamos en _m_playerEntity la direccion de memoria del jugador
      push ix
      pop  de
      push hl     
      ld hl, #_m_playerEntity
      ld (hl), d
      inc hl
      ld (hl), e
      pop  hl
      jp checkNextLevelEntity

      checkNextLevelEntity:
      inc hl
      inc (hl)
      dec (hl)
      jr NZ, loopCreateEntities

   endLoadLevel:
   inc hl
   ex de,hl
   ld hl, #_m_nextLevel
   ld (hl), e
   inc hl
   ld (hl), d

   ret


;===================================================================================================================================================
; FUNCION _man_game_updateGameStatus   
; Función encargada de updatear el estado del juego y nivel
; NO llega ningun dato
;===================================================================================================================================================
_man_game_updateGameStatus::

   ; /
   ; ; | Se checkea si el jugador ha perdido las 3 vidas
   ; \
   ld hl , #_m_lifePlayer
   inc (hl)
   dec (hl)
   jr NZ, checkEnemy
   pop hl
   jp  endGame
   checkEnemy:

   ; /
   ; | Se checkea si el jugador ha acabado con los enemigos y pasa de nivel
   ; \
   ld hl, #_m_enemyCounter
   inc (hl)
   dec (hl)
   jr NZ, dontPassLevel
   ld ix, #_m_nextLevel
   
   ;/
   ;| Llegados a este punto vamos a cargar el siguiente nivel o la pantalla de victoria 
   ;| entonces al hacer jp hay que desacerse del ret de la pila
   ;\
   pop hl 

   ld a, 0(ix)
   ld l, a
   ld a, 1(ix)
   ld h, a

   ld a, (hl)

   inc a
   dec a
   jr NZ, nextLevel
   
   jp victoryScreen
   
   nextLevel:
   ld ix, #_m_nextLevel
   ld hl, #_m_gameLevel
   ld a, (ix)  
   ld (hl), a
   inc hl
   ld a, 1(ix)
   ld (hl), a

   ;; Dibujamos el sprite para pasar de lvl
   LOAD_PNG_TO_SCREEN #0x09, #0x48, #0x3E, #0x2C, #_nextStage

   ld hl, #Key_Return
   call waitKeyPressed
   
   jp restartLevel

   dontPassLevel:
   ret



;===================================================================================================================================================
; FUNCION _man_game_decreasePlayerLife   
; Función encargada de decrementar la vida del jugador
; NO llega ningun dato
;===================================================================================================================================================
_man_game_decreasePlayerLife::
   ld hl, #_m_lifePlayer
   dec (hl)
   call _m_HUD_decreaseLife
   call _m_HUD_renderLifes
   pop hl ;Aqui quitamos lo ultimo de la pila pues no vamos a hacer un ret
   jp restartLevel

   ret


;===================================================================================================================================================
; FUNCION _man_game_decreaseEnemyCounter   
; Función encargada de decrementar el número de enemigos
; NO llega ningun dato
;===================================================================================================================================================
_man_game_decreaseEnemyCounter::
   ld hl, #_m_enemyCounter
   dec (hl)
   call _m_HUD_addPoints
   ld a, #0x01
   call _m_HUD_renderScore
   ret

;===================================================================================================================================================
; FUNCION _m_game_StartMenu   
; Funcion que manda a renderizar la pantalla de inicio del juego
; NO llega ningun dato
; ;===================================================================================================================================================
_m_game_StartMenu::

   ld hl, #_screenmenu_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
ret
