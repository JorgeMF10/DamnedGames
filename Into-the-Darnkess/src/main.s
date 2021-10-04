.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"
.include "render_system.h.s"
.include "entity_manager.h.s"

;;Main con dos entidades 
;;Player y Enemy
.area _DATA
.area _CODE

;;player: .db 20, 20, 2,  8,  1, 1, 0xFF
;;enemy:  .db 40, 80, 3, 12, -1, 0, 0xF0


DefineEntity player, 20, 20, 2, 8, 1, 1, 0xF0
DefineEntity enemy, 40, 80, 3, 12, -1, 0, 0xFF

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ld hl, #player
   call entityman_create
   
   ld hl, #enemy
   call entityman_create

   ;;call rendersys_init
   ;;call man_game_init

   ld ix, #_entity_array
   ld a, (_num_entities)

   
loop:


   call entityman_getEntityVector_IX
   call entityman_getNumEntities_A
   call rendersys_update
   call cpct_waitVSYNC_asm
   ;; Loop forever

   jr    loop