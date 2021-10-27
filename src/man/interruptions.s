;;====================================================================
;; GLOBL INCLUDES
;;====================================================================
.include "interruptions.h.s"
.include "cpctelera.h.s"

;;Globals
.include "cpct_globals.h.s"


;;====================================================================
;; VARIABLES
;;====================================================================
_man_int_current:: .db 0

_int_handler_1::
	push af
	push bc
	push de
	push hl

    ld a, #5
    ld (#_man_int_current), a

	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_2
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_2::
	push af
	push bc
	push de
	push hl

    ld a, #4
    ld (#_man_int_current), a

    ld de, #_int_handler_3
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_3::
	push af
	push bc
	push de
	push hl

    ld a, #3
    ld (#_man_int_current), a
	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_4
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_4::
	push af
	push bc
	push de
	push hl

    ld a, #2
    ld (#_man_int_current), a
    ld de, #_int_handler_5
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_5::
	push af
	push bc
	push de
	push hl

    ld a, #1
    ld (#_man_int_current), a
	cpctm_setBorder_asm HW_GREEN
	call cpct_akp_musicPlay_asm

	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_6
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_6::
	push af
	push bc
	push de
	push hl

    ld a, #0
    ld (#_man_int_current), a
	

	ld de, #_int_handler_1
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

man_interruptions_set_next_interruption:
	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	ld (hl), #0xC9
ret

_man_int_setIntHandler::
   	ei
   	im 1
	call cpct_waitVSYNC_asm
	halt 
	halt
	call cpct_waitVSYNC_asm

	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), #<_int_handler_1
	inc hl
	ld (hl), #>_int_handler_1
	inc hl
	ld (hl), #0xC9
	ei
ret