;;
;; ENTITY MANAGER
;;

max_entities == 3
entity_size  == 7

_num_entities::  .db 0
_last_elem_ptr:: .dw _entity_array
_entity_array::
    .ds max_entities*entity_size


entityman_getEntityVector_IX::

    ld ix, #_entity_array
ret

entityman_getNumEntities_A::
    ld a, (_num_entities)
ret


entityman_create::
    
    ld de, (_last_elem_ptr)
    ld bc, #entity_size
    ldir

    ld a, (_num_entities)
    inc a
    ld (_num_entities), a

    ld hl, (_last_elem_ptr)
    ld bc, #entity_size
    add hl, bc
    ld (_last_elem_ptr), hl

ret