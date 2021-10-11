.include "cpctelera.h.s"
.include "cpctelerafunction.h.s"
.include "entity_manager.h.s"

sys_input_init::
ret

sys_input_update::

    ld e_vx(ix), #0
    ld e_vy(ix), #0
        
    call cpct_scanKeyboard_f_asm

    ld hl, #Key_O
    call cpct_isKeyPressed_asm
    jr z, O_NotPressed

O_Pressed:
    ld e_vx(ix), #-1
O_NotPressed:
    ld hl, #Key_P
    call cpct_isKeyPressed_asm
    jr z, P_NotPressed
P_Pressed:
    ld e_vx(ix), #1
P_NotPressed:

    ld hl, #Key_Q
    call cpct_isKeyPressed_asm
    jr z, Q_NotPressed

Q_Pressed:
    ld e_vy(ix), #-2
Q_NotPressed:
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jr z, A_NotPressed
A_Pressed:
    ld e_vy(ix), #2
A_NotPressed:
    ld hl, #Key_W
    call cpct_isKeyPressed_asm
    jr z, W_Not_Pressed
W_Pressed:
    ld a, e_lantr(ix)  
    xor a, #01
    ld e_lantr(ix), a
    ;;xor e_lantr(ix), #01
W_Not_Pressed:

    ld e_ai_aim_x(ix), #0
    ld hl, #Key_Space
    call cpct_isKeyPressed_asm
    jr z, Spc_NotPressed

Spc_Pressed:

    ld e_ai_aim_x(ix), #1

Spc_NotPressed:



ret
