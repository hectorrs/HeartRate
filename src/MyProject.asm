
_interrupt:

;MyProject.c,23 :: 		void interrupt(){
;MyProject.c,24 :: 		if((INTCON.INT0IF==1) && (INTCON.INT0IE==1)){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt2
	BTFSS       INTCON+0, 4 
	GOTO        L_interrupt2
L__interrupt5:
;MyProject.c,25 :: 		tiempo = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _tiempo+0 
	MOVLW       0
	MOVWF       _tiempo+1 
;MyProject.c,26 :: 		tiempo = tiempo + (TMR0H << 8);
	MOVF        TMR0H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        _tiempo+0, 0 
	ADDWF       R0, 1 
	MOVF        _tiempo+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _tiempo+0 
	MOVF        R1, 0 
	MOVWF       _tiempo+1 
;MyProject.c,27 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;MyProject.c,28 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;MyProject.c,29 :: 		x = 0.000064 * tiempo;  // Prescaler = 128
	CALL        _Word2Double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       113
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _x+0 
	MOVF        R1, 0 
	MOVWF       _x+1 
	MOVF        R2, 0 
	MOVWF       _x+2 
	MOVF        R3, 0 
	MOVWF       _x+3 
;MyProject.c,30 :: 		pulso = (int) 60 / x;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       112
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _pulso+0 
	MOVF        R1, 0 
	MOVWF       _pulso+1 
;MyProject.c,31 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,32 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,33 :: 		IntToStr(pulso,texto);
	MOVF        _pulso+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _pulso+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _texto+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;MyProject.c,34 :: 		lcd_out(1,1,texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _texto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,37 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;MyProject.c,38 :: 		}
L_interrupt2:
;MyProject.c,39 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;MyProject.c,41 :: 		void main() {
;MyProject.c,42 :: 		TRISB.B0=1;
	BSF         TRISB+0, 0 
;MyProject.c,44 :: 		INTCON.INTEDG0=1;
	BSF         INTCON+0, 6 
;MyProject.c,46 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;MyProject.c,47 :: 		INTCON.INT0IE=1;
	BSF         INTCON+0, 4 
;MyProject.c,49 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;MyProject.c,50 :: 		INTCON.PEIE=0;
	BCF         INTCON+0, 6 
;MyProject.c,51 :: 		RCON.IPEN=0;
	BCF         RCON+0, 7 
;MyProject.c,53 :: 		T0CON=0x06;
	MOVLW       6
	MOVWF       T0CON+0 
;MyProject.c,54 :: 		TMR0H = 0;
	CLRF        TMR0H+0 
;MyProject.c,55 :: 		TMR0L = 0;
	CLRF        TMR0L+0 
;MyProject.c,56 :: 		T0CON.B7=1;
	BSF         T0CON+0, 7 
;MyProject.c,58 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;MyProject.c,60 :: 		while(1);
L_main3:
	GOTO        L_main3
;MyProject.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
