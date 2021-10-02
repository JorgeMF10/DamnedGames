ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;; ENTITY MANAGER
                              3 ;;
                              4 
                     0003     5 max_entities == 3
                     0007     6 entity_size  == 7
                              7 
   4000 00                    8 _num_entities::  .db 0
   4001 03 40                 9 _last_elem_ptr:: .dw _entity_array
   4003                      10 _entity_array::
   4003                      11     .ds max_entities*entity_size
                             12     
   4018                      13 entityman_create::
                             14     
   4018 ED 5B 01 40   [20]   15     ld de, (_last_elem_ptr)
   401C 01 07 00      [10]   16     ld bc, #entity_size
   401F ED B0         [21]   17     ldir
                             18 
   4021 3A 00 40      [13]   19     ld a, (_num_entities)
   4024 3C            [ 4]   20     inc a
   4025 32 00 40      [13]   21     ld (_num_entities), a
                             22 
   4028 2A 01 40      [16]   23     ld hl, (_last_elem_ptr)
   402B 01 07 00      [10]   24     ld bc, #entity_size
   402E 09            [11]   25     add hl, bc
   402F 22 01 40      [16]   26     ld (_last_elem_ptr), hl
                             27 
   4032 C9            [10]   28 ret
