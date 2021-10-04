;;
;;CABECERA DE ENTITYMANAGER
;;
.globl entityman_getEntityVector_IX
.globl entityman_getNumEntities_A
.globl entityman_create
.globl man_entity_new
.globl man_entity_init

;;Macro creacion de entidades
.macro DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _pspr, _last
   
   .db _x, _y
   .db _vx, _vy
   .db _w, _h
   .dw _pspr
   .dw 0xCCCC

   
.endm

.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color
    _name::
        DefineEntityAnnonimous
.endm

.macro DefineEntityArray _name, _N
    _name::
        .rept _N
            DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
        .endm
.endm

e_x = 0
e_y = 1
e_vx = 2
e_vy = 3
e_w = 4
e_h = 5
e_pspr_l = 6
e_pspr_h = 7
e_lastVP_l = 8
e_lastVP_h = 9
sizeof_e = 10

;;
;;CONSTANTES
;;Estas no se si estan bien. Fran no las incluye en el video
.globl _num_entities
.globl _entity_array