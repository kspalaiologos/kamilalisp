
CXX=clang++
CXXFLAGS=-std=c++20 -Wall -flto -O3 -IRE-flex/include -Ireplxx
LIBS=-lmpc -lmpfr -lgmp -lreadline RE-flex/lib/libreflex.a

srcs=\
	atom.cpp env.cpp executor.cpp main.cpp reader/lexer.cpp reader/parser.cpp \
	replxx/conversion.cxx replxx/ConvertUTF.cpp replxx/escape.cxx replxx/history.cxx \
	replxx/prompt.cxx replxx/replxx.cxx replxx/replxx_impl.cxx replxx/terminal.cxx \
	replxx/util.cxx replxx/wcwidth.cpp replxx/windows.cxx
objs=$(patsubst %.cpp, %.o, $(patsubst %.cxx, %.o, $(srcs)))

all: kamilalisp

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $^

%.o: %.cxx
	$(CXX) $(CXXFLAGS) -c -o $@ $^

reader/lexer.cpp: reader/lexer.lxx
	cd reader && ../RE-flex/bin/reflex lexer.lxx -o lexer.cpp

kamilalisp: $(objs)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f kamilalisp reader/*.o reader/lexer.cpp replxx/*.o *.o

get-deps:
	git clone https://github.com/Genivia/RE-flex
	cd RE-flex && ./clean.sh && ./build.sh
