;;
;;CABECERA DE ENTITYMANAGER
;;
.globl entityman_getEntityVector_IX
.globl entityman_getNumEntities_A
.globl entityman_create

;;Macro creacion de entidades
.macro DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color
   
   .db _x
   .db _y
   .db _vx
   .db _vy
   .db _w
   .db _h
   .db _color
   
.endm

.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color
    _name::
        DefineEntityAnnonimous
.endm

e_x = 0
e_y = 1
e_w = 2
e_h = 3
e_vx = 4
e_vy = 5
e_col = 6
sizeof_e = 7

.macro DefineEntityArray _name, _N
    _name::
        .rept _N
            DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
        .endm
.endm

;;
;;CONSTANTES
;;Estas no se si estan bien. Fran no las incluye en el video
.globl _num_entities
.globl _entity_array