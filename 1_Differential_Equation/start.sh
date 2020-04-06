#! /bin/sh

gfortran main.f90 yexact.f90 -L/usr/local/lib -lport3 -lm -o main.out -L/usr/local/lib/gcc/9 -lgfortran

gnuplot iter.gnu
gnuplot analysis.gnu