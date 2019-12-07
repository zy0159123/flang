#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
pv01: pv01.$(OBJX)
	@echo ------------ executing test $@
	-$(RUN4) ./a.$(EXESUFFIX) $(LOG)
pv01.$(OBJX): $(SRC)/pv01.f90 check.$(OBJX)
	@echo ------------ building test $@
	-$(F90) $(FFLAGS) $(SRC)/pv01.f90
	@$(RM) ./a.$(EXESUFFIX)
	-$(F90) $(LDFLAGS) pv01.$(OBJX) check.$(OBJX) $(LIBS) -o a.$(EXESUFFIX)
build: pv01
run: ;
