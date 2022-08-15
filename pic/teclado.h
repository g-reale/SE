#define TL1 0x01
#define TL2 0x02
#define TL3 0x04

#define TC1 RD3_bit
#define TC2 RD2_bit
#define TC3 RD1_bit
#define TC4 RD0_bit

unsigned char tc_tecla(unsigned int timeout); /*timeout=0 no time out*/