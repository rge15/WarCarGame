.module Game
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/HUD.h.s"
.include "resources/levels.h.s"

 
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


;===================================================================================================================================================
; Manager data
;===================================================================================================================================================

;;Descripcion : Contador de las interrupciones por la que vamos
_m_irCtr:
   .db 6

;;Descripcion : Saber si el jugador ha disparado ya 
_m_playerShot:
   .db #0x00

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

;;Descripcion : Texto que sale en la pantalla de inicio
press_str:
   .asciz "PRESS ENTER"

restart_str:
   .asciz "PRESS ENTER TO RESTART GAME"

victory_str:
   .asciz "Has ganao suprimo, dale a enter pa volver a generar endorcinas"
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
   call _sys_init_render
   ;call  _man_entityInit

   ; CreatePlayer & Save in _m_playerEntity   
   ; CREATE_ENTITY_FROM_TEMPLATE _player_template_e
   ; ex de,hl
   ; ld hl, #_m_playerEntity
   ; ld (hl), d
   ; inc hl
   ; ld (hl), e
   ; ex de,hl
   
   ret



waitKeyPressed::
   push hl
   call cpct_scanKeyboard_f_asm
   pop hl
   push hl
   call cpct_isKeyPressed_asm
   pop hl
   jr  nz, waitKeyPressed

   loopWaitKey:
      push hl
      call cpct_scanKeyboard_f_asm
      pop hl
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
   call _man_game_setManagerIr
;==================
;Pantalla inicio
;==================
startGame:
   di
   ;TODO : Hacer una pantalla de inicio bonica y cargarla aquí
   ld hl, #0x0004
   call cpct_setDrawCharM0_asm
   ld iy, #press_str
   ld hl, #0xC000
   call cpct_drawStringM0_asm
   
   ld hl, #Key_Enter
   call waitKeyPressed

   cpctm_clearScreen_asm 0

;Set de variables de juego (Num Vidas / Num Nivel / Num Enemy / Puntuacion)
call _man_game_initGameVar
call _m_HUD_initHUD
;reset _man_game_interruptionsReset
call _man_game_interruptionsReset


;==================
;Carga de Nivel
;==================
restartLevel:
di
call _man_entityInit
call _man_game_loadLevel
call _sys_render_renderTileMap
call _m_HUD_renderLifes

;==================
;Inicio Juego
;==================
ei
   call _m_HUD_renderScore
   testIr:
      ld a, (_m_irCtr)
      cp #6
      jr nz, testIr
      cpctm_setBorder_asm HW_YELLOW
      call _sys_ai_update
      cpctm_setBorder_asm HW_GREEN
      call _sys_render_update
      cpctm_setBorder_asm HW_WHITE
      call _sys_physics_update
      cpctm_setBorder_asm HW_RED
      call _sys_input_update
      cpctm_setBorder_asm HW_PINK
      call _sys_animator_update
      cpctm_setBorder_asm HW_BLACK
      call _sys_collision_update

      cpctm_setBorder_asm HW_GREEN
      call _man_entityUpdate
      cpctm_setBorder_asm HW_YELLOW
      call _man_game_updateGameStatus
      cpctm_setBorder_asm HW_BLACK





      ;/
      ;|  Codigo completamente auxiliar para checkear el flujo de juego -- START
      ;\
      ld hl, #Key_Enter
      push hl
      call cpct_scanKeyboard_f_asm
      pop hl
      push hl
      call cpct_isKeyPressed_asm
      pop hl
      jr  z, auxJump
         call _man_game_decreasePlayerLife
         ; call _m_HUD_renderScore

      auxJump:
      ;/
      ;|  Codigo completamente auxiliar para checkear el flujo de juego  -- END
      ;\
      ld a, (_m_irCtr)
      cp #6
      jr nz, testIr
      halt
      

   jr testIr
   

   endGame:
   di
   ;TODO : Hacer una pantalla de endgame bonica y cargarla aquí
   cpctm_clearScreen_asm 0
   ld hl, #0x0004
   call cpct_setDrawCharM0_asm
   ld iy, #restart_str
   ld hl, #0xC000
   call cpct_drawStringM0_asm
   
   ld hl, #Key_Enter
   call waitKeyPressed
   cpctm_clearScreen_asm 0
   jp startGame


   victoryScreen:
   di
   ;TODO : Hacer una pantalla de victoria bonica y cargarla aquí
   cpctm_clearScreen_asm 0
   ld hl, #0x0004
   call cpct_setDrawCharM0_asm
   ld iy, #victory_str
   ld hl, #0xC000
   call cpct_drawStringM0_asm
   
   
   ld hl, #Key_Enter
   call waitKeyPressed
   cpctm_clearScreen_asm 0
   jp startGame

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




;===================================================================================================================================================
; FUNCION _man_game_setManagerIr   
; Función encargada de setear la llamada de las interrupciones
; NO llega ningun dato
;===================================================================================================================================================
_man_game_setManagerIr::
   ei
   im 1
   call cpct_waitVSYNC_asm
   halt
   halt
   call cpct_waitVSYNC_asm
   di
   ld a, #0xC3
   ld (#0x38), a
   ld hl, #_man_game_ir
   ld (#0x39), hl
   ei
   ret

;===================================================================================================================================================
; FUNCION _man_game_ir   
; Función a la que llaman las interrpciones
; Encargada de controlar en que interrupcion nos encontramos
; NO llega ningun dato
;===================================================================================================================================================
_man_game_ir::
   ; cpctm_setBorder_asm HW_BLACK
   push af

   ld a, (_m_irCtr)
   dec a
   jr NZ, notReset
      ld a, #6
   notReset:
   ld (_m_irCtr),a

   pop af

   ei
   reti


;===================================================================================================================================================
; FUNCION _man_game_interruptionsReset   
; Función encargada de resetear el contador de interrupciones
; NO llega ningun dato
;===================================================================================================================================================
_man_game_interruptionsReset::
   di
   ld a, #0x06
   ld (_m_irCtr),a
   ei
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
   ld (hl), #0x01          ;!!!!! TODO : Esto empezará en 0 no en 1

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
      jp checkNextLevelEntity

      playerCreated:
      ;Aqui guardamos en _m_playerEntity la direccion de memoria del jugador
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
   ; | Se checkea si el jugador ha perdido las 3 vidas
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

   ld a, (ix)
   ld l, a
   ld a, 1(ix)
   ld h, a

   inc (hl)
   dec (hl)
   jr NZ, nextLevel
   
   jp victoryScreen
   nextLevel:
   ld ix, #_m_nextLevel
   ld hl, #_m_gameLevel
   ld a, 1(ix)
   ld (hl), a
   inc hl
   ld a, (ix)
   ld (hl), a
   
   jp restartLevel

   dontPassLevel:
   ret



;===================================================================================================================================================
; FUNCION _man_game_updateGameStatus   
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
   call _m_HUD_renderScore
   ret
