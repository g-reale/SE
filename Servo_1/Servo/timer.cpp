#include "timer.h"

void init_timer_1(){
  
  cli();
  TCCR1A = 0;// set entire TCCR1A register to 0
  TCCR1B = 0;// same for TCCR1B
  TCNT1  = 0;//initialize counter value to 0
  
  OCR1A = 0;
  TCCR1B |= (1 << WGM12);
  TCCR1B |= PRESCALER;  
  TIMSK1 |= (1 << OCIE1A);
  
  sei();
}

void init_timer_2(){
 
  cli();
  TCCR2A = 0;
  TCCR2B = 0;

  TCCR2B= PRESCALER;        //sets prescaler
  TCCR2A |= 1<<WGM01;       //turn on CTC mode
  TIMSK2 |= (1 << OCIE0A);  //enable timer compare interrupt

  TCNT2 = 0;                //rets timer 0
  OCR2A = 0;           //set books to TCNT0 == 156 ~ 50Hz
  sei();
}
