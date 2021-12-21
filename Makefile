
CXX?=clang++
HFLAGS=-std=c++20 -Wall -Wextra -IRE-flex/include -Ireplxx
LIBS=-lmpc -lmpfr -lgmp -lreadline RE-flex/lib/libreflex.a

STRIPPER.debug := :
STRIPPER.release := strip --strip-all
STRIPPER.profile := :
STRIPPER := $(or ${STRIPPER.${target}},:)

ifeq ($(CXX),g++)
CXXFLAGS.debug := -O0 -g3 -fsanitize=address -fsanitize=leak -fsanitize=undefined \
		 		  -fcf-protection=full -fstack-protector-strong -fstack-check
CXXFLAGS.release := -DNDEBUG -O3 -march=native -funroll-loops -flto -flto=auto
CXXFLAGS.profile := $(CXXFLAGS.release) -g3
CXXFLAGS := $(or ${CXXFLAGS.${target}},-Wall -Wextra -O0)
else
ifeq ($(CXX),clang++)
CXXFLAGS.debug := -O0 -g3 -fsanitize=address -fsanitize=leak -fsanitize=undefined \
		 		  -fcf-protection=full -fstack-protector-strong -fstack-check
CXXFLAGS.release := -DNDEBUG -O3 -march=native -funroll-loops -flto \
	-ffinite-loops -ffinite-math-only -fignore-exceptions -fno-math-errno -fno-stack-protector \
	-funroll-loops -funsafe-math-optimizations -fvectorize -fwhole-program-vtables -fvirtual-function-elimination \
	-fslp-vectorize # line 2 & 3 are dangerous as fuck, remove when there's some trouble.
CXXFLAGS.profile := $(CXXFLAGS.release) -g3
CXXFLAGS := $(or ${CXXFLAGS.${target}},-Wall -Wextra -O0)
else
CXXFLAGS := -O2
endif
endif

srcs=\
	atom.cpp env.cpp executor.cpp main.cpp reader/lexer.cpp reader/parser.cpp \
	replxx/conversion.cxx replxx/ConvertUTF.cpp replxx/escape.cxx replxx/history.cxx \
	replxx/prompt.cxx replxx/replxx.cxx replxx/replxx_impl.cxx replxx/terminal.cxx \
	replxx/util.cxx replxx/wcwidth.cpp replxx/windows.cxx
objs=$(patsubst %.cpp, %.o, $(patsubst %.cxx, %.o, $(srcs)))
deps=$(objs:.o=.d)

-include $(DEPS)

.PHONY: all clean get-deps

all: kamilalisp

%.o: %.cpp
	$(CXX) -MMD -MF $(patsubst %.o,%.d,$@) $(HFLAGS) $(CXXFLAGS) -c -o $@ $^

%.o: %.cxx
	$(CXX) -MMD -MF $(patsubst %.o,%.d,$@) $(HFLAGS) $(CXXFLAGS) -c -o $@ $^

reader/lexer.cpp: reader/lexer.lxx
	cd reader && ../RE-flex/bin/reflex lexer.lxx -o lexer.cpp

kamilalisp: $(objs)
	$(CXX) $(HFLAGS) $(CXXFLAGS) -o $@ $^ $(LIBS)
	$(STRIPPER) kamilalisp

clean:
	rm -f kamilalisp reader/lexer.cpp replxx/*.o *.o reader/*.o replxx/*.d *.d reader/*.d

get-deps:
	git clone https://github.com/Genivia/RE-flex
	cd RE-flex && ./clean.sh && ./build.sh


