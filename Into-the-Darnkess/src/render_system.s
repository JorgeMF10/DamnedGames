;;
;; RENDER SYSTEM
;; 
.include "cpctelerafunction.h.s"
.include "entity_manager.h.s"
.include "cpctelera.h.s"

screen_start = 0xC000

rendersys_init::
    ld c, #0x00
    call cpct_setVideoMode_asm
    ;;ld hl, #_pal_main
    ;;ld de, #16
    ;;call cpct_setPalette_asm
    ;;call cpctm_setBorder_asm
ret

rendersys_linterna::
    ld de, #0xC000
    ld c, e_x(ix)
    ld b, e_y(ix)
    call cpct_getScreenPtr_asm

    ex de, hl
    ld a, e_lantern(ix)
    dec a
    jr z, _encendida
 ;; Si el resultado de la resta es 0 la linterna está encendida, else apagada  

    ld a, #0xF0
    ld c, e_w(ix)
    ld b, e_h(ix)
    call cpct_drawSolidBox_asm

    ret
    _encendida:
        ld a, #0xFF
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
    ld de, #0xC000
    ld c, e_x(ix)
    ld b, e_y(ix)
        
    call cpct_getScreenPtr_asm

    ;;Pintar
    ex de, hl
    ld a, e_col(ix)
    ld c, e_w(ix)
    ld b, e_h(ix)    
    call cpct_drawSolidBox_asm
    call rendersys_linterna
    
    
    pop af

    dec a 
    ret z
    ld bc, #sizeof_e
    add ix, bc
    jr _renloop

ret