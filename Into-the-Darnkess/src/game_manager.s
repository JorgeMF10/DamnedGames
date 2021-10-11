.include "entity_manager.h.s"
.include "render_system.h.s"
.include "physics.h.s"
.include "input.h.s"

;;player: .db 20, 20, 2,  8,  1, 1, 0xF0, 0xC000
;;enemy:  .db 40, 80, 3, 12, -1, 0, 0xF0

;;_x, _y, _vx, _vy, _w bytes, _h pixels, _color, _prevptr, _lantern
DefineEntity player, 20, 20, 3,  2,  8, 32, _sp_chars_0, 0xC000, 0
DefineEntity enemy,  40, 80, 0, 1, 8, 32, _sp_chars_3, 0xC000, 0

man_game_init::

 call man_entity_init
 call rendersys_init
 call sys_physics_init
 call sys_input_init

 ld hl, #player
 call entityman_create

 ld hl, #enemy
 call entityman_create

ret

man_game_update::

    call man_entity_getArray
    call sys_input_update
    call man_entity_getArray
    call sys_physics_update

ret

man_game_render::
    ;;cpctm_setBorder_asm FW_BLACK
    call man_entity_getArray
    call rendersys_update
    ;;cpctm_setBorder_asm HW_WHITE ;;para saber cuanto tarda en dibujar entidades
ret