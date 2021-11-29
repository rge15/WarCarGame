.module Items

.include "items.h.s"
.include "man/game.h.s"

;===============================================================================
; Item picks
;===============================================================================
item_pick_heart:
   call _man_game_increasePlayerLife
   ret

item_pick_shield:
   ret

item_pick_skip:
   call nextLevel
   ret

item_pick_restart:
   call restartLevel
   ret

;===============================================================================
; Item create
;===============================================================================

item_create_shield:
   ret
