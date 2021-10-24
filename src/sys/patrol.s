.module Patrol

.include "resources/entityInfo.s"
.include "resources/macros.s"
.include "sys/patrol.h.s"
.include "sys/ai.h.s"


patrol_01:
   .db  6, 6
   .db  30, 30
   .db  40, 30
   .db  40, 12
   .db #patrol_invalid_move
   .dw #patrol_01

patrol_02:
   .db  50, 50
   .db  12, 12
   .db  12, 30
   .db  64, 30
   .db  10, 100
   .db #patrol_invalid_move
   .dw #patrol_02


; por parametro el array a las posociones a las que tiene que hacer patrool
; beh patrol
; beh x right left
; beh y up down
;===============================================================================
; actualiza _sys_ai_nextPatrolCoords y llama a _sys_ai_setAiAim
; IX: entidad
; Destroy: HL
;===============================================================================
_sys_patrol_next::

   ;; poruqe litle endiand tal
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ld a, (hl)
   cp #patrol_invalid_move
   jr z, reset_patrol

   ld d, (hl)
   inc hl
   ld e, (hl)
   ex de, hl

   call _sys_ai_setAiAim

   ex de, hl
   inc hl

   ld e_patrol_step_h(ix), h
   ld e_patrol_step_l(ix), l

   ; call _sys_ai_inc_next_patrol
   ret

reset_patrol:
   inc hl
   ld a, (hl)
   inc hl
   ld h, (hl)

   ld e_patrol_step_l(ix), a
   ld e_patrol_step_h(ix), h

   ret
