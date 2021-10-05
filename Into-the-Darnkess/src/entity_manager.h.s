;;
;;CABECERA DE ENTITYMANAGER
;;
.globl entityman_getEntityVector_IX
.globl entityman_getNumEntities_A
.globl man_entity_getArray
.globl entityman_create
.globl man_entity_new
.globl man_entity_init

;;Macro creacion de entidades
.macro DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color, _linterna
   
   .db _x
   .db _y
   .db _vx
   .db _vy
   .db _w
   .db _h
   .db _color
   .db _linterna
   
.endm

.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color, _linterna
    _name::
        DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color, _linterna
.endm

.macro DefineEntityArray _name, _N
    _name::
        .rept _N
            DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAA
        .endm
.endm

e_x = 0
e_y = 1
e_w = 2
e_h = 3
e_vx = 4
e_vy = 5
e_col = 6
e_lantern = 7
sizeof_e = 8

;;
;;CONSTANTES
;;Estas no se si estan bien. Fran no las incluye en el video
.globl _num_entities
.globl _entity_array