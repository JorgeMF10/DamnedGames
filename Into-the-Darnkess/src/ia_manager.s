.include "entity_manager.h.s"
.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"

sys_ai_init::
    ld (_ent_array_ptr), ix
ret

sys_ai_stand_by::
    _ent_array_ptr_temp_standby = . + 2
    ld iy, #0x0000

    ld a, e_ai_aim_x(iy)
    or a
    ret z

    ld a, e_x(iy)
    ld e_ai_aim_x(ix), a
    ld a, e_y(iy)
    ld e_ai_aim_y(ix), a
    ld e_ai_st(ix), #e_ai_move_to

ret

sys_ai_move_to::

    ld e_vx(ix), #0
    ld e_vy(ix), #0
;;    ld c, #0
;;    ld e_vx(ix), #0
;;    ld a, e_ai_aim_x(ix) ;; A = x_obetivo
;;    sub e_x(ix)          ;; A = obj_x - x
;;    jr nc, _objx_greater_or_equal
;;
;;    _objx_lesser:
;;        ld e_vx(ix), #-1
;;        jr _endif_x
;;
;;    _objx_greater_or_equal:
;;        jr z, _arrived_x
;;        ld e_vx(ix), #1
;;        jr _endif_x
;;
;;    _arrived_x:
;;        ld e_vx(ix), #0
;;        ld c, #1
;;
;;_endif_x:
;;
;;    ld a, e_ai_aim_y(ix) ;; A = x_obetivo
;;    sub e_y(ix)          ;; A = obj_x - x
;;    jr nc, _objy_greater_or_equal
;;
;;    _objy_lesser:
;;        ld e_vy(ix), #-2
;;        jr _endif_y
;;
;;    _objy_greater_or_equal:
;;        jr z, _arrived_y
;;        ld e_vy(ix), #2
;;        jr _endif_y
;;
;;    _arrived_y:
;;        ld e_vy(ix), #0
;;        ld a, e_vx(ix)
;;        or a
;;        jr nz, _endif_y
;;        ld e_ai_st(ix), #e_ai_st_stand_by
;;
;;    _endif_y:
;;
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

_no_AI_ent:
    
_entity_counter = . + 1
    ld a, #0
    dec a
    ret z
    
    ld (_entity_counter), a

    ld de, #sizeof_e
    add ix, de
    jr _loop