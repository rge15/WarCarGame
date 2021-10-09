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

;;Carga en el registro A el campo que quieras de la struct de la entity
.macro LOAD_ENTITY_VARIABLE_IN_REGISTER _entity, _entity_var, _register
    push af
    
    ld ix, _entity
    ld a, _var(ix)
    ld _register, a

    pop af
.endm

;;Incrementa en 1 la variable indicada de la entidad indicada
.macro INCREMENT_ENTITY_VARIABLE _entity, _entity_var
    push af
    
    ld ix, _entity
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
    
    ld hl, #_key  ;;Key O
    call cpct_isKeyPressed_asm
.endm 
