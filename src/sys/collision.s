.module Collision
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "cpctelera.h.s"
.include "collision.h.s"
.include "ai.h.s"
.include "assets/maps/map01.h.s"
.include "resources/macros.s"

;===================================================================================================================================================
; Manager data   
;===================================================================================================================================================
;; Punto 1 de la colision de la entidad
_sys_entityColisionPos1_X::
    .ds 1

_sys_entityColisionPos1_Y::
    .ds 1

;; Punto 2 de la colision de la entidad
_sys_entityColisionPos2_X::
    .ds 1

_sys_entityColisionPos2_Y::
    .ds 1

_sys_entityArray::
    .dw #0x0000

_sys_numEntities::
    .ds 1

_sys_sizeOfEntity::
    .ds 1    
;===================================================================================================================================================
; FUNCION _sys_collision_update
; Llama a varias etiquetas para updatear las colisiones
; NO llega ningun dato
;===================================================================================================================================================
_sys_collision_update::

    call _sys_checkColissionBwEntities
    call _sys_checkColissionBwTile

    ret


;===================================================================================================================================================
; FUNCION _sys_checkColissionBwEntities
; Setea las variables para comprobar la colision entre todas las entidades
; NO llega ningun dato
;===================================================================================================================================================
_sys_checkColissionBwEntities::
    call _man_getEntityArray ;; Devuelve en hl
    ld (#_sys_entityArray), hl
    call _man_getNumEntities ;; Devuelve en hl
    ld a, (hl)
    ld (#_sys_numEntities), a
    call _man_getSizeOfEntity ;; Devuelve en hl
    ld a, (hl)
    ld (#_sys_sizeOfEntity), a
    call _sys_collision_updateMultiple
ret


;===================================================================================================================================================
; FUNCION _sys_checkColissionBwTile
; Comprueba la colision de los type colisionables con el tile del mapa
; NO llega ningun dato
;===================================================================================================================================================
_sys_checkColissionBwTile::
    ld hl, #_sys_collision_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x21  ; e_type_movable | e_cmp_collider = #0x21
    call _man_entityForAllMatching
ret


;===================================================================================================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba la colision entre todas las entidades
; NO llega ningun dato
;===================================================================================================================================================
_sys_collision_updateMultiple::
    ;; Guardamos en "ix" la entidad base a updatear
    ld hl, (#_sys_entityArray)
    push hl
    pop ix
    ld d, h
    ld e, l
    jp _next_iy

    _next_ix:
        ;; NO PONGO EL MACRO PORQUE NO ME DEJA EL DESGRACIADO
        ld a, (#_sys_sizeOfEntity)
        _loop:
            inc hl
            dec a
            jr nz, _loop

    push hl
    pop ix
    ld d, h
    ld e, l

    ld a, (de)
    inc a
    dec a
    ret z

    ;; Se pasa a la siguiente entidad para iy
    _next_iy:
    INCREMENT_REGISTER de, (#_sys_sizeOfEntity)

    ld a, (de)
    inc a
    dec a
    jr z, _jumpNext

    push de
    pop iy

    ld a, e_type(iy)

    call _sys_collisionEntity_check
    jr c, _no_collision

    _collision:
    ;============
    ; ix = chequeas con todos
    ; iy = si colisiona con ix
    ; para cada tipo definir un comportamiento de colisión con el resto de tipos
    ; if ix = type a
    ; ver que type es iy y ejecutar comportamiento
    ;====ix_entity=========|||===============behaviour iy_entity================================================================================
    ; (DONE / TODO) e_type_player         = si choca con cualquier cosa que no sea una bala propia, se resta una vida al jugador y punto
    ; (DONE / TODO) e_type_enemy          = si choca con una bullet_player se destruye así mismo y la bala tambien se destruye
    ; (DONE / TODO) e_type_enemy_spawner  = si choca con una bullet_player se resta una vida así mismo y la bala tambien se destruye
    ; (DONE / TODO) e_type_bullet                = si choca con un enemy se destruye así mismo, al enemy tambien se destruye, si es un spawner se le resta una vida al spawner, 
    ;                                si es una enemyBullet se eliminan las 2
    ; (DONE) e_type_enemyBullet           = si es una bullet se destruyen los dos y au
    ;===========================================================================================================================================
    push de
    push hl

    ld a, #0x01
    and e_type(ix)
    call NZ, playerCollisionBehaviour

    ld a, #0x04
    and e_type(ix)
    call NZ, bulletCollisionBehaviour

    ld a, #0x08
    and e_type(ix)
    call NZ, enemyCollisionBehaviour

    ld a, #0x10
    and e_type(ix)
    call NZ, enemySpawnerCollisionBehaviour

    ld a, #0x20
    and e_type(ix)
    call NZ, enemyBulletCollisionBehaviour
    
    pop hl
    pop de


    ; ld a, #0xFF
    ; ld (0xC000), a
    ;jr _jumpNext
    jr _next_iy
    
    _no_collision:
    ld a, #0x00
    ld (0xC000), a
    jr _next_iy

    _jumpNext:
        jp _next_ix
ret

;===================================================================================================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba se las entidades realmente colisionan
; NO llega ningun dato
;===================================================================================================================================================
_sys_collisionEntity_check::
    
    ld a, e_xpos(ix)
    add e_width(ix)
    sub e_xpos(iy)
    ret c

    ld a, e_xpos(iy)
    add e_width(iy)
    sub e_xpos(ix)
    ret c


    ld a, e_ypos(ix)
    add e_heigth(ix)
    sub e_ypos(iy)
    ret c

    ld a, e_ypos(iy)
    add e_heigth(iy)
    sub e_ypos(ix)
    ret c

ret

;===================================================================================================================================================
; FUNCION _sys_collision_updateOneEntity
; Comprueba según la orientación si está colisionando con una tile
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_collision_updateOneEntity::
    push hl
    pop ix


    ld d, h ;; | Guardamos hl en de 
    ld e, l ;; |

    ;; Establecemos los dos puntos de colisiones del sprite
    ld a, e_orient(ix)
    call _sys_setEntityCollisionPoints
    ex de, hl

    push hl
    pop ix
    ;; Chekeamos que el primer punto no esté en el tile que no toca
    ld a, (#_sys_entityColisionPos1_Y)
    ld b, a
    ld a, (#_sys_entityColisionPos1_X)
    ld c, a
    call _sys_checkTilePosition

    ;; Chekeamos que el segundo punto no esté en el tile que no toca
    ld a, (#_sys_entityColisionPos2_Y)
    ld b, a
    ld a, (#_sys_entityColisionPos2_X)
    ld c, a
    call _sys_checkTilePosition

ret

;===================================================================================================================================================
; FUNCION _sys_checkTilePosition
; Comprueba si el punto que le han pasado colisiona con la tile y en ese caso updatea su velocidad
; BC : El punto en el que se va a comprobar la colision
;===================================================================================================================================================
_sys_checkTilePosition::
    ld  a, e_ypos(ix)
    add b ;; Sumo el alto de mi personaje 10
    ;; Desplazo a la derecha 3 veces el bit 
    ;;(Si deplazo a la derecha 1 bit divido entre 2)
    ;; A = ty (y/8)
    srl a ;; |
    srl a ;; | A = A/8
    srl a ;; |
    ;; HL = A (HL = ty)
    ld  h, #0
    ld  l, a
    ;; HL = 20*HL
    add hl, hl  ;; HL = 2*ty
    add hl, hl  ;; HL = 4*ty
    ld  d, h    ;; | DE = 4*ty
    ld  e, l    ;; |
    add hl, hl  ;; HL = 8*ty
    add hl, hl  ;; HL = 16*ty
    add hl, de  ;; HL = 20*ty

    ;; A = x
    ld  a, e_xpos(ix)
    add c
    srl a ;; | A = tx(x/4)
    srl a ;; |

    add_hl_a    ;; HL = ty * tw + tx
    ld  de, #_tilemap_01
    add hl, de

    ;; HL = tilemap + ty * tw + tx
    ;; Ya tenemos a hl apuntando al byte que queríamos
    ld  a, (hl) ;; A ld a, #0x03
    and #0b11111110

      ret nz
    ;; COLISION DETECTADA
    
    ;; Dependiendo de la colision del axis setea a 0 la vel.
    CHECK_ORIENTATION_AXIS_PLAYER e_orient(ix)
    inc a
    dec a
    jp z, _stop_x_axis
    ld  e_vy(ix), #0    ;; Para a la entidad
    jp _is_none_axis

    _stop_x_axis:
    ld  e_vx(ix), #0    ;; Para a la entidad

    _is_none_axis:
      ld a, #e_type_enemy_bullet

      cp e_type(ix)
      jr z, is_type_enemy_bullet

      ld a, #e_type_enemy
      cp e_type(ix)
      jr z, is_type_enemy

      is_type_enemy_bullet:
         push ix
         pop hl
         ; ld  e_vx(ix), #0
         ; ld  e_vy(ix), #0
         ; no se xq antes sin esto funcionaba pero ok supongo
         ld e_aictr(ix), #1

         ; call _man_setEntity4Destroy
         ret
      is_type_enemy:
         push ix
         pop hl
         ld  e_vx(ix), #0
         ld  e_vy(ix), #0
         ret

   ret


;===================================================================================================================================================
; FUNCION _sys_setEntityCollisionPoints
; Según la orientación de la entidad. Setea los puntos a comprobar en las variables
; BC : El punto en el que se va a comprobar la colision
;===================================================================================================================================================
_sys_setEntityCollisionPoints::
    ld c, a

    ;; RIGHT = 0
    ld b, #0x00
    sub b
    jr z, _setCollisionRight
    ld a, c

    ;; DOWN = 1
    ld b, #0x01
    sub b
    jr z, _setCollisionDown
    ld a, c

    ;; LEFT = 2
    ld b, #0x02
    sub b
    jr z, _setCollisionLeft
    ld a, c

    ;; UP = 3
    ld b, #0x03
    sub b
    jr z, _setCollisionUp

    _setCollisionRight:
        ;; Establecemos los parametros a usar
        ;; que ayudaran a saber en que tile se encuentra
        ;; el punto

        ;; Punto 1
        ld a, e_width(ix)
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0x00
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0x00 - 1  ;; El "- 1" es para que pueda pegarse mas a la pared
        add e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionDown:
        ;; Punto 1
        ld a, #0x00
        ld (#_sys_entityColisionPos1_X), a

        ld a, e_heigth(ix)
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0x00 - 1
        add e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionLeft:
        ;; Punto 1
        ld a, #0xFF
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0x00
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0xFF
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0x00 - 1
        add e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionUp:
        ;; Punto 1
        ld a, #0x00
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0xFF
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0x00 - 1
        add e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0xFF
        ld (#_sys_entityColisionPos2_Y), a

    _stopCheckingCollisionPoints:

ret


;===================================================================================================================================================
; FUNCION playerCollisionBehaviour
; Comportamiento de las colisiones del jugador
; NO llega nada
;===================================================================================================================================================
playerCollisionBehaviour::
    ld a, #0x04
    and e_type(iy)
    call Z, _man_game_decreasePlayerLife
    ret



;===================================================================================================================================================
; FUNCION enemyCollisionBehaviour
; Comportamiento de las colisiones del enemigo
; NO llega nada
;===================================================================================================================================================
enemyCollisionBehaviour::
    ld a, #0x04
    and e_type(iy)
    ret Z

    call destroyPairOfEntities

    call _man_game_decreaseEnemyCounter
    
    call _m_game_bulletDestroyed

    ret


;===================================================================================================================================================
; FUNCION destroyPairOfEntities
; Método encargado las dos entidades que colisionan
; NO llega nada
;===================================================================================================================================================
destroyPairOfEntities::
    push iy
    pop hl 
    call _m_game_destroyEntity

    push ix
    pop hl 
    call _m_game_destroyEntity  
    
    ret


;===================================================================================================================================================
; FUNCION enemySpawnerCollisionBehaviour
; Método encargado de las colisiones del enemySpawner
; NO llega nada
;===================================================================================================================================================
enemySpawnerCollisionBehaviour::

    ld a, #0x04
    and e_type(iy)
    ret Z

    call _sys_ai_decrement_spawner_hp
    push iy
    pop hl
    call _m_game_destroyEntity
    call _m_game_bulletDestroyed

    ret


; e_type_bullet                = si choca con un enemy se destruye así mismo, al enemy tambien se destruye, si es un spawner se le resta una vida al spawner,
;                                Y SE BORRA ASÍ MISMO
;                                si es una enemyBullet se eliminan las 2

;===================================================================================================================================================
; FUNCION bulletCollisionBehaviour
; Método encargado de las colisiones del bullet
; NO llega nada
;===================================================================================================================================================
bulletCollisionBehaviour::
    ld a, #0x08
    and e_type(iy)
    jr NZ, destroyEnity
    ld a, #0x20
    and e_type(iy)
    jr NZ, destroyEnity
    ld a, #0x10
    and e_type(iy)
    jr NZ, decreaseLifeSpawner

    ret
    decreaseLifeSpawner:
    ;;Llamar método resta via al spawner
       call _sys_ai_decrement_spawner_hp
    
    push ix
    pop hl 
    call _m_game_destroyEntity
    call _m_game_bulletDestroyed
    
    ret
    destroyEnity:

    ld a, #0x08
    and e_type(iy)
    call NZ, _man_game_decreaseEnemyCounter

    call destroyPairOfEntities 

    ret



;===================================================================================================================================================
; FUNCION enemyBulletCollisionBehaviour
; Método encargado de las colisiones del enemyBullet
; NO llega nada
;===================================================================================================================================================
enemyBulletCollisionBehaviour::
    ld a, #0x04
    and e_type(iy)
    ret Z

    call _m_game_bulletDestroyed

    call destroyPairOfEntities

    ret
