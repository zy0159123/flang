!
! Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
! See https://llvm.org/LICENSE.txt for license information.
! SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!

module ieee_helper
  use ieee_arithmetic

  interface __pgfortran_gen_div_by_zero
    module procedure gen_div_by_zero, gen_div_by_zeror4, gen_div_by_zeror8
  end interface

  interface __pgfortran_gen_overflow
    module procedure gen_overflow, gen_overflowr4, gen_overflowr8
  end interface

  interface __pgfortran_gen_underflow
    module procedure gen_underflow, gen_underflowr4, gen_underflowr8
  end interface

  interface __pgfortran_gen_invalid
    module procedure gen_invalid, gen_invalidr4, gen_invalidr8
  end interface

  interface __pgfortran_gen_inexact
    module procedure gen_inexact, gen_inexactr4, gen_inexactr8
  end interface

  interface __pgfortran_gen_safe_op
    module procedure gen_safe_op, gen_safe_opr4, gen_safe_opr8
  end interface

  private gen_div_by_zero, gen_div_by_zeror4, gen_div_by_zeror8
  private gen_overflow, gen_overflowr4, gen_overflowr8
  private gen_underflow, gen_underflowr4, gen_underflowr8
  private gen_invalid, gen_invalidr4, gen_invalidr8
  private gen_inexact, gen_inexactr4, gen_inexactr8
  private gen_safe_op, gen_safe_opr4, gen_safe_opr8

  logical dummy

contains

  ! These routines should produce a divide by zero
  subroutine gen_div_by_zero()
  real y, z
  y = ieee_value(y, ieee_positive_normal)
  z = ieee_value(z, ieee_positive_zero)
  y = y / z
  dummy = (ieee_class(y) .eq. ieee_positive_inf)
  return
  end

  subroutine gen_div_by_zeror4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z
  y = ieee_value(x, ieee_positive_normal)
  z = ieee_value(x, ieee_positive_zero)
  y = y / z
  dummy = (ieee_class(y) .eq. ieee_positive_inf)
  return
  end

  subroutine gen_div_by_zeror8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z
  y = ieee_value(x, ieee_positive_normal)
  z = ieee_value(x, ieee_positive_zero)
  y = y / z
  dummy = (ieee_class(y) .eq. ieee_positive_inf)
  return
  end

  ! These routines should produce an overflow
  subroutine gen_overflow()
  real y, z
  y = ieee_next_after(huge(y),huge(y))
  z = y + y
  dummy = (ieee_class(z) .eq. ieee_positive_inf)
  return
  end

  subroutine gen_overflowr4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z
  y = ieee_next_after(huge(x),huge(x))
  z = y + y
  dummy = (ieee_class(z) .eq. ieee_positive_inf)
  return
  end

  subroutine gen_overflowr8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z
  y = ieee_next_after(huge(x),huge(x))
  z = y + y
  dummy = (ieee_class(z) .eq. ieee_positive_inf)
  return
  end

  ! These routines should produce an underflow
  subroutine gen_underflow()
  real y, z
  y = ieee_next_after(tiny(y),tiny(y))
  z = y * y
  dummy = (ieee_class(z) .eq. ieee_positive_zero)
  return
  end

  subroutine gen_underflowr4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z
  y = ieee_next_after(tiny(x),tiny(x))
  z = y * y
  dummy = (ieee_class(z) .eq. ieee_positive_zero)
  return
  end

  subroutine gen_underflowr8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z
  y = ieee_next_after(tiny(x),tiny(x))
  z = y * y
  dummy = (ieee_class(z) .eq. ieee_positive_zero)
  return
  end

  ! These routines should get invalid
  subroutine gen_invalid()
  real y, z
  y = ieee_value(y, ieee_negative_normal)
  z = sqrt(y)
  dummy = (ieee_class(z) .eq. ieee_signaling_nan)
  return
  end

  subroutine gen_invalidr4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z
  y = ieee_value(x, ieee_positive_inf)
  z = ieee_value(x, ieee_negative_inf)
  z = z + y
  dummy = (ieee_class(z) .eq. ieee_positive_zero)
! These seem to not work with -Mfprelaxed on Intel architecture
! y = ieee_value(x, ieee_negative_normal)
! z = sqrt(y)
! dummy = (ieee_class(z) .eq. ieee_signaling_nan)
  return
  end

  subroutine gen_invalidr8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z
  y = ieee_value(x, ieee_negative_normal)
  z = sqrt(y)
  dummy = (ieee_class(z) .eq. ieee_signaling_nan)
  return
  end

  ! These routines should get inexact
  ! Note, this might need to change if ieee_positive_normal value changes
  subroutine gen_inexact()
  real y, z, dn, up
  dn = ieee_value(x, ieee_positive_zero)
  y  = ieee_value(x, ieee_positive_normal)
  up = ieee_value(x, ieee_positive_inf)
  z = ieee_next_after(2*y, up)
  y = ieee_next_after(y, dn)
  z = z + y
  dummy = (ieee_class(z) .eq. ieee_positive_normal)
  return
  end

  subroutine gen_inexactr4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z, dn, up
  dn = ieee_value(x, ieee_positive_zero)
  y  = ieee_value(x, ieee_positive_normal)
  up = ieee_value(x, ieee_positive_inf)
  z = ieee_next_after(2*y, up)
  y = ieee_next_after(y, dn)
  z = z + y
  dummy = (ieee_class(z) .eq. ieee_positive_normal)
  return
  end

  subroutine gen_inexactr8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z, dn, up
  dn = ieee_value(x, ieee_positive_zero)
  y  = ieee_value(x, ieee_positive_normal)
  up = ieee_value(x, ieee_positive_inf)
  z = ieee_next_after(2*y, up)
  y = ieee_next_after(y, dn)
  z = z + y
  dummy = (ieee_class(z) .eq. ieee_positive_normal)
  return
  end

  ! These routines should produce a safe op with no exceptions
  subroutine gen_safe_op()
  real y, z
  y = ieee_value(y, ieee_positive_normal)
  z = ieee_value(z, ieee_positive_normal)
  y = y + z
  dummy = (ieee_class(y) .eq. ieee_positive_normal)
  return
  end

  subroutine gen_safe_opr4(x)
!dir$ ignore_tkr (r) x
  real*4 x, y, z
  y = ieee_value(x, ieee_positive_normal)
  z = ieee_value(x, ieee_positive_normal)
  y = y + z
  dummy = (ieee_class(y) .eq. ieee_positive_normal)
  return
  end

  subroutine gen_safe_opr8(x)
!dir$ ignore_tkr (r) x
  real*8 x, y, z
  y = ieee_value(x, ieee_positive_normal)
  z = ieee_value(x, ieee_positive_normal)
  y = y + z
  dummy = (ieee_class(y) .eq. ieee_positive_normal)
  return
  end
end module ieee_helper

program testieee_array
use ieee_exceptions
use ieee_helper
logical l1(5), l2(5), l3(5)
logical lfsav(5), lfset(5)
type(ieee_flag_type) :: a(2), b(3), c(4), d
!
real*4 ra, rb
ra = 1.0
rb = 2.0
!
a = (/ ieee_inexact, ieee_overflow /)
b = (/ ieee_overflow, ieee_divide_by_zero, ieee_invalid /)
c(1:3) = b
c(4) = ieee_denorm
d = ieee_underflow
!
l1 = .true.
l2 = .false.
print *,"Test ieee_get_flag"
!
lfset = .false.
call ieee_get_halting_mode(ieee_all, lfsav)
call ieee_set_halting_mode(ieee_all, lfset)
call forcekuflow()
!
call ieee_set_flag(a, l2(1:2))
call ieee_get_flag(a, l1(1:2))
call ieee_set_flag(b, l2(2:4))
call ieee_get_flag(b, l1(2:4))
call ieee_set_flag(d, l2(5))
call ieee_get_flag(d, l1(5))

call __pgfortran_gen_inexact(ra)
call __pgfortran_gen_overflow(ra)
call __pgfortran_gen_underflow(ra)
call __pgfortran_gen_div_by_zero(ra)
call __pgfortran_gen_invalid(ra)

call ieee_get_flag(a, l2(1:2))
call ieee_get_flag(b, l2(2:4))
call ieee_get_flag(d, l2(5))
!
l3 = .false.
call check(l1,l3,5)
l3 = .true.
call check(l2,l3,5)
call ieee_set_halting_mode(ieee_all, lfsav)
end

subroutine forcekuflow()
use ieee_arithmetic
call ieee_set_underflow_mode(.true.)
return
end

