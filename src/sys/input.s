;===================================================================================================================================================
; CPCTelera functions
;===================================================================================================================================================
.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl cpct_getScreenPtr_asm

;===================================================================================================================================================
; Public functions
;===================================================================================================================================================
.globl _man_entityForAllMatching
.globl _man_entityDestroy
.globl _man_setEntity4Destroy
.globl _m_game_playerShot

;===================================================================================================================================================
; Public data
;===================================================================================================================================================
.globl _m_functionMemory
.globl _m_signatureMatch

;===================================================================================================================================================
; Includes
;===================================================================================================================================================
.include "resources/macros.s" ;;Info : Hay un macro todo wapo para ver si se pulsan la tecla indicada
.include "resources/entityInfo.s"

;===================================================================================================================================================
; Keyboard  TODO : Intentar hacerlo con el joystick sería la polla lironda
;===================================================================================================================================================
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

    call cpct_scanKeyboard_f_asm
    
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

    jp stopCheckMovement

    upPressed:
        ld a, e_ypos(ix)
        dec a
        dec a
        dec a
        dec a
        ld e_ypos(ix), a
        jp stopCheckMovement

    leftPressed:
        ld a, e_xpos(ix)
        dec a
        ld e_xpos(ix), a
        jp stopCheckMovement

    downPressed:
        ld a, e_ypos(ix)
        inc a
        inc a
        inc a
        inc a
        ld e_ypos(ix), a
        jp stopCheckMovement

    rightPressed:
        ld a, e_xpos(ix)
        inc a
        ld e_xpos(ix), a
        jp stopCheckMovement

    stopCheckMovement:
   ret