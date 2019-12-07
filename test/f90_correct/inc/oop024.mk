#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#


########## Make rule for test oop024  ########

fcheck.o check_mod.mod: $(SRC)/check_mod.f90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.f90 -o fcheck.o

oop024.o:  $(SRC)/oop024.f90 check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/oop024.f90 -o oop024.o

oop024: oop024.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) oop024.o fcheck.o $(LIBS) -o oop024

oop024.run: oop024
	@echo ------------------------------------ executing test oop024
	oop024
	-$(RM) shape_mod.mod

### TA Expected Targets ###

build: $(TEST)

.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
