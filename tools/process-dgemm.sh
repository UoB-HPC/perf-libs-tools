#!/bin/bash

if [ "$1" == "" ] || [ "$1" == "--help" ] || [ "$1" == "-h" ];
then
	echo "Usage ./process-dgemm.sh <files> [-r or --reduced]]"
	exit
fi

if [ "$1" == "--reduced" ] || [ "$1" == "-r" ] ;
then
    EXE=./Red-Process-dgemm
    START=2
else
    EXE=./Process-dgemm
    START=1
fi

for f in ${@:$START}
do
	if [ ! -f $f ] ;
	then
		echo "File $1 does not exist"
		exit
	fi
done

if [ ! -f Process-dgemm ] || [ ! -f Red-Process-dgemm ] ;
then
	echo "Need to run './Process-dgemm'.  Either I am not in perf-libs-tools/tools or you need to compile:"
	echo "  $ gcc -o Process-dgemm process-dgemm.c"
fi

TMPFILE=/tmp/.inp-$USER

rm -f $TMPFILE
rm -f ${TMPFILE}_d
rm -f ${TMPFILE}_s
rm -f ${TMPFILE}_z
rm -f ${TMPFILE}_c
for file in ${@:$START}
do
	grep dgemm ${file} >> ${TMPFILE}_d
	grep sgemm ${file} >> ${TMPFILE}_s
	grep zgemm ${file} >> ${TMPFILE}_z
	grep cgemm ${file} >> ${TMPFILE}_c
done

${EXE} 0 ${TMPFILE}_d
${EXE} 1 ${TMPFILE}_s
${EXE} 2 ${TMPFILE}_z
${EXE} 3 ${TMPFILE}_c

echo "GEMM data created.  Visualize using, for example"
echo "   $ ./heat_dgemm.py -i /tmp/armpl.dgemm"

rm -f $TMPFILE
