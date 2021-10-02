;;
;; RENDER SYSTEM
;; 
.include "cpctelerafunction.h.s"


rendersys_init::

ret

;;INPUT 
;; IX PUNTERO A LA PRIMERA ENTIDAD
;; A NUMERO DE ENTIDADES A RENDERIZAR

rendersys_update::
_renloop:

    push af
    ld de, #0xC000
    ld c, 0(ix)
    ld b, 1(ix)
        
    call cpct_getScreenPtr_asm

    ;;Pintar 
    ex de, hl
    ld a, 6(ix)
    ld c, 2(ix)
    ld b, 3(ix)    
    call cpct_drawSolidBox_asm
    pop af

    dec a 
    ret z
    ld bc, #entity_size
    add ix, bc
    jr _renloop

ret