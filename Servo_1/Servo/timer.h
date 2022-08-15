#ifndef timer
#define timer
#include "Arduino.h"

#define PRESCALER 1<<CS02 | 1<<CS00

void init_timer_2();
void init_timer_1();
#endif
