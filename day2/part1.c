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
        int count = 0;
        for (char* c = password; *c; c++)
            if (*c == letter)
                count++;
        if (count >= min && count <= max)
            valid++;
    }
    printf("VALID: %d\n ", valid);
}