#include "timer.h"
#include "finite_state_machine.h"

machine m_t1 = build_machine(50,BUDGET,&PORTB,5,(uint16_t *)&OCR1A);
machine m_t2 = build_machine(140,BUDGET,&PORTB,4,(uint16_t *)&OCR2A);

ISR(TIMER2_COMPA_vect){
  run_machine(&m_t2);
}

ISR(TIMER1_COMPA_vect){
  run_machine(&m_t1);
}


void setup() {
  DDRB |= 1 << 5 | 1 << 4;        
  Serial.begin(9600);
  init_timer_2();
  init_timer_1();
}

void loop() {
  if(Serial.available() >= 2){
    update_machine(&m_t1,Serial.read());
    update_machine(&m_t2,Serial.read());
  } 
}
