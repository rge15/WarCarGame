.module Main

.include "cpctelera.h.s"
.include "man/game.h.s"
.include "cpct_globals.h.s"
.include "resources/macros.h.s"

;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA
;==========
;TODO : Ver donde meto esto es una guarrada tener lo de los macros aqui
;==========
_macro_addresAux::
    .dw #0x0000

.area _CODE

;;
;;MAIN
;;
;===================================================================================================================================================
; FUNCION main
; Inicio del programa
; NO llega ningun valor
;===================================================================================================================================================
_main::
    call	cpct_disableFirmware_asm

    cpctm_setBorder_asm HW_BRIGHT_CYAN
    call _m_game_init
    call _m_game_play
