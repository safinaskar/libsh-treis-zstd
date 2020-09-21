export

include libsh-treis/common.mk

CXX ?= c++
AR ?= ar

ifeq ($(RELEASE),1)
CPPFLAGS ?= -DNDEBUG
CXXFLAGS ?= -O3 -g $(WARNS) -pedantic
LDFLAGS ?= -O3 -g
else
CPPFLAGS ?=
CXXFLAGS ?= -g $(WARNS) -pedantic -fsanitize=undefined,bounds,nullability,float-divide-by-zero,implicit-conversion,address -fno-sanitize-recover=all -fno-omit-frame-pointer -fsanitize-address-use-after-scope -fno-optimize-sibling-calls
LDFLAGS ?= -g -fsanitize=undefined,bounds,nullability,float-divide-by-zero,implicit-conversion,address -fno-sanitize-recover=all -fno-omit-frame-pointer -fsanitize-address-use-after-scope -fno-optimize-sibling-calls
endif

all: lib.a

.DELETE_ON_ERROR:

FORCE:

libsh-treis/%: FORCE
	T='$@'; $(MAKE) -C "$${T%%/*}" "$${T#*/}"

libsh-treis-zstd.hpp: libsh-treis-zstd.cpp
	grep -E '//@' $< | sed -E 's~ *//@ ?~~' > $@

libsh-treis-zstd.o: libsh-treis-zstd.cpp FORCE
	libsh-treis/compile '$(MAKE)' $< $(CXX) $(CPPFLAGS) $(CXXFLAGS) -std=c++2a

lib.a: libsh-treis-zstd.o libsh-treis/lib.a
	cp libsh-treis/lib.a $@ && $(AR) rsD $@ libsh-treis-zstd.o
