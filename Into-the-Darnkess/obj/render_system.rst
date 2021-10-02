ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; RENDER SYSTEM
                              3 ;; 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "cpctelerafunction.h.s"
                              1 
                              2 .globl cpct_disableFirmware_asm
                              3 .globl cpct_getScreenPtr_asm
                              4 .globl cpct_drawSolidBox_asm
                              5 .globl cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 
                              6 
   405F                       7 rendersys_init::
                              8 
   405F C9            [10]    9 ret
                             10 
                             11 ;;INPUT 
                             12 ;; IX PUNTERO A LA PRIMERA ENTIDAD
                             13 ;; A NUMERO DE ENTIDADES A RENDERIZAR
                             14 
   4060                      15 rendersys_update::
   4060                      16 _renloop:
                             17 
   4060 F5            [11]   18     push af
   4061 11 00 C0      [10]   19     ld de, #0xC000
   4064 DD 4E 00      [19]   20     ld c, 0(ix)
   4067 DD 46 01      [19]   21     ld b, 1(ix)
                             22         
   406A CD 41 41      [17]   23     call cpct_getScreenPtr_asm
                             24 
                             25     ;;Pintar 
   406D EB            [ 4]   26     ex de, hl
   406E DD 7E 06      [19]   27     ld a, 6(ix)
   4071 DD 4E 02      [19]   28     ld c, 2(ix)
   4074 DD 46 03      [19]   29     ld b, 3(ix)    
   4077 CD 9D 40      [17]   30     call cpct_drawSolidBox_asm
   407A F1            [10]   31     pop af
                             32 
   407B 3D            [ 4]   33     dec a 
   407C C8            [11]   34     ret z
   407D 01 07 00      [10]   35     ld bc, #entity_size
   4080 DD 09         [15]   36     add ix, bc
   4082 18 DC         [12]   37     jr _renloop
                             38 
   4084 C9            [10]   39 ret
