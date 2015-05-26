#line 1 "C:/Users/Oscar/Desktop/Proyecto Latidos/MyProject.c"

sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

char texto[15];
unsigned char primeraVez = 0;
unsigned int tiempo = 0;
float x = 0;
unsigned int pulso;

void interrupt(){
 if((INTCON.INT0IF==1) && (INTCON.INT0IE==1)){
 tiempo = TMR0L;
 tiempo = tiempo + (TMR0H << 8);
 TMR0H = 0;
 TMR0L = 0;
 x = 0.000064 * tiempo;
 pulso = (int) 60 / x;
 lcd_cmd(_lcd_clear);
 lcd_cmd(_lcd_cursor_off);
 IntToStr(pulso,texto);
 lcd_out(1,1,texto);


 INTCON.INT0IF=0;
 }
}

void main() {
 TRISB.B0=1;

 INTCON.INTEDG0=1;

 INTCON.INT0IF=0;
 INTCON.INT0IE=1;

 INTCON.GIE=1;
 INTCON.PEIE=0;
 RCON.IPEN=0;

 T0CON=0x06;
 TMR0H = 0;
 TMR0L = 0;
 T0CON.B7=1;

 lcd_init();

 while(1);
}
