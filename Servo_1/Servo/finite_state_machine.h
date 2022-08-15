#ifndef finite_state
#define finite_state
#include "Arduino.h"
#define BUDGET 155

typedef struct m{
  uint8_t state;
  uint8_t bookings[2];
  uint8_t upper;
  
  uint8_t * port;
  uint8_t pin;

  uint16_t * scheduler;
}machine;
  
machine build_machine(uint8_t pwm, uint8_t upper, uint8_t * port, uint8_t pin, uint16_t * scheduler);
void update_machine(machine * mach,uint8_t pwm);
void run_machine(machine * mach);
void print_machine(machine mach);
#endif
