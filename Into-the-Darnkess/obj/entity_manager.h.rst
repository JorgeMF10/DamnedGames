ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
