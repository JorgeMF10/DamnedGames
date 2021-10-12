;;
;; RENDER SYSTEM
;; 
.include "cpctelerafunction.h.s"
.include "entity_manager.h.s"
.include "cpctelera.h.s"

screen_start = 0xC000

rendersys_init::
    ld c, #0x01
    call cpct_setVideoMode_asm
    ;;ld hl, #_pal_main
    ;;ld de, #16
    ;;call cpct_setPalette_asm
    ;;call cpctm_setBorder_asm
ret

_pintarlinterna:
    ld a, e_lantr(ix)
    dec a
    jr z, encendida

    ld a, #0xFF
    call pintarcubo

    ret
    encendida:
    ld a, #0x0F
    call pintarcubo
    ret

;;Llega en A el color
pintarcubo:
    ld c, e_w(ix)
    ld b, e_h(ix)
    call cpct_drawSolidBox_asm
ret

;;INPUT 
;; IX PUNTERO A LA PRIMERA ENTIDAD
;; A NUMERO DE ENTIDADES A RENDERIZAR

rendersys_update::
_renloop:

    push af

    ld e, e_prevptr+0(ix)
    ld d, e_prevptr+1(ix)
    xor a
    ld bc, #0x2004
    call cpct_drawSolidBox_asm

    ld de, #0xC000
    ld c, e_x(ix)
    ld b, e_y(ix)
        
    call cpct_getScreenPtr_asm

    ld e_prevptr+0(ix), l
    ld e_prevptr+1(ix), h

    ;;Pintar 
    ex de, hl
    ld a, e_col(ix)
    call pintarcubo

    ;;call _pintarlinterna

    pop af

    dec a 
    ret z
    ld bc, #sizeof_e
    add ix, bc
    jr _renloop

ret