#line 1 "C:/Users/pamon/Desktop/pic/MyProject.c"
#line 1 "c:/users/pamon/desktop/pic/keyboard.h"





typedef struct{
 unsigned char state;
 unsigned char locked;
 unsigned char index;
}button;

typedef struct{
 int focus;
 int value[4];
 button keys[5];
}menu;

void update();
void send();
#line 3 "C:/Users/pamon/Desktop/pic/MyProject.c"
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

int main(){
 ADCON1 = 0x0F;
  (TRISB |= 0b00011111, TRISC.RC1 = 0) ;

 UART1_Init(9600);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);

 while(1){
 update();
 }

}
