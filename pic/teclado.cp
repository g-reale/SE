#line 1 "C:/Users/pamon/Desktop/pic/teclado.c"
#line 1 "c:/users/pamon/desktop/pic/teclado.h"









unsigned char tc_tecla(unsigned int timeout);
#line 4 "C:/Users/pamon/Desktop/pic/teclado.c"
const unsigned char linha[4]= { 0x01 , 0x02 , 0x04 };

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
 if(! RD3_bit ){delay_ms(20);if(! RD3_bit ){while(! RD3_bit );ret= 1+i;break;}};
 if(! RD2_bit ){delay_ms(20);if(! RD2_bit ){while(! RD2_bit );ret= 4+i;break;}};
 if(! RD1_bit ){delay_ms(20);if(! RD1_bit ){while(! RD1_bit );ret= 7+i;break;}};
 if(! RD0_bit ){delay_ms(20);if(! RD0_bit ){while(! RD0_bit );ret= 10+i;break;}};
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
