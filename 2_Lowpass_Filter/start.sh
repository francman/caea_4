#! /bin/sh

gfortran main.f90 fft.f -o main.out -L/usr/local/lib/gcc/9 -lgfortran
./main.out > output.data

gnuplot output.gnu