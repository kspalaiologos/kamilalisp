
CXX=clang++
CXXFLAGS=-std=c++20 -Ofast -flto -march=native -mtune=native

all: kamilalisp

atom.o: atom.cpp atom.hpp
	$(CXX) $(CXXFLAGS) -c -o $@ atom.cpp

env.o: env.cpp env.hpp
	$(CXX) $(CXXFLAGS) -c -o $@ env.cpp

executor.o: executor.cpp executor.hpp
	$(CXX) $(CXXFLAGS) -c -o $@ executor.cpp

main.o: main.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ main.cpp

reader/lexer.cpp: reader/lexer.lxx
	cd reader && ../RE-flex/bin/reflex lexer.lxx -o lexer.cpp

reader/lexer.o: reader/lexer.cpp
	$(CXX) $(CXXFLAGS) -IRE-flex/include -c -o $@ reader/lexer.cpp

kamilalisp: reader/lexer.o main.o executor.o env.o atom.o
	$(CXX) $(CXXFLAGS) -o $@ main.o executor.o env.o atom.o -lmpc -lmpfr -lgmp RE-flex/lib/libreflex.a

clean:
	rm -f kamilalisp reader/*.o reader/lexer.cpp *.o

get-deps:
	git clone https://github.com/Genivia/RE-flex
	cd RE-flex && ./clean.sh && ./build.sh
