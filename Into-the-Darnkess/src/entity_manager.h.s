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
.macro DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color, _prevptr, _lantern, _aist
   
   .db _x           ;; Pos X
   .db _y           ;; Pos Y
   .db _vx          ;; Vel X
   .db _vy          ;; Vel Y
   .db _w           ;; Width
   .db _h           ;; Height
   .db _color       ;; Color
   .dw _prevptr     ;; Puntero a la ultima posicion en pantalla
   .db _lantern     ;; Estado de la linterna
   .db 0x00, 0x00   ;; AI aim X AI aim y
   .db _aist        ;; Status IA
.endm

;;.macro DefineCmp_Entity _x, _y, _vx, _vy, _w, _h, _color, _prevptr, _lantern, _aist
;;   
;;   .db _x
;;   .db _y
;;   .db _vx
;;   .db _vy
;;   .db _w
;;   .db _h           ;; Altura de la entidad
;;   .db _color       ;; Color de la entidad
;;   .dw _prevptr     ;; Puntero a la ultima posicion en pantalla
;;   .db _lantern     ;; Estado de la linterna
;;   .db 0x00, 0x00   ;; AI aim X AI aim y
;;   .db _aist         ;; Status IA
;;.endm
;;
;;.macro DefineCmp_Entity_default
;;    DefineCmp_Entity 0, 0, 0, 0, 1, 1, #0xFF, 0x000, 0, e_ai_st_noAI
;;.endm

.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color, _prevptr, _lantern, _aist
    _name::
        DefineEntityAnnonimous _x, _y, _vx, _vy, _w, _h, _color, _prevptr, _lantern, _aist
.endm

.macro DefineEntityArray _name, _N
    _name::
        .rept _N
            DefineEntityAnnonimous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAA
        .endm
.endm
;; Globales para acceder a características de Entity
e_x        = 0
e_y        = 1
e_w        = 2
e_h        = 3
e_vx       = 4
e_vy       = 5
e_col      = 6
e_prevptr  = 7
e_lantr    = 9
e_ai_aim_x = 10
e_ai_aim_y = 11
e_ai_st    = 12
sizeof_e   = 13

;;Entity AI status enum

e_ai_st_noAI     = 0
e_ai_st_stand_by = 1
e_ai_st_move_to     = 2

;;
;;CONSTANTES
;;Estas no se si estan bien. Fran no las incluye en el video

.globl _num_entities
.globl _entity_array