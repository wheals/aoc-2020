#include <stdio.h>

#define BUFSZ 100
#define BUFSTR "100"

int main(void)
{
    int min, max;
    char letter;
    char password[BUFSZ];
    FILE* input = fopen("input.txt", "r");
    int valid = 0;

    while (!feof(input))
    {
        fscanf(input, "%d-%d %c: %" BUFSTR "s", &min, &max, &letter, password);
        valid += password[min - 1] == letter ^ password[max - 1] == letter;
    }
    printf("VALID: %d\n ", valid);
}