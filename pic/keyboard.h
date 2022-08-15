#define TO_CHAR 48
#define Keyboard_Init()(TRISB |= 0b00011111, TRISC.RC1 = 0)
#define INCREMENT(number, mim, max, dir)(number += dir, number = number < mim ? max : number > max ? mim : number)
#define COLAPSE(number_1,number_2)(number_1 * 10 + number_2)

typedef struct{
        unsigned char state;
        unsigned char locked;
        unsigned char index;
}button;

typedef struct{
        int focus;
        int value[4];
        button keys[5];
}menu;

void update();
void send();