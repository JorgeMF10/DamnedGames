.include "entity_manager.h.s"
.include "render_system.h.s"


player: .db 20, 20, 2,  8,  1, 1, 0xFF
enemy:  .db 40, 80, 3, 12, -1, 0, 0xF0


man_game_init::

 call man_entity_init
 ;;call sys_eren_init
 ;;call sys_physics_init
 ;;call sys_input_init

 ;;ld hl, #player
 ;;call man_entity_create

 ;;ld hl, enemy
 ;;call man_entity_create

ret

man_game_update::

    ;;call man_entity_getArray
    ;;call sys_input_update
    ;;call man_entity_getArray
    ;;call sys_physics_update

ret

man_game_render::
    ;;call man_entity_getArray
    ;;call sys_eren_update
ret