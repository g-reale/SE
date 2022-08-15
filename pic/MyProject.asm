
_main:

;MyProject.c,18 :: 		int main(){
;MyProject.c,19 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;MyProject.c,20 :: 		Keyboard_Init();
	MOVLW       31
	IORWF       TRISB+0, 1 
	BCF         TRISC+0, 1 
;MyProject.c,22 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,23 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;MyProject.c,24 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,25 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,27 :: 		while(1){
L_main0:
;MyProject.c,28 :: 		update();
	CALL        _update+0, 0
;MyProject.c,29 :: 		}
	GOTO        L_main0
;MyProject.c,31 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
