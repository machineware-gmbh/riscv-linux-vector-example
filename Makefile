 ##############################################################################
 #                                                                            #
 # Copyright (C) 2023 MachineWare GmbH                                        #
 # All Rights Reserved                                                        #
 #                                                                            #
 # This is work is licensed under the terms described in the LICENSE file     #
 # found in the root directory of this source tree.                           #
 #                                                                            #
 ##############################################################################

CPPFLAGS = -static -Iinclude -march=rv64gv -O3

TOOLCHAIN = riscv64-unknown-linux-gnu-
CXX = $(TOOLCHAIN)g++

.PHONY: example
example: src/main.cpp src/vec.S
	$(CXX) $(CPPFLAGS) $^ -o $@

clean:
	$(RM) example
