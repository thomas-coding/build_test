/*
 * Copyright (c) 2021-2031, Jinping Wu. All rights reserved.
 *
 * SPDX-License-Identifier: MIT
 */

#include <stdio.h>
#include <sub.h>

int main(void)
{
    int a = 4;
    int b = 5;
    printf("%s: value:%d\n",__func__, add(a,b));
}
