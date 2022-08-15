#include "finite_state_machine.h"

machine build_machine(uint8_t pwm, uint8_t upper, uint8_t * port, uint8_t pin, uint16_t * scheduler){
  pwm %= BUDGET + 1;
  machine rtrn = {0,{upper - pwm ,pwm},upper,port,pin,(uint16_t *)scheduler};
  return rtrn;
}

void update_machine(machine * mach, uint8_t pwm){
  pwm %= BUDGET + 1;
  mach->bookings[1]= pwm;
  mach->bookings[0] = mach->upper - pwm;
}

void run_machine(machine * mach){
  *mach->scheduler = mach->bookings[mach->state];
  
  *mach->port |= (mach->state)<<mach->pin;
  *mach->port &= ~((!mach->state)<<mach->pin);
  
  mach->state = (mach->state + 1)%2;
}

void print_machine(machine mach){
  Serial.println("State:\t" + String(mach.state) + "\nSched:\t" + String(*mach.scheduler) + "\n");
}
