#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
#
########## Make rule for test oop749a  ########


oop749a: run
	

build:  $(SRC)/oop749a.f90
	-$(RM) oop749a.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/oop749a.f90 -o oop749a.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) oop749a.$(OBJX) check.$(OBJX) $(LIBS) -o oop749a.$(EXESUFFIX)


run: 
	@echo ------------------------------------ executing test oop749a
	oop749a.$(EXESUFFIX)

verify: ;

