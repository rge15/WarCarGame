.module Input
;===================================================================================================================================================
; Includes
;===================================================================================================================================================
.include "resources/macros.h.s" ;;Info : Hay un macro todo wapo para ver si se pulsan la tecla indicada
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "input.h.s"


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
    
   ret
