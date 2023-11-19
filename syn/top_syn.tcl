set SCRIPT_FILE     syn
source ./set_env.tcl

source -echo ./file_create.tcl

set cache_write  WORK/$file_version
set cache_read   WORK/$file_version

# set CMP_OPTION "-no_autoungroup -scan"
if {$do_scan == 1} { 
    set CMP_OPTION [format "%s %s" -no_autoungroup -scan]
} else {
    set CMP_OPTION [format "%s" -no_autoungroup]
}
set compile_cmd  "compile $CMP_OPTION"
alias do_compile $compile_cmd
alias do_compile_inc $compile_cmd -inc

set search_path [list \
            ./ \
            ../ \
            /home/zheng/synopsys/ic_libs/TSMC.90/aci/sc-x/synopsys \
            ]

set target_library   [list ${lib_slow}.db]
set link_library     [list "*" ${lib_slow}.db]
#set synthetic_library [list standard.sldb]
#set symbol_library [list generic.sdb]

define_design_lib WORK -path ./WORK/$file_version

##################################################################
## Read in Verilog Files    ##
##################################################################
# current_design $working_design
# link

#analyze -format sverilog  -vcs "-f $RTL_FILE/flist.f"
analyze -format sverilog  -vcs -f ../src/${working_design}.v


elaborate $working_design
report_attributes -design
current_design $working_design
link

source -echo ./set_parameter.tcl

source -echo ./constraint_sdc.tcl
source -echo ./dont_touch.tcl

#change naming rule

report_clock > $RPT_OUT/clock.syn.rpt
report_clock -skew >> $RPT_OUT/clock.syn.rpt

current_design $working_design

uniquify -force

##################################################################
## Optimization
##################################################################
change_names -rules verilog -hierarchy

#   there is no supprot of compile_ultra,so use compile
compile > $RPT_OUT/compile.rpt
compile -inc > $RPT_OUT/compile_inc.rpt
compile -inc > $RPT_OUT/compile_inc1.rpt

#do_compile > $RPT_OUT/compile.rpt
#do_compile_inc > $RPT_OUT/compile_inc.rpt
#do_compile_inc > $RPT_OUT/compile_inc2.rpt
#
change_names -rules verilog -hierarchy
current_design $working_design

##########################################

check_design  > $RPT_OUT/check_design.rpt
check_timing  > $RPT_OUT/check_timing.rpt

report_qor > $RPT_OUT/qor.rpt

report_area > $RPT_OUT/area.rpt
report_area -hierarchy > $RPT_OUT/area_hier.rpt
report_timing   -loops > $RPT_OUT/timing_loop.rpt
report_timing -path full -net -cap -input -tran -delay min -max_paths 200 -nworst 200 > $RPT_OUT/timing.min.rpt
report_timing -path full -net -cap -input -tran -delay max -max_paths 200 -nworst 200 > $RPT_OUT/timing.max.rpt
report_constraints -all_violators -verbose > $RPT_OUT/constraints.rpt
report_power > $RPT_OUT/power.rpt
###################################################################
## Saving Hierarchy
###################################################################
set bus_naming_style {%s[%d]} 
write_file -f verilog -hierarchy -output $DATA_OUT/$working_design.v
write_sdf -version 2.1 $DATA_OUT/$working_design.sdf
write_file -f ddc -hierarchy -output $DATA_OUT/$working_design.ddc

write_sdc $DATA_OUT/$working_design.sdc

#exit

