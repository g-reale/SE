
_tc_tecla:

;teclado.c,6 :: 		unsigned char tc_tecla(unsigned int timeout)
;teclado.c,8 :: 		unsigned int to=0;
	CLRF        tc_tecla_to_L0+0 
	CLRF        tc_tecla_to_L0+1 
	CLRF        tc_tecla_ret_L0+0 
;teclado.c,13 :: 		tmp=PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       R2 
;teclado.c,15 :: 		while(((to < timeout)||(!timeout))&&(!ret))
L_tc_tecla0:
	MOVF        FARG_tc_tecla_timeout+1, 0 
	SUBWF       tc_tecla_to_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tc_tecla35
	MOVF        FARG_tc_tecla_timeout+0, 0 
	SUBWF       tc_tecla_to_L0+0, 0 
L__tc_tecla35:
	BTFSS       STATUS+0, 0 
	GOTO        L__tc_tecla33
	MOVF        FARG_tc_tecla_timeout+0, 0 
	IORWF       FARG_tc_tecla_timeout+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__tc_tecla33
	GOTO        L_tc_tecla1
L__tc_tecla33:
	MOVF        tc_tecla_ret_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_tc_tecla1
L__tc_tecla32:
;teclado.c,17 :: 		for(i=0;i<3;i++)
	CLRF        R1 
L_tc_tecla6:
	MOVLW       3
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_tc_tecla7
;teclado.c,19 :: 		PORTB|=~linha[i];
	MOVLW       _linha+0
	ADDWF       R1, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_linha+0)
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      TBLPTR+1, 1 
	MOVLW       higher_addr(_linha+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	COMF        R0, 1 
	MOVF        R0, 0 
	IORWF       PORTB+0, 1 
;teclado.c,20 :: 		if(!TC1){delay_ms(20);if(!TC1){while(!TC1);ret= 1+i;break;}};
	BTFSC       RD3_bit+0, BitPos(RD3_bit+0) 
	GOTO        L_tc_tecla9
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_tc_tecla10:
	DECFSZ      R13, 1, 1
	BRA         L_tc_tecla10
	DECFSZ      R12, 1, 1
	BRA         L_tc_tecla10
	NOP
	NOP
	BTFSC       RD3_bit+0, BitPos(RD3_bit+0) 
	GOTO        L_tc_tecla11
L_tc_tecla12:
	BTFSC       RD3_bit+0, BitPos(RD3_bit+0) 
	GOTO        L_tc_tecla13
	GOTO        L_tc_tecla12
L_tc_tecla13:
	MOVF        R1, 0 
	ADDLW       1
	MOVWF       tc_tecla_ret_L0+0 
	GOTO        L_tc_tecla7
L_tc_tecla11:
L_tc_tecla9:
;teclado.c,21 :: 		if(!TC2){delay_ms(20);if(!TC2){while(!TC2);ret= 4+i;break;}};
	BTFSC       RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_tc_tecla14
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_tc_tecla15:
	DECFSZ      R13, 1, 1
	BRA         L_tc_tecla15
	DECFSZ      R12, 1, 1
	BRA         L_tc_tecla15
	NOP
	NOP
	BTFSC       RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_tc_tecla16
L_tc_tecla17:
	BTFSC       RD2_bit+0, BitPos(RD2_bit+0) 
	GOTO        L_tc_tecla18
	GOTO        L_tc_tecla17
L_tc_tecla18:
	MOVF        R1, 0 
	ADDLW       4
	MOVWF       tc_tecla_ret_L0+0 
	GOTO        L_tc_tecla7
L_tc_tecla16:
L_tc_tecla14:
;teclado.c,22 :: 		if(!TC3){delay_ms(20);if(!TC3){while(!TC3);ret= 7+i;break;}};
	BTFSC       RD1_bit+0, BitPos(RD1_bit+0) 
	GOTO        L_tc_tecla19
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_tc_tecla20:
	DECFSZ      R13, 1, 1
	BRA         L_tc_tecla20
	DECFSZ      R12, 1, 1
	BRA         L_tc_tecla20
	NOP
	NOP
	BTFSC       RD1_bit+0, BitPos(RD1_bit+0) 
	GOTO        L_tc_tecla21
L_tc_tecla22:
	BTFSC       RD1_bit+0, BitPos(RD1_bit+0) 
	GOTO        L_tc_tecla23
	GOTO        L_tc_tecla22
L_tc_tecla23:
	MOVF        R1, 0 
	ADDLW       7
	MOVWF       tc_tecla_ret_L0+0 
	GOTO        L_tc_tecla7
L_tc_tecla21:
L_tc_tecla19:
;teclado.c,23 :: 		if(!TC4){delay_ms(20);if(!TC4){while(!TC4);ret= 10+i;break;}};
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_tc_tecla24
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_tc_tecla25:
	DECFSZ      R13, 1, 1
	BRA         L_tc_tecla25
	DECFSZ      R12, 1, 1
	BRA         L_tc_tecla25
	NOP
	NOP
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_tc_tecla26
L_tc_tecla27:
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_tc_tecla28
	GOTO        L_tc_tecla27
L_tc_tecla28:
	MOVF        R1, 0 
	ADDLW       10
	MOVWF       tc_tecla_ret_L0+0 
	GOTO        L_tc_tecla7
L_tc_tecla26:
L_tc_tecla24:
;teclado.c,24 :: 		PORTB &=linha[i];
	MOVLW       _linha+0
	ADDWF       R1, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_linha+0)
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      TBLPTR+1, 1 
	MOVLW       higher_addr(_linha+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 0 
	ANDWF       PORTB+0, 1 
;teclado.c,17 :: 		for(i=0;i<3;i++)
	INCF        R1, 1 
;teclado.c,25 :: 		};
	GOTO        L_tc_tecla6
L_tc_tecla7:
;teclado.c,26 :: 		delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_tc_tecla29:
	DECFSZ      R13, 1, 1
	BRA         L_tc_tecla29
	DECFSZ      R12, 1, 1
	BRA         L_tc_tecla29
	NOP
	NOP
;teclado.c,27 :: 		to+=5;
	MOVLW       5
	ADDWF       tc_tecla_to_L0+0, 1 
	MOVLW       0
	ADDWFC      tc_tecla_to_L0+1, 1 
;teclado.c,28 :: 		}
	GOTO        L_tc_tecla0
L_tc_tecla1:
;teclado.c,30 :: 		if(!ret)ret=255;
	MOVF        tc_tecla_ret_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_tc_tecla30
	MOVLW       255
	MOVWF       tc_tecla_ret_L0+0 
L_tc_tecla30:
;teclado.c,31 :: 		if(ret == 11)ret=0;
	MOVF        tc_tecla_ret_L0+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_tc_tecla31
	CLRF        tc_tecla_ret_L0+0 
L_tc_tecla31:
;teclado.c,32 :: 		PORTB=tmp;
	MOVF        R2, 0 
	MOVWF       PORTB+0 
;teclado.c,33 :: 		return ret;
	MOVF        tc_tecla_ret_L0+0, 0 
	MOVWF       R0 
;teclado.c,34 :: 		}
L_end_tc_tecla:
	RETURN      0
; end of _tc_tecla
