#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int something = 1;

unsigned char toUpper(char c, signed notUsed) {
    unsigned result = (int) c;
    return result - 32;
}

float func(int a, double b) {
    long double result;
    result = a;
    result -= b;
    return (float) result;
}

void main() {
    int a = 1;
    float v[] = {2.3f, 21.2,32.3f};
    signed c = 2;
}