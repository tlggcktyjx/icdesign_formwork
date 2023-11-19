##################################################################
## Optimization
##################################################################
change_names -rules verilog -hierarchy

#   there is no supprot of compile_ultra,so use compile
compile > $RPT_OUT/compile.rpt

#do_compile > $RPT_OUT/compile.rpt
#do_compile_inc > $RPT_OUT/compile_inc.rpt
#do_compile_inc > $RPT_OUT/compile_inc2.rpt
#
change_names -rules verilog -hierarchy
current_design $working_design

