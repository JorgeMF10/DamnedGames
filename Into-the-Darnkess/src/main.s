.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"
.include "render_system.h.s"
.include "entity_manager.h.s"
.include "game_manager.h.s"

;;Main con dos entidades 
;;Player y Enemy
.area _DATA
.area _CODE

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;;ld hl, #player
   ;;call entityman_create
   
   ;;ld hl, #enemy
   ;;call entityman_create

   call rendersys_init
   call man_game_init

   ld ix, #_entity_array
   ld a, (_num_entities)

loop:
   ;; Loop forever
   call entityman_getEntityVector_IX
   call entityman_getNumEntities_A
   call man_game_update
   call cpct_waitVSYNC_asm
   
   call man_game_render

   jr    loop