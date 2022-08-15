
_send:

;keboard.c,5 :: 		void send(){
;keboard.c,8 :: 		for(i = 0; i < 4; i+=2)
	CLRF        send_i_L0+0 
	CLRF        send_i_L0+1 
L_send0:
	MOVLW       128
	XORWF       send_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__send46
	MOVLW       4
	SUBWF       send_i_L0+0, 0 
L__send46:
	BTFSC       STATUS+0, 0 
	GOTO        L_send1
;keboard.c,9 :: 		msg[i/2] = COLAPSE(m.value[i],m.value[i+1]);
	MOVF        send_i_L0+0, 0 
	MOVWF       R0 
	MOVF        send_i_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	BTFSS       R1, 7 
	GOTO        L__send47
	BTFSS       STATUS+0, 0 
	GOTO        L__send47
	INFSNZ      R0, 1 
	INCF        R1, 1 
L__send47:
	MOVLW       send_msg_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(send_msg_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1L+1 
	MOVF        send_i_L0+0, 0 
	MOVWF       R0 
	MOVF        send_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R5 
	MOVLW       1
	ADDWF       send_i_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      send_i_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR2L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       R5, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;keboard.c,8 :: 		for(i = 0; i < 4; i+=2)
	MOVLW       2
	ADDWF       send_i_L0+0, 1 
	MOVLW       0
	ADDWFC      send_i_L0+1, 1 
;keboard.c,9 :: 		msg[i/2] = COLAPSE(m.value[i],m.value[i+1]);
	GOTO        L_send0
L_send1:
;keboard.c,10 :: 		UART1_Write_Text((char *)msg);
	MOVLW       send_msg_L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(send_msg_L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;keboard.c,11 :: 		}
L_end_send:
	RETURN      0
; end of _send

_check_button:

;keboard.c,13 :: 		unsigned char check_button(button * b){
;keboard.c,14 :: 		if(b->locked && (0 == (PORTB & (1<<b->index)))){
	MOVLW       1
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_check_button5
	MOVLW       2
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__check_button49:
	BZ          L__check_button50
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__check_button49
L__check_button50:
	MOVF        R0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R1, 0 
	MOVWF       R3 
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_button51
	MOVF        R2, 0 
	XORLW       0
L__check_button51:
	BTFSS       STATUS+0, 2 
	GOTO        L_check_button5
L__check_button44:
;keboard.c,15 :: 		delay_ms(20);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_check_button6:
	DECFSZ      R13, 1, 1
	BRA         L_check_button6
	DECFSZ      R12, 1, 1
	BRA         L_check_button6
	NOP
	NOP
;keboard.c,16 :: 		b->state = !(PORTB & 1<<b->index);
	MOVLW       2
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__check_button52:
	BZ          L__check_button53
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__check_button52
L__check_button53:
	MOVF        R0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	IORWF       R3, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVFF       FARG_check_button_b+0, FSR1L+0
	MOVFF       FARG_check_button_b+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;keboard.c,17 :: 		b->locked = 0;
	MOVLW       1
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;keboard.c,18 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_check_button
;keboard.c,19 :: 		}
L_check_button5:
;keboard.c,20 :: 		else if(PORTB & 1<<b->index){
	MOVLW       2
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__check_button54:
	BZ          L__check_button55
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__check_button54
L__check_button55:
	MOVF        PORTB+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_check_button8
;keboard.c,21 :: 		b->locked = 1;
	MOVLW       1
	ADDWF       FARG_check_button_b+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_check_button_b+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;keboard.c,22 :: 		b->state = 0;
	MOVFF       FARG_check_button_b+0, FSR1L+0
	MOVFF       FARG_check_button_b+1, FSR1H+0
	CLRF        POSTINC1+0 
;keboard.c,23 :: 		}
L_check_button8:
;keboard.c,25 :: 		return 0;
	CLRF        R0 
;keboard.c,26 :: 		}
L_end_check_button:
	RETURN      0
; end of _check_button

_update:

;keboard.c,28 :: 		void update(){
;keboard.c,31 :: 		if(check_button(&m.keys[0]))
	MOVLW       _m+10
	MOVWF       FARG_check_button_b+0 
	MOVLW       hi_addr(_m+10)
	MOVWF       FARG_check_button_b+1 
	CALL        _check_button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_update9
;keboard.c,32 :: 		INCREMENT(m.value[m.focus],0,9,-1);
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVLW       255
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       255
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L+0
	MOVFF       R6, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update57
	MOVLW       0
	SUBWF       R1, 0 
L__update57:
	BTFSC       STATUS+0, 0 
	GOTO        L_update10
	MOVLW       9
	MOVWF       ?FLOC___updateT77+0 
	MOVLW       0
	MOVWF       ?FLOC___updateT77+1 
	GOTO        L_update11
L_update10:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update58
	MOVF        R1, 0 
	SUBLW       9
L__update58:
	BTFSC       STATUS+0, 0 
	GOTO        L_update12
	CLRF        R3 
	CLRF        R4 
	GOTO        L_update13
L_update12:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
L_update13:
	MOVF        R3, 0 
	MOVWF       ?FLOC___updateT77+0 
	MOVF        R4, 0 
	MOVWF       ?FLOC___updateT77+1 
L_update11:
	MOVFF       R5, FSR1L+0
	MOVFF       R6, FSR1H+0
	MOVF        ?FLOC___updateT77+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        ?FLOC___updateT77+1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_update14
L_update9:
;keboard.c,33 :: 		else if(check_button(&m.keys[1]))
	MOVLW       _m+13
	MOVWF       FARG_check_button_b+0 
	MOVLW       hi_addr(_m+13)
	MOVWF       FARG_check_button_b+1 
	CALL        _check_button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_update15
;keboard.c,34 :: 		INCREMENT(m.value[m.focus],0,9,1);
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVFF       R5, FSR0L+0
	MOVFF       R6, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update59
	MOVLW       0
	SUBWF       R1, 0 
L__update59:
	BTFSC       STATUS+0, 0 
	GOTO        L_update16
	MOVLW       9
	MOVWF       ?FLOC___updateT103+0 
	MOVLW       0
	MOVWF       ?FLOC___updateT103+1 
	GOTO        L_update17
L_update16:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update60
	MOVF        R1, 0 
	SUBLW       9
L__update60:
	BTFSC       STATUS+0, 0 
	GOTO        L_update18
	CLRF        R3 
	CLRF        R4 
	GOTO        L_update19
L_update18:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
L_update19:
	MOVF        R3, 0 
	MOVWF       ?FLOC___updateT103+0 
	MOVF        R4, 0 
	MOVWF       ?FLOC___updateT103+1 
L_update17:
	MOVFF       R5, FSR1L+0
	MOVFF       R6, FSR1H+0
	MOVF        ?FLOC___updateT103+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        ?FLOC___updateT103+1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_update20
L_update15:
;keboard.c,35 :: 		else if(check_button(&m.keys[2]))
	MOVLW       _m+16
	MOVWF       FARG_check_button_b+0 
	MOVLW       hi_addr(_m+16)
	MOVWF       FARG_check_button_b+1 
	CALL        _check_button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_update21
;keboard.c,36 :: 		INCREMENT(m.focus,0,3,1);
	MOVLW       1
	ADDWF       _m+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _m+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _m+0 
	MOVF        R1, 0 
	MOVWF       _m+1 
	MOVLW       128
	XORWF       _m+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update61
	MOVLW       0
	SUBWF       _m+0, 0 
L__update61:
	BTFSC       STATUS+0, 0 
	GOTO        L_update22
	MOVLW       3
	MOVWF       ?FLOC___updateT118+0 
	MOVLW       0
	MOVWF       ?FLOC___updateT118+1 
	GOTO        L_update23
L_update22:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _m+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update62
	MOVF        _m+0, 0 
	SUBLW       3
L__update62:
	BTFSC       STATUS+0, 0 
	GOTO        L_update24
	CLRF        R0 
	CLRF        R1 
	GOTO        L_update25
L_update24:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
L_update25:
	MOVF        R0, 0 
	MOVWF       ?FLOC___updateT118+0 
	MOVF        R1, 0 
	MOVWF       ?FLOC___updateT118+1 
L_update23:
	MOVF        ?FLOC___updateT118+0, 0 
	MOVWF       _m+0 
	MOVF        ?FLOC___updateT118+1, 0 
	MOVWF       _m+1 
	GOTO        L_update26
L_update21:
;keboard.c,37 :: 		else if(check_button(&m.keys[3]))
	MOVLW       _m+19
	MOVWF       FARG_check_button_b+0 
	MOVLW       hi_addr(_m+19)
	MOVWF       FARG_check_button_b+1 
	CALL        _check_button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_update27
;keboard.c,38 :: 		INCREMENT(m.focus,0,3,-1);
	MOVLW       255
	ADDWF       _m+0, 0 
	MOVWF       R1 
	MOVLW       255
	ADDWFC      _m+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _m+0 
	MOVF        R2, 0 
	MOVWF       _m+1 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update63
	MOVLW       0
	SUBWF       R1, 0 
L__update63:
	BTFSC       STATUS+0, 0 
	GOTO        L_update28
	MOVLW       3
	MOVWF       ?FLOC___updateT125+0 
	MOVLW       0
	MOVWF       ?FLOC___updateT125+1 
	GOTO        L_update29
L_update28:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _m+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update64
	MOVF        _m+0, 0 
	SUBLW       3
L__update64:
	BTFSC       STATUS+0, 0 
	GOTO        L_update30
	CLRF        R0 
	CLRF        R1 
	GOTO        L_update31
L_update30:
	MOVF        _m+0, 0 
	MOVWF       R0 
	MOVF        _m+1, 0 
	MOVWF       R1 
L_update31:
	MOVF        R0, 0 
	MOVWF       ?FLOC___updateT125+0 
	MOVF        R1, 0 
	MOVWF       ?FLOC___updateT125+1 
L_update29:
	MOVF        ?FLOC___updateT125+0, 0 
	MOVWF       _m+0 
	MOVF        ?FLOC___updateT125+1, 0 
	MOVWF       _m+1 
	GOTO        L_update32
L_update27:
;keboard.c,39 :: 		else if(check_button(&m.keys[4])){
	MOVLW       _m+22
	MOVWF       FARG_check_button_b+0 
	MOVLW       hi_addr(_m+22)
	MOVWF       FARG_check_button_b+1 
	CALL        _check_button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_update33
;keboard.c,40 :: 		send();
	CALL        _send+0, 0
;keboard.c,41 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keboard.c,42 :: 		Lcd_Out(1,1,"Sending");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_keboard+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_keboard+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keboard.c,43 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;keboard.c,44 :: 		for(i = 0; i < 3; i++){
	CLRF        update_i_L0+0 
	CLRF        update_i_L0+1 
L_update34:
	MOVLW       128
	XORWF       update_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update65
	MOVLW       3
	SUBWF       update_i_L0+0, 0 
L__update65:
	BTFSC       STATUS+0, 0 
	GOTO        L_update35
;keboard.c,45 :: 		Lcd_Chr_CP('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keboard.c,46 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_update37:
	DECFSZ      R13, 1, 1
	BRA         L_update37
	DECFSZ      R12, 1, 1
	BRA         L_update37
	DECFSZ      R11, 1, 1
	BRA         L_update37
	NOP
	NOP
;keboard.c,44 :: 		for(i = 0; i < 3; i++){
	INFSNZ      update_i_L0+0, 1 
	INCF        update_i_L0+1, 1 
;keboard.c,47 :: 		}
	GOTO        L_update34
L_update35:
;keboard.c,48 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keboard.c,49 :: 		PORTC.RC1 = 0;
	BCF         PORTC+0, 1 
;keboard.c,50 :: 		return;
	GOTO        L_end_update
;keboard.c,51 :: 		}
L_update33:
L_update32:
L_update26:
L_update20:
L_update14:
;keboard.c,53 :: 		Lcd_Out(1,1,"x:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_keboard+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_keboard+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keboard.c,54 :: 		for(i = 0; i < 2; i++)
	CLRF        update_i_L0+0 
	CLRF        update_i_L0+1 
L_update38:
	MOVLW       128
	XORWF       update_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update66
	MOVLW       2
	SUBWF       update_i_L0+0, 0 
L__update66:
	BTFSC       STATUS+0, 0 
	GOTO        L_update39
;keboard.c,55 :: 		Lcd_Chr_CP(m.value[i] + TO_CHAR);
	MOVF        update_i_L0+0, 0 
	MOVWF       R0 
	MOVF        update_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keboard.c,54 :: 		for(i = 0; i < 2; i++)
	INFSNZ      update_i_L0+0, 1 
	INCF        update_i_L0+1, 1 
;keboard.c,55 :: 		Lcd_Chr_CP(m.value[i] + TO_CHAR);
	GOTO        L_update38
L_update39:
;keboard.c,57 :: 		Lcd_Out_CP(" y:");
	MOVLW       ?lstr3_keboard+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr3_keboard+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;keboard.c,58 :: 		for(i = 2; i < 4; i++)
	MOVLW       2
	MOVWF       update_i_L0+0 
	MOVLW       0
	MOVWF       update_i_L0+1 
L_update41:
	MOVLW       128
	XORWF       update_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update67
	MOVLW       4
	SUBWF       update_i_L0+0, 0 
L__update67:
	BTFSC       STATUS+0, 0 
	GOTO        L_update42
;keboard.c,59 :: 		Lcd_Chr_CP(m.value[i] + TO_CHAR);
	MOVF        update_i_L0+0, 0 
	MOVWF       R0 
	MOVF        update_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _m+2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_m+2)
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	ADDWF       POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keboard.c,58 :: 		for(i = 2; i < 4; i++)
	INFSNZ      update_i_L0+0, 1 
	INCF        update_i_L0+1, 1 
;keboard.c,59 :: 		Lcd_Chr_CP(m.value[i] + TO_CHAR);
	GOTO        L_update41
L_update42:
;keboard.c,60 :: 		}
L_end_update:
	RETURN      0
; end of _update
