ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; ENTITY MANAGER
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "entity_manager.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 
                     0003     6 max_entities == 3
                              7 
   4000 00                    8 _num_entities::  .db 0
   4001 03 40                 9 _last_elem_ptr:: .dw _entity_array
                             10 
   4003                      11 DefineEntityArray _entity_array, max_entities
   0003                       1     _entity_array::
                              2         .rept max_entities
                              3             DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              4         .endm
   0003                       1             DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              1    
   4003 DE                    2    .db 0xDE
   4004 AD                    3    .db 0xAD
   4005 DE                    4    .db 0xDE
   4006 AD                    5    .db 0xAD
   4007 DE                    6    .db 0xDE
   4008 AD                    7    .db 0xAD
   4009 AA                    8    .db 0xAA
                              9    
   000A                       1             DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              1    
   400A DE                    2    .db 0xDE
   400B AD                    3    .db 0xAD
   400C DE                    4    .db 0xDE
   400D AD                    5    .db 0xAD
   400E DE                    6    .db 0xDE
   400F AD                    7    .db 0xAD
   4010 AA                    8    .db 0xAA
                              9    
   0011                       1             DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              1    
   4011 DE                    2    .db 0xDE
   4012 AD                    3    .db 0xAD
   4013 DE                    4    .db 0xDE
   4014 AD                    5    .db 0xAD
   4015 DE                    6    .db 0xDE
   4016 AD                    7    .db 0xAD
   4017 AA                    8    .db 0xAA
                              9    
                             12 
                             13 ;;DefineComponentArrayStructure _entity, max_entities, Definecmp_EntityDefault
                             14 
   4018                      15 entityman_getEntityVector_IX::
                             16 
   4018 DD 21 03 40   [14]   17     ld ix, #_entity_array
   401C C9            [10]   18 ret
                             19 
   401D                      20 entityman_getNumEntities_A::
   401D 3A 00 40      [13]   21     ld a, (_num_entities)
   4020 C9            [10]   22 ret
                             23 
   4021                      24 man_entity_getArray::
   4021 DD 21 03 40   [14]   25     ld ix, #_entity_array
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   4025 3A 00 40      [13]   26     ld a, (_num_entities)
                             27 
   4028 C9            [10]   28 ret
                             29 
   4029                      30 man_entity_init::
   4029 AF            [ 4]   31     xor a
   402A 32 00 40      [13]   32     ld (_num_entities), a
                             33     
   402D 21 03 40      [10]   34     ld hl, #_entity_array
   4030 22 01 40      [16]   35     ld (_last_elem_ptr), hl
                             36 
   4033 C9            [10]   37 ret
                             38 
   4034                      39 man_entity_new::
                             40 
   4034 21 00 40      [10]   41     ld hl, #_num_entities ;; Incremento el numero de entidades
   4037 34            [11]   42     inc (hl)
                             43     
   4038 2A 01 40      [16]   44     ld hl, (_last_elem_ptr)
   403B 54            [ 4]   45     ld d, h
   403C 5D            [ 4]   46     ld e, l
   403D 01 07 00      [10]   47     ld bc, #sizeof_e ;; cargo una entidad del tamano de una entidad
   4040 09            [11]   48     add hl, bc
   4041 22 01 40      [16]   49     ld (_last_elem_ptr), hl ;;Lo anado al vector
   4044 C9            [10]   50     ret
   4045 C9            [10]   51 ret
                             52 
   4046                      53 entityman_creater::
                             54 
   4046 E5            [11]   55     push hl
   4047 CD 34 40      [17]   56     call man_entity_new ;;Cargo una nueva entidad al vector
                             57 
                             58     ;;ld__ixh_d
                             59     ;;ld__ixl_e
                             60 
   404A E1            [10]   61     pop hl
                             62     
   404B ED B0         [21]   63     ldir 
   404D C9            [10]   64 ret
                             65 
   404E                      66 entityman_create::
                             67     
   404E ED 5B 01 40   [20]   68     ld de, (_last_elem_ptr)
   4052 01 07 00      [10]   69     ld bc, #sizeof_e
   4055 ED B0         [21]   70     ldir
                             71 
   4057 3A 00 40      [13]   72     ld a, (_num_entities)
   405A 3C            [ 4]   73     inc a
   405B 32 00 40      [13]   74     ld (_num_entities), a
                             75 
   405E 2A 01 40      [16]   76     ld hl, (_last_elem_ptr)
   4061 01 07 00      [10]   77     ld bc, #sizeof_e
   4064 09            [11]   78     add hl, bc
   4065 22 01 40      [16]   79     ld (_last_elem_ptr), hl
                             80 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4068 C9            [10]   81 ret
