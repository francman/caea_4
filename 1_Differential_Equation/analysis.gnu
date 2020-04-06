set term postscript eps enhanced "Helvetica" 20
set ylabel " y"
set xlabel "x"
set output 'analysis.eps'
plot 'OUTPUT.DAT' using 1:2 title "direct" w l, \
'OUTPUT.DAT' using 1:3 title "jacobi" w l, \
'OUTPUT.DAT' using 1:4 title "gs" w l , \
'OUTPUT.DAT' using 1:5 title "exact" w l ;
