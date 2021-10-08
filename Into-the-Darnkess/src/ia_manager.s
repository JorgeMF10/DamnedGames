.include "entity_manager.h.s"
.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"

sys_ai_init::
    ld (_ent_array_ptr), ix
ret

sys_ai_stand_by::
    ld e_vx(ix), #-1
    ld e_vy(ix), #-1
ret

sys_ai_move_to::

ret

sys_ai_update::

    ld (_entity_counter), a

_ent_array_ptr = . + 2
    ld ix, #0x0000

_loop:

    ld a, e_ai_st(ix)
    cp #e_ai_st_noAI
    jr z, _no_AI_ent

_AI_ent:
    cp #e_ai_st_stand_by
    call z, sys_ai_stand_by
    cp #e_ai_move_to
    call z, sys_ai_move_to
        ;;ld e_vx(ix), #-1
        ;;ld e_vy(ix), #-1

_no_AI_ent:
    
_entity_counter = . + 1
    ld a, #0
    dec a
    ret z
    
    ld (_entity_counter), a

    ld de, #sizeof_e
    add ix, de
    jr _loop