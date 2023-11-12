all: app_asm_IRgen.cpp
	clang++ app_asm_IRgen.cpp `llvm-config --cxxflags --ldflags --libs` -lSDL2

run: 
	./a.out app.s