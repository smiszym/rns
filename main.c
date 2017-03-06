#include <stdio.h>
#include <stdlib.h>

#include "fib.h"
#include "nwd.h"
#include "sum.h"

static void disp_sum(ull x1, ull x0, ull y1, ull y0)
{
        ull result[2];
        sum(x1, x0, y1, y0, result);
        printf("(%.16llx:%.16llx) + (%.16llx:%.16llx) = (%.16llx:%.16llx)\n", x1, x0, y1, y0,
                        result[1], result[0]);
}

int main(int argc, char **argv)
{
        int i, a, b;
        unsigned long long result[2];

        for (i = 1; i < 20; ++i) {
                printf("fib(%d) = %d\n", i, fib(i));
        }

        for (i = 1; i < 20; ++i) {
                a = rand() % 100;
                b = rand() % 100;
                printf("nwd(%d, %d) = %d\n", a, b, nwd(a, b));
        }

        disp_sum(0x0000000000000001, 0x0000000000000040, 0x0000000000000300, 0x0000000000000030);
        disp_sum(0x0000000000000001, 0x9000000080000040, 0x0000000000000300, 0xa000000090000030);

        return 0;
}
