all:
	g++ -c main.cpp
	g++ -c lib/lib.cpp
	g++ main.o lib.o -o sfml-app -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio