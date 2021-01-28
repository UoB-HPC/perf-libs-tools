CFLAGS=-O3 -Wno-pointer-to-int-cast

all: Makefile armpl armpl-numpy armpl-math generic tools

## DEPRECATED LOGGING TOOL
# libarmpl-logger.so: preload-gen.c src/logging.c src/PROTOTYPES
# 	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/$@ preload-gen.c logging.c -ldl -DLOGGING
# preload-gen.c: src/makepreload.py 
# 	cd src && python makepreload.py

## ARMPL Tracer
armpl: preload-sumgen.c 
	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/lib$@-summarylog.so preload-sumgen.c summary.c -ldl
	cd src && gcc -fPIC ${CFLAGS} -lz -shared -o ../lib/lib$@-memlightlog.so preload-sumgen.c summary-memlight.c -ldl

armpl-numpy: preload-sumgen-numpy.c 
	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/lib$@-summarylog.so preload-sumgen-numpy.c summary.c -ldl
	cd src && gcc -fPIC ${CFLAGS} -lz -shared -o ../lib/lib$@-memlightlog.so preload-sumgen-numpy.c summary-memlight.c -ldl

preload-sumgen.c: src/makepreload-post.py 
	cd src && python makepreload-post.py -i "PROTOTYPES"

preload-sumgen-numpy.c: src/makepreload-post-numpy.py 
	cd src && python makepreload-post-numpy.py -i "PROTOTYPES"

## ARMPL+MATH Tracer
armpl-math: preload-sumgen-math.c
	cd src && gcc -fPIC ${CFLAGS} -Wno-incompatible-library-redeclaration -shared -o ../lib/lib$@-summarylog.so preload-sumgen.c summary.c -ldl
	cd src && gcc -fPIC ${CFLAGS} -Wno-incompatible-library-redeclaration -shared -o ../lib/lib$@-memlightlog.so preload-sumgen.c summary-memlight.c -ldl

preload-sumgen-math.c: src/makepreload-post.py 
	cd src && python makepreload-post.py -i "PROTOTYPES_MATH"

## Generic BLAS Tracer
generic: preload-sumgen-generic.c
	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/lib$@-summarylog.so preload-sumgen.c summary.c -ldl
	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/lib$@-memlightlog.so preload-sumgen.c summary-memlight.c -ldl

preload-sumgen-generic.c: src/makepreload-post.py 
	cd src && python makepreload-post.py -i "PROTOTYPES_GENERIC"

## CBLAS Tracer - In Progress
libcblas-summarylog.so: preload-sumgen-cblas.c src/summary.c
	cd src && gcc -fPIC ${CFLAGS} -shared -o ../lib/$@ preload-sumgen.c summary.c -ldl


tools: tools/Process-dgemm

tools/Process-dgemm:
	cd tools ; gcc -o Process-dgemm process-dgemm.c -O2 -lm
	cd tools ; gcc -o Red-Process-dgemm red-process-dgemm.c -O2 -lm

clean:
	rm -f src/preload-gen.c src/preload-sumgen.c
	rm -f lib/*.so
	rm -f tools/Process-dgemm
