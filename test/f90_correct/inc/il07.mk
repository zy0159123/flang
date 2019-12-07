#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#

########## Make rule for test il07  ########


il07: run
	

build:  $(SRC)/il07.f90
	-$(RM) il07.$(EXESUFFIX) core *.d *.mod FOR*.DAT FTN* ftn* fort.*
	@echo ------------------------------------ building test $@
	-$(CC) -c $(CFLAGS) $(SRC)/check.c -o check.$(OBJX)
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/il07.f90 -o il07.$(OBJX)
	-$(FC) $(FFLAGS) $(LDFLAGS) il07.$(OBJX) check.$(OBJX) $(LIBS) -o il07.$(EXESUFFIX)


run:
	@echo ------------------------------------ executing test il07
	il07.$(EXESUFFIX)

verify: ;

il07.run: run

