
/*
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 */

#ifndef	COMMON_H
#define	COMMON_H


#include <math.h>

static inline float int_as_float(int a) { return *(float*)&a; }
static inline int float_as_int(float a) { return *(int*)&a; }

static float const TWO_TO_24_F = 16777216.0f;
static float const PINF = +INFINITY;
static float const NINF = -INFINITY;
static float const CANONICAL_NAN = -NAN;

const float ONE_F[]  __attribute__ ((aligned (64))) = {
    1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f,
    1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f
};

const float MAGIC_F[]  __attribute__ ((aligned (64))) = {
    0.7071067812f, 0.7071067812f, 0.7071067812f, 0.7071067812f,
    0.7071067812f, 0.7071067812f, 0.7071067812f, 0.7071067812f,
    0.7071067812f, 0.7071067812f, 0.7071067812f, 0.7071067812f,
    0.7071067812f, 0.7071067812f, 0.7071067812f, 0.7071067812f
};

const unsigned MANTISSA_MASK[]  __attribute__ ((aligned (64))) = {
    0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff,
    0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff, 0x7fffff
};

float const LOG_2_F[] __attribute__ ((aligned (64))) = {
     6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f,
     6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f,
     6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f,
     6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f, 6.93147181e-01f
};

const float c0[] __attribute__ ((aligned (64))) = {
     6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f,
     6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f,
     6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f,
     6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f, 6.76554069e-02f
};

const float c1[] __attribute__ ((aligned (64))) = {
    -1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,
    -1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,
    -1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,
    -1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f,-1.18248001e-01f
};

const float c2[] __attribute__ ((aligned (64))) = {
     1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f,
     1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f,
     1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f,
     1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f, 1.19646922e-01f
};

const float c3[] __attribute__ ((aligned (64))) = {
    -1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,
    -1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,
    -1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,
    -1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f,-1.23834148e-01f
};

const float c4[] __attribute__ ((aligned (64))) = {
     1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f,
     1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f,
     1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f,
     1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f, 1.42046005e-01f
};

const float c5[] __attribute__ ((aligned (64))) = {
    -1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,
    -1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,
    -1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,
    -1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f,-1.66688830e-01f
};

const float c6[] __attribute__ ((aligned (64))) = {
     2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f,
     2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f,
     2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f,
     2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f, 2.00030282e-01f
};

const float c7[] __attribute__ ((aligned (64))) = {
    -2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,
    -2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,
    -2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,
    -2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f,-2.50000030e-01f
};

const float c8[] __attribute__ ((aligned (64))) = {
     3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f,
     3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f,
     3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f,
     3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f, 3.33332956e-01f
};

const float c9[] __attribute__ ((aligned (64))) = {
    -0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f,
    -0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f,-0.5f
};

#endif
