all: app_ir_gen.cpp
	clang++ app_ir_gen.cpp `llvm-config --cxxflags --ldflags --libs` -lSDL2

run: 
	./a.out