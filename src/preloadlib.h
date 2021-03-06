/*
    perf-libs-tools
    Copyright 2017 Arm Limited. 
    All rights reserved.
*/

#ifndef PRELOADLIB_DOT_H
#define PRELOADLIB_DOT_H

#include <stdio.h>
#include <stdlib.h>
#define _GNU_SOURCE
#define __GNU_SOURCE
#define  __USE_GNU
#include <dlfcn.h>

#ifdef LOGGING
#include "logging.h"
#else
#include "summary.h"
#endif

#define fftwplan fftwf_plan
typedef struct fftwf_plan_s *fftwf_plan;

/* ------------------------------------------------------------------ */

/* All lines containing _ARMPL_INT_T or INTEGER64 get          _ARMPL_INT_T
   filtered out of the distributed copy of armpl.h             _ARMPL_INT_T */
/* _ARMPL_INT_T The ARMPL integer type, either 32-bit or 64-bit */
#ifndef _ARMPL_INT_T
#define _ARMPL_INT_T
#ifdef INTEGER64
/* _ARMPL_INT_T  N.B. even in 64-bit integer variants of ARMPL, hidden
   _ARMPL_INT_T  Fortran string length arguments (type armpl_strlen_t)
   _ARMPL_INT_T  are of type int rather than long */
  typedef long armpl_int_t;                /* _ARMPL_INT_T */
  typedef unsigned long armpl_uint_t;      /* _ARMPL_INT_T */
  typedef int armpl_strlen_t;              /* _ARMPL_INT_T */
#else /* ! INTEGER64 */
  typedef int armpl_int_t;                 /* _ARMPL_INT_T */
  typedef unsigned int armpl_uint_t;       /* _ARMPL_INT_T */
  typedef int armpl_strlen_t;              /* _ARMPL_INT_T */
#endif /* ! INTEGER64 */
#endif /* _ARMPL_INT_T */
#define armpl_int_t_c armpl_int_t
#define armpl_int_t_c_d armpl_int_t
#define armpl_int_t_N armpl_int_t*
#define armpl_int_v armpl_int_t*
#define long_double long double
#define long_long long long

/* A complex datatype for use by the C interfaces to ARMPL routines */
#ifndef _ARMPL_ARMPL_SINGLECOMPLEX_T
#define _ARMPL_ARMPL_SINGLECOMPLEX_T
typedef struct
{
  float real, imag;
} armpl_singlecomplex_t;
typedef struct
{
  double real, imag;
} armpl_doublecomplex_t;
#endif /* !defined(_ARMPL_ARMPL_SINGLECOMPLEX_T) */


typedef armpl_int_t (* ARMPL_CGEES_SELECT)(armpl_singlecomplex_t *);
typedef armpl_int_t (* ARMPL_CGEESX_SELECT)(armpl_singlecomplex_t *);
typedef armpl_int_t (* ARMPL_CGGES_SELCTG)(armpl_singlecomplex_t *, armpl_singlecomplex_t *);
typedef armpl_int_t (* ARMPL_CGGESX_SELCTG)(armpl_singlecomplex_t *, armpl_singlecomplex_t *);
typedef armpl_int_t (* ARMPL_DGEES_SELECT)(double *, double *);
typedef armpl_int_t (* ARMPL_DGEESX_SELECT)(double *, double *);
typedef armpl_int_t (* ARMPL_DGGES_DELCTG)(double *, double *, double *);
typedef armpl_int_t (* ARMPL_DGGESX_DELCTG)(double *, double *, double *);
typedef armpl_int_t (* ARMPL_SGEES_SELECT)(float *, float *);
typedef armpl_int_t (* ARMPL_SGEESX_SELECT)(float *, float *);
typedef armpl_int_t (* ARMPL_SGGES_SELCTG)(float *, float *, float *);
typedef armpl_int_t (* ARMPL_SGGESX_SELCTG)(float *, float *, float *);
typedef armpl_int_t (* ARMPL_ZGEES_SELECT)(armpl_doublecomplex_t *);
typedef armpl_int_t (* ARMPL_ZGEESX_SELECT)(armpl_doublecomplex_t *);
typedef armpl_int_t (* ARMPL_ZGGES_DELCTG)(armpl_doublecomplex_t *, armpl_doublecomplex_t *);
typedef armpl_int_t (* ARMPL_ZGGESX_DELCTG)(armpl_doublecomplex_t *, armpl_doublecomplex_t *);




/* ------------------------------------------------------------------ */
// #include "armpl.h"

#endif
