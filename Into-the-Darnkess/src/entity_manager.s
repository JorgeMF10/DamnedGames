;;
;; ENTITY MANAGER
;;
.include "entity_manager.h.s"
.include "cpctelera.h.s"

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

man_entity_getArray::
    ld ix, #_entity_array
    ld a, (_num_entities)

ret

man_entity_init::
    xor a
    ld (_num_entities), a
    
    ld hl, #_entity_array
    ld (_last_elem_ptr), hl

ret

man_entity_new::

    ld hl, #_num_entities ;; Incremento el numero de entidades
    inc (hl)
    
    ld hl, (_last_elem_ptr)
    ld d, h
    ld e, l
    ld bc, #sizeof_e ;; cargo una entidad del tamano de una entidad
    add hl, bc
    ld (_last_elem_ptr), hl ;;Lo anado al vector
    ret
ret

entityman_create::

    push hl
    call man_entity_new ;;Cargo una nueva entidad al vector

    ld__ixh_d
    ld__ixl_e

    pop hl
    
    ldir 
ret