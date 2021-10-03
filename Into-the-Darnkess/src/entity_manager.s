;;
;; ENTITY MANAGER
;;
.include "entity_manager.h.s"

max_entities == 3

_num_entities::  .db 0
_last_elem_ptr:: .dw _entity_array

DefineEntityArray _entity_array, max_entities


entityman_getEntityVector_IX::

    ld ix, #_entity_array
ret

entityman_getNumEntities_A::
    ld a, (_num_entities)
ret


entityman_create::
    
    ld de, (_last_elem_ptr)
    ld bc, #sizeof_e
    ldir

    ld a, (_num_entities)
    inc a
    ld (_num_entities), a

    ld hl, (_last_elem_ptr)
    ld bc, #sizeof_e
    add hl, bc
    ld (_last_elem_ptr), hl

ret