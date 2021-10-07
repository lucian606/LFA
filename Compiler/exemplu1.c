#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned long long int factorial(unsigned long long n) {
    // int result is where we keep the result
    unsigned result = 1;
    int step=1; /* int step is the number that we multiply the current result by
    int x = 42 
    char y = 20 */
    if (n == 0) {
        return 1;
    } else {
        for (step = 1; step <= n; step++) {
            result *= step;
        }
    }
    return result;
}

int global_element = 10;

void romanianSaying() {
    double y = 2;
    printf("Ana are %lf mere\n", y);
}

int main() {
    signed short int factorial_Result = factorial(global_element);
    char output_message[] = {"This is an output message"};
    float pi = 3.14f;
    return 0; 
}