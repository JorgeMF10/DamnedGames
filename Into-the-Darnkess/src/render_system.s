;;
;; RENDER SYSTEM
;; El raster es PARALELO por lo que nada lo para. Eso genera los errores de render. Vsync nos hace esperar.include
;; no obstante un ciclo de ejecucion puede tardar menos que un vsync por eso nos daran errores como la linterna (aprox 20 veces puede hacer cosas por vsync)
;; pintar con mascara sera mucho, mucho mas lento + borrado
;;para saber si el raster nos "pilla" podemos toquetear el borde y sus colores
.include "cpctelerafunction.h.s"
.include "entity_manager.h.s"
.include "cpctelera.h.s"
.include "render_system.h.s"

screen_start = 0xC000

rendersys_init::
    ld c, #0x01
    call cpct_setVideoMode_asm
    ld hl, #0x0501 ;;SOMBRAS 18 MORADO, 14 NEGRO 
    call cpct_setPALColour_asm
    ld hl, #0x0703 ;;ROPA
    call cpct_setPALColour_asm
    ld hl, #0x0B02 ;;LUCES 09 0b
    call cpct_setPALColour_asm
    ;;call cpctm_setBorder_asm

    ;;render BACKGROUND
    ;;copiamos directamente en memoria cambia HL (origen), DE (destino), BC (bytes a cambiar) (320 PIXELES x200 lineas) (16384)
    ld hl, #_background
    ld de, #0xC000
    ld bc, #0x4000
    ldir 
    ;;esto consume muchisima memoria a si que en el update/loop no se puede usar
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

    ld l, e_sprite+0(ix)
    ld h, e_sprite+1(ix)
    ld e, e_prevptr+0(ix)
    ld d, e_prevptr+1(ix)
    ld c, e_h(ix)
    ld b, e_w(ix)
    call cpct_drawSpriteBlended_asm

    ld de, #0xC000
    ld c, e_x(ix)
    ld b, e_y(ix)
        
    call cpct_getScreenPtr_asm
    ld e_prevptr+0(ix), l
    ld e_prevptr+1(ix), h

    ;;Pintar 
    ex de, hl
    ld l, e_sprite+0(ix)
    ld h, e_sprite+1(ix)
    ld c, e_h(ix)
    ld b, e_w(ix)
    call cpct_drawSpriteBlended_asm


    ;; scroll por hardware + pintar fila de pixeles + borrar y pintar pintando encima con 4 de fondo y 3 de arriba redefininedo la paleta
     call _pintarlinterna
    pop af

    dec a 
    ret z
    ld bc, #sizeof_e
    add ix, bc
    jr _renloop

ret