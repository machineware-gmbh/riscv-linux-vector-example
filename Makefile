CPPFLAGS = -static -Iinclude -march=rv64gv -O3

TOOLCHAIN = riscv64-unknown-linux-gnu-
CXX = $(TOOLCHAIN)g++

.PHONY: example
example: src/main.cpp src/vec.S
	$(CXX) $(CPPFLAGS) $^ -o $@

clean:
	$(RM) example
