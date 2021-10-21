.module Macros

; .include "resources/macros.h.s"


;;Cargar el valor de _m_sizeOfEntity
.macro LOAD_VARIABLE_IN_REGISTER _var, _register
    ld a, (#_var)
    ld _register, a
.endm 

;;Cargar crear entidades con el template indicado
.macro CREATE_ENTITY_FROM_TEMPLATE _template
    ld bc, #_template
    call _m_game_createInitTemplate
.endm



;;;;;;;;;;;;;;;;;;;WORK ON PROGRESS ;;;;;;;;;;;;;;;;;;;;;;
;;Carga en el registro A el campo que quieras de la struct de la entity
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; IMPORTANTE : NO SE PUEDE UTILIZAR EN EL REGISTRO A NI F
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.macro LOAD_ENTITY_VARIABLE_IN_REGISTER _entity, _entity_var, _register
    ; push af
    ; push bc
    ; push hl
    push _entity
    pop ix
    ld _register, _entity_var(ix)

    ; ld b,h
    ; ld c,l
    ; ld hl, #_macro_addresAux
    ; ld (hl), c
    ; inc hl
    ; ld (hl), b

    ; ld ix, #_macro_addresAux
    ; ld a, _entity_var(ix)
    
    ; pop hl
    ; pop bc

    ; ld _register, a

    ; pop af
.endm

;;Incrementa en 1 la variable indicada de la entidad indicada
.macro INCREMENT_ENTITY_VARIABLE _entity, _entity_var
    push af
    
    ld _entityAux
    ld ix, _entityAux
    inc _entity_var(ix)

    pop af
.endm

;;Decrementa en 1 la variable indicada de la entidad indicada
.macro DECREMENT_ENTITY_VARIABLE _entity, _entity_var
    push af
    

    ld ix, _entity
    dec _entity_var(ix)

    pop af
.endm

;;Comprueba si la tecla pasada por parametro se está pulsando
.macro CHECK_KEYBOARD_INPUT_IN_KEY _key
    call cpct_scanKeyboard_f_asm
    
    ld hl, #_key
    call cpct_isKeyPressed_asm
.endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Calculate the given number negated
;; Return: Return the number negated in the _register
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro NEGATE_NUMBER _register
   ld a, _register
   xor #0xFF
   add a, #0x01

.endm


;===============================================================================
; Comprobrar los dos af despues de salir de seekCoords_x y seekCoords_y
; Salta ret si no es el caso !!!
; Parameters:
;  - HL: af register
;  - BC: previous af register
;  - DE: paramter for _call_on_succes that goes on HL
;===============================================================================
.macro X_AND_Y_ON_ZERO_AFTER_SEEK _call_on_succes
   ld a, #0x40
   and l
   ld l, a

   ld a, #0x40
   and c
   ld c, a

   ld a, l
   cp c
   jr z, same_values_in_f
   ret

   same_values_in_f:
      ld a, #0x40
      cp c

      ex de, hl
      call z, _call_on_succes
.endm

;; TODO[Edu]: meter velocidades tambien

.macro SEEK_COORDS_X_Y_SAVING_FLAGS
   call _sys_ai_seekCoords_x
   push af
   call _sys_ai_seekCoords_y
   push af
   pop hl
   pop bc
.endm

;===============================================================================
; Comprobrar si entidad esta parada
; Salta ret si no es el caso !!!
; Usar al final de un label
;===============================================================================
.macro CHECK_VX_VY_ZERO _call_on_succes
   ld a, e_vx(ix)
   or a
   jr z, . + 3
   ret
      ld a, e_vy(ix)
      or a
      call z, _call_on_succes

.endm

;===============================================================================
; Comprobrar si entidad esta parada
; Destroy: BC, HL
;===============================================================================
.macro GET_PLAYER_ENTITY _register
   ld hl, #_m_playerEntity
   ld b, (hl)
   inc hl
   ld c, (hl)
   push bc
   pop _register
.endm

