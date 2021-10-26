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
current_interruption:: .db 0

;;====================================================================
;; INTERRUPTION FUNCTIONS
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 1 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_1::
	push af
	push bc
	push de
	push hl

    ld a, #5
    ld (#current_interruption), a
	; cpctm_setBorder_asm HW_BLACK

	;;Here we scan the keyboard to see detect the pressed keys
	; call cpct_scanKeyboard_if_asm

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_2
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 2 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_2::
	push af
	push bc
	push de
	push hl

    ld a, #4
    ld (#current_interruption), a
	; cpctm_setBorder_asm HW_PINK

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_3
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 3 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_3::
	push af
	push bc
	push de
	push hl

    ld a, #3
    ld (#current_interruption), a
	; cpctm_setBorder_asm HW_RED
	;;Here we scan the keyboard to see detect the pressed keys
	; call cpct_scanKeyboard_if_asm

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_4
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 4 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_4::
	push af
	push bc
	push de
	push hl

    ld a, #2
    ld (#current_interruption), a
	; cpctm_setBorder_asm HW_BLUE
	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_5
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 5 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_5::
	push af
	push bc
	push de
	push hl

    ld a, #1
    ld (#current_interruption), a
	cpctm_setBorder_asm HW_GREEN
	;;Here we play the music, once per frame (25.000Hz)
	call cpct_akp_musicPlay_asm

	;;Here we scan the keyboard to see detect the pressed keys
	; call cpct_scanKeyboard_if_asm

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_6
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 6 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_6::
	push af
	push bc
	push de
	push hl

    ld a, #0
    ld (#current_interruption), a
	
	; cpctm_setBorder_asm HW_YELLOW

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_1
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - DE: should contain the memory direction of the function to execute in the next interruption
;; Objetive: Set the interruption 6 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_interruptions_set_next_interruption:
    ;;Here we set the next interruption to jump to the next int_handler
	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	ld (hl), #0xC9
ret

;;====================================================================
;; INTERRUPTION SETTER
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruptions in the correct order.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
set_int_handler::
	;;Here we wait to set always the first interruption to be the same
	call cpct_waitVSYNC_asm
	halt 
	halt
	call cpct_waitVSYNC_asm

	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), #<int_handler_1
	inc hl
	ld (hl), #>int_handler_1
	inc hl
	ld (hl), #0xC9
ret