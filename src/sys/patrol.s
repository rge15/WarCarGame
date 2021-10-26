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
   .db  30, 140
   .db  12, 30
   .db  64, 30
   .db  10, 100
   .db #patrol_invalid_move
   .dw #patrol_02

patrol_03:
   .db  50, 80
   .db  20, 80
   .db #patrol_invalid_move
   .dw #patrol_03

patrol_none:
   .db  50, 50
   ; .db  20, 80
   .db #patrol_invalid_move
   .dw #patrol_none

p_move_in_x:
   .db  50, 50
   .db  20, 50
   .db #patrol_invalid_move
   .dw #p_move_in_x

;; moverse alredeodr de una entidad
patrol_relative_01:
   .db  6, -10
   .db  6, 10
   .db  -6, 10
   .db  -6, -10
   .db #patrol_invalid_move
   .dw #patrol_relative_01

patrol_relative_02:
   .db  0, -16
   .db  0, 16
   .db #patrol_invalid_move
   .dw #patrol_relative_02

patrol_relative_03:
   .db  0, 12
   .db  12, 12
   .db  12, 0
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_03

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

   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ld a, (hl)
   cp #patrol_invalid_move
   call z, reset_patrol

   ld d, (hl)
   inc hl
   ld e, (hl)
   ex de, hl

   call _sys_ai_setAiAim

   ex de, hl
   inc hl

   ld e_patrol_step_h(ix), h
   ld e_patrol_step_l(ix), l

   ret

_sys_patrol_next_relative:
   call _sys_patrol_next

   ld h, e_ai_aim_x(ix)
   ld l, e_ai_aim_y(ix)

   ld d, e_ai_aux_h(ix)
   ld e, e_ai_aux_l(ix)

   ld a, h
   add a, e
   ld e_ai_aim_x(ix), a

   ld a, l
   add a, d
   ld e_ai_aim_y(ix), a
   ret

reset_patrol:
   inc hl
   ld a, (hl)
   inc hl
   ld h, (hl)

   ld e_patrol_step_l(ix), a
   ld e_patrol_step_h(ix), h

   ; actualizamos nuevo para volver a _sys_patrol_next
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ret

;===============================================================================
; Meter en ai_aux la posicion del jugador al hacer el call
; Destroy: BC
; IY: entity to set as origin
; IX: AI
;===============================================================================
_sys_patrol_set_relative_origin:

   ld h, e_xpos(iy)
   ld l, e_ypos(iy)

   ld e_ai_aux_h(ix), l
   ld e_ai_aux_l(ix), h

   ;; TODO: donde va aaa
   ld e_aictr(ix), #16

   ret

