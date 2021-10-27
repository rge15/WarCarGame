.module Macros

.macro PREPARE_SCORE_DIGIT_TO_RENDER _vmem 

    and #0x0F
    ld de, #_vmem
    ld hl, #_m_HUD_scoreHeight
    ld b, (hl)
    ld hl, #_m_HUD_scoreWidth
    ld c, (hl)

.endm 

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

;;Cargar crear entidades con el template indicado
.macro CREATE_ENTITY_FROM_REGISTER _template
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

;; Aumenta el registro X veces
.macro INCREMENT_REGISTER _register, _numLoops
    ld a, _numLoops
    _loopIncrement:
        inc _register
        dec a
        jr nz, _loopIncrement
.endm

;;Comprueba si la tecla pasada por parametro se está pulsando
.macro CHECK_KEYBOARD_INPUT_IN_KEY _key
    ; call cpct_scanKeyboard_f_asm
    
    ld hl, #_key
    call cpct_isKeyPressed_asm
.endm 

;; Según la orientación de la entidad devuelve el bounding box
;; de arriba o abajo
.macro CHECK_ORIENTATION_PLAYER_FOR_COLLISION_Y _orientation _height

    ;; UP = 3
    ld a, #0x03
    ld d, _orientation
    sub d
    jp z, _is_up

    ;; DOWN = 1
    ld a, #0x01
    ld d, _orientation
    sub d
    jp z, _is_down

    jp _is_none_x

    _is_up:
    ld d, #0xFF
    jp _done_check_y_orientation

    _is_down:
    ld d, _height
    jp _done_check_y_orientation

    _is_none_x:
    ld d, #0x00

    _done_check_y_orientation:

.endm

.macro CHECK_ORIENTATION_PLAYER_FOR_COLLISION_X _orientation _width

    ;; RIGHT = 0
    ld a, #0x00
    ld d, _orientation
    sub d
    jp z, _is_right

    ;; LEFT = 2
    ld a, #0x02
    ld d, _orientation
    sub d
    jp z, _is_left

    jp _is_none_y

    _is_right:
    ld d, _width
    jp _done_check_x_orientation

    _is_left:
    ld d, #0xFF
    jp _done_check_x_orientation

    _is_none_y:
    ld d, #0x00

    _done_check_x_orientation:

.endm

;; Según la orientación del axis del jugador
;; devuelve en a (0 = x_axis) o (1 = y_axis)
.macro CHECK_ORIENTATION_AXIS_PLAYER _orientation

    ;; RIGHT = 0
    ld a, #0x00
    ld d, _orientation
    sub d
    jp z, _is_x_axis

    ;; DOWN = 1
    ld a, #0x01
    ld d, _orientation
    sub d
    jp z, _is_y_axis

    ;; LEFT = 2
    ld a, #0x02
    ld d, _orientation
    sub d
    jp z, _is_x_axis

    ;; UP = 3
    ld a, #0x03
    ld d, _orientation
    sub d
    jp z, _is_y_axis

    _is_x_axis:
    ld a, #0x00
    jp _axis_checked

    _is_y_axis:
    ld a, #0x01

    _axis_checked:

.endm


.macro CHECK_HAS_MOVEMENT _vx_vel _vy_vel
    ;; a = 0 -> no_vel
    ;; a = 1 -> x_vel
    ;; a = 2 -> y_vel

    ld a, _vx_vel
    ld b, #0x00
    sub b
    jr nz, _has_vel

    ld a, _vy_vel
    ld b, #0x00
    sub b
    jr nz, _has_vel

    jp _has_no_vel

    _has_vel:
    ld b, #0x00
    jp _vel_checked

    _has_no_vel:
    ld b, #0x01
    
    _vel_checked:
    
.endm

;; Obtiene la posición de la entidad en el array que se le pasa
;;      - DE: La posición de la entidad en el array
.macro GET_ENTITY_POSITION _entityDirection
   ld hl, #_entityDirection
   ld d, (hl)
   inc hl
   ld e, (hl)
.endm