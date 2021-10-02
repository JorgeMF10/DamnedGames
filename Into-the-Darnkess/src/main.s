.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"

.area _DATA
.area _CODE

player: .db 20, 20, 2,  8,  1, 1, 0xFF
enemy:  .db 40, 80, 3, 12, -1, 0, 0xF0

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ld hl, #player
   call entityman_create

   ld hl, #enemy
   call entityman_create

   ld ix, #_entity_array
   ld a, (_num_entities)

   call rendersys_update
loop:
   

   call cpct_waitVSYNC_asm
   ;; Loop forever

   jr    loop