.module Input
;===================================================================================================================================================
; Includes
;===================================================================================================================================================
.include "resources/macros.h.s" ;;Info : Hay un macro todo wapo para ver si se pulsan la tecla indicada
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "sys/input.h.s"


;===================================================================================================================================================
; Keyboard  TODO : Intentar hacerlo con el joystick sería la polla lironda
;===================================================================================================================================================
;; TODO: esto no pillo para que sirve aqui
.globl Key_D
.globl Key_A
.globl Key_W
.globl Key_S
.globl Key_Space

;===================================================================================================================================================
; FUNCION _sys_input_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_input_update::
    ld hl, #_sys_input_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x04  ; e_type_input
    call _man_entityForAllMatching
    ret

;===================================================================================================================================================
; FUNCION _sys_input_updateOneEntity
; Updatea cada una de las entidades que tiene componente input
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_input_updateOneEntity::    
    
    push hl
    pop ix

    ; call cpct_scanKeyboard_f_asm ;;;;IMPORTANTE ESTO SE TIENE QUE QUDAR COMENTADO NO DESCOMENTAR (Preguntar a Rodro)
    
    ld hl, #0x0807  ;;Key W
    call cpct_isKeyPressed_asm
    jr NZ, upPressed

    ld hl, #0x2008  ;;Key A
    call cpct_isKeyPressed_asm
    jr NZ, leftPressed

    ld hl, #0x1007  ;;Key S
    call cpct_isKeyPressed_asm
    jr NZ, downPressed

    ld hl, #0x2007  ;;Key D
    call cpct_isKeyPressed_asm
    jr NZ, rightPressed

    ld hl, #0x8005  ;;Key Space
    call cpct_isKeyPressed_asm
    jr NZ, spacePressed

    ;EN caso de no pulsar nada se queda quieto
    ld a, #0x00
    ld e_vx(ix), a
    ld e_vy(ix), a

    jp stopCheckMovement

    upPressed:
        ;; Cambiamos la posicion
        ld a, #0xFE
        ;; Meto dos dec para que avance byte y no pixels
        ld e_vy(ix), a
        ld a, #0x00
        ld e_vx(ix), a
        ;; Actualizamos la orientación
        ld a, #0x03
        ld e_orient(ix), a
        jp stopCheckMovement

    leftPressed:
        ;; Cambiamos la posicion
        ld a, #0xFF
        ; dec a
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a
        ;; Actualizamos la orientación
        ld a, #0x02
        ld e_orient(ix), a
        jp stopCheckMovement

    downPressed:
        ;; Cambiamos la posicion
        ld a, #0x02
        ld e_vy(ix), a
        ld a, #0x00
        ld e_vx(ix), a
        ;; Actualizamos la orientación
        ld a, #0x01
        ld e_orient(ix), a
        jp stopCheckMovement

    rightPressed:
        ;; Cambiamos la posicion
        ld a, #0x01
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a
        ;; Actualizamos la orientación
        ld a, #0x00
        ld e_orient(ix), a
        jp stopCheckMovement

    spacePressed:
        call _m_game_playerShot
        jp stopCheckMovement

    stopCheckMovement:
   ret
