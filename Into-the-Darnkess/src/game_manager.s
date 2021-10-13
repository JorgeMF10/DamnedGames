.include "entity_manager.h.s"
.include "render_system.h.s"
.include "physics.h.s"
.include "input.h.s"
.include "ia_managers.h.s"


;;                      x   y   h   w    vx  vy   Color VMPtr   ltr IAState
DefineEntity player,    50, 50, 2,  8,   1,  1, 0xF0, 0xC000,  0, e_ai_st_noAI
DefineEntity enemy ,    40, 80, 4,  16,  1, -1, 0xFF, 0xC000,  0, e_ai_st_move_to
DefineEntity bloc  ,    30, 30, 2,  8,   0,  0, 0x0F, 0xC000,  0, e_ai_st_noAI



man_game_init::

    call man_entity_getArray
    call sys_ai_init
    call man_entity_init
    call rendersys_init
    call sys_physics_init
    call sys_input_init

    ld hl, #player
    call entityman_create
       
    ld hl, #enemy
    call entityman_create

    ld hl, #bloc
    call entityman_create

ret

man_game_update::

    call man_entity_getArray
    call sys_input_update
    call entityman_getNumEntities_A
    call sys_ai_update
    call man_entity_getArray
    call sys_physics_update

ret

man_game_render::
    call man_entity_getArray
    call rendersys_update
ret