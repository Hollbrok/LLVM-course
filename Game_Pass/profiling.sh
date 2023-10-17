clang++ game_cfg.cpp -c -fPIC -I`llvm-config --includedir` -o cfg.o
clang++ cfg.o -fPIC -shared -o libCfg.so

clang ../Game/lib.c -c -fPIC -I`llvm-config --includedir` -o gamelib.o
clang gamelib.o -fPIC -shared -o libGame.so

clang -O2 -Xclang -load -Xclang ./libCfg.so ./libGame.so ../Game/app.c -emit-llvm -S -o app.ll
clang -O2 -Xclang -load -Xclang ./libCfg.so ./libGame.so ../Game/app.c log.c -lSDL2
#./a.out > log.txt
