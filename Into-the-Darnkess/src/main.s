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

   call rendersys_init
   call man_game_init ;; Se crean las entidades
   
   call man_entity_getArray

loop:
   ;; Loop forever   
   call man_entity_getArray
   call man_game_update
   call cpct_waitVSYNC_asm
   
   call man_game_render

   jr    loop