ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; RENDER SYSTEM
                              3 ;; 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "cpctelerafunction.h.s"
                              1 ;;Fichero de cabecera para las funciones internas de CPC_TELERA
                              2 .globl cpct_disableFirmware_asm
                              3 .globl cpct_getScreenPtr_asm
                              4 .globl cpct_drawSolidBox_asm
                              5 .globl cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "entity_manager.h.s"
                              1 ;;
                              2 ;;CABECERA DE ENTITYMANAGER
                              3 ;;
                              4 .globl entityman_getEntityVector_IX
                              5 .globl entityman_getNumEntities_A
                              6 .globl entityman_create
                              7 .globl man_entity_new
                              8 .globl man_entity_init
                              9 
                             10 ;;Macro creacion de entidades
                             11 .macro DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color
                             12    
                             13    .db _x
                             14    .db _y
                             15    .db _vx
                             16    .db _vy
                             17    .db _w
                             18    .db _h
                             19    .db _color
                             20    
                             21 .endm
                             22 
                             23 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color
                             24     _name::
                             25         DefineEntityAnnonimous
                             26 .endm
                             27 
                             28 .macro DefineEntityArray _name, _N
                             29     _name::
                             30         .rept _N
                             31             DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                             32         .endm
                             33 .endm
                             34 
                     0000    35 e_x = 0
                     0001    36 e_y = 1
                     0002    37 e_w = 2
                     0003    38 e_h = 3
                     0004    39 e_vx = 4
                     0005    40 e_vy = 5
                     0006    41 e_col = 6
                     0007    42 sizeof_e = 7
                             43 
                             44 ;;
                             45 ;;CONSTANTES
                             46 ;;Estas no se si estan bien. Fran no las incluye en el video
                             47 .globl _num_entities
                             48 .globl _entity_array
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 
   40AF                       7 rendersys_init::
                              8 
   40AF C9            [10]    9 ret
                             10 
                             11 ;;INPUT 
                             12 ;; IX PUNTERO A LA PRIMERA ENTIDAD
                             13 ;; A NUMERO DE ENTIDADES A RENDERIZAR
                             14 
   40B0                      15 rendersys_update::
   40B0                      16 _renloop:
                             17 
   40B0 F5            [11]   18     push af
   40B1 11 00 C0      [10]   19     ld de, #0xC000
   40B4 DD 4E 00      [19]   20     ld c, e_x(ix)
   40B7 DD 46 01      [19]   21     ld b, e_y(ix)
                             22         
   40BA CD 91 41      [17]   23     call cpct_getScreenPtr_asm
                             24 
                             25     ;;Pintar 
   40BD EB            [ 4]   26     ex de, hl
   40BE DD 7E 06      [19]   27     ld a, e_col(ix)
   40C1 DD 4E 02      [19]   28     ld c, e_w(ix)
   40C4 DD 46 03      [19]   29     ld b, e_h(ix)    
   40C7 CD ED 40      [17]   30     call cpct_drawSolidBox_asm
   40CA F1            [10]   31     pop af
                             32 
   40CB 3D            [ 4]   33     dec a 
   40CC C8            [11]   34     ret z
   40CD 01 07 00      [10]   35     ld bc, #sizeof_e
   40D0 DD 09         [15]   36     add ix, bc
   40D2 18 DC         [12]   37     jr _renloop
                             38 
   40D4 C9            [10]   39 ret
