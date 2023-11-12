clang++ `llvm-config --cppflags --ldflags --libs` app_ir_gen.cpp -lSDL2
echo "Generated IR will be in app_gen_ir.ll"
./a.out > app_gen_ir.ll
