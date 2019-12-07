!*** Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
!*** See https://llvm.org/LICENSE.txt for license information.
!*** SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
!
! simple derived type parameters
	subroutine sub(a,x)
	  type tscope
	     sequence
	     integer :: scope
	  end type
	  integer a
	  type(tscope)::x
	  type (tscope), parameter :: local = tscope(2)
	  type (tscope), parameter :: global = tscope(1)
	  select case(x%scope)
	  case(local%scope)
	    a = 11
	  case(global%scope)
	    a = 22
	  case default
	    a = 33
	  end select
	end subroutine

	program p
	  type tscope
	     sequence
	     integer :: scope
	  end type
	  interface
	    subroutine sub(a,x)
	     type tscope
		sequence
		integer :: scope
	     end type
	     integer a
	     type(tscope)::x
	    end subroutine
	  end interface
	  type(tscope)::l,g,m
	  integer result(3)
	  integer expect(3)
	  data expect/11,22,33/
	  l%scope = 2
	  g%scope = 1
	  m%scope = 3
	  call sub(result(1),l)
	  call sub(result(2),g)
	  call sub(result(3),m)
	  call check(result, expect, 3)
	end
