set term postscript eps enhanced "Helvetica" 20
set ylabel " |H|"
set xlabel "f (hz)"
set xrange [1:5000]
set yrange [.01:1]
set logscale xy
set output 'output.eps'
plot 'output.data' using 1:2 title "IIR filter" w l, \
 'output.data' using 1:3 title "H on warped  freq axis" w l, \
 'output.data' using 1:4 title "H on unwarped freq axis" w l;
