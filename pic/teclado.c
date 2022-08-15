#include "teclado.h"


const unsigned char linha[4]= {TL1,TL2,TL3};

unsigned char tc_tecla(unsigned int timeout)
{
  unsigned int to=0;
  unsigned char i;
  unsigned char ret=0;
  unsigned char tmp;

  tmp=PORTB;

  while(((to < timeout)||(!timeout))&&(!ret))
  {
    for(i=0;i<3;i++)
    {
      PORTB|=~linha[i];
      if(!TC1){delay_ms(20);if(!TC1){while(!TC1);ret= 1+i;break;}};
      if(!TC2){delay_ms(20);if(!TC2){while(!TC2);ret= 4+i;break;}};
      if(!TC3){delay_ms(20);if(!TC3){while(!TC3);ret= 7+i;break;}};
      if(!TC4){delay_ms(20);if(!TC4){while(!TC4);ret= 10+i;break;}};
      PORTB &=linha[i];
    };
    delay_ms(5);
    to+=5;
  }

  if(!ret)ret=255;
  if(ret == 11)ret=0;
  PORTB=tmp;
  return ret;
}