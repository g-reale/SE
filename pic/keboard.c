#include "keyboard.h"

menu m = {0,{0,1,2,3},{{0,1,0},{0,1,1},{0,1,2},{0,1,3},{0,1,4}}};

void send(){
     unsigned char msg[2];
     int i;
     for(i = 0; i < 4; i+=2)
           msg[i/2] = COLAPSE(m.value[i],m.value[i+1]);
     UART1_Write_Text((char *)msg);
}

unsigned char check_button(button * b){
     if(b->locked && (0 == (PORTB & (1<<b->index)))){
                  delay_ms(20);
                  b->state = !(PORTB & 1<<b->index);
                  b->locked = 0;
                  return 1;
     }
     else if(PORTB & 1<<b->index){
          b->locked = 1;
          b->state = 0;
     }

     return 0;
}

void update(){
     int i;
     
     if(check_button(&m.keys[0]))
          INCREMENT(m.value[m.focus],0,9,-1);
     else if(check_button(&m.keys[1]))
          INCREMENT(m.value[m.focus],0,9,1);
     else if(check_button(&m.keys[2]))
          INCREMENT(m.focus,0,3,1);
     else if(check_button(&m.keys[3]))
          INCREMENT(m.focus,0,3,-1);
     else if(check_button(&m.keys[4])){
          send();
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,1,"Sending");
          PORTC.RC1 = 1;
          for(i = 0; i < 3; i++){
                Lcd_Chr_CP('.');
                delay_ms(1000);
          }
          Lcd_Cmd(_LCD_CLEAR);
          PORTC.RC1 = 0;
          return;
     }
     
     Lcd_Out(1,1,"x:");
     for(i = 0; i < 2; i++)
           Lcd_Chr_CP(m.value[i] + TO_CHAR);
           
     Lcd_Out_CP(" y:");
     for(i = 2; i < 4; i++)
           Lcd_Chr_CP(m.value[i] + TO_CHAR);
}