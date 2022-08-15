#define Seg_Init()(TRISD = 0x00, TRISA &= 0b11000011)
#define Seg_Write(position,symbol)(PORTA |= 1 << ((position + 2)%6), PORTD = symbol)