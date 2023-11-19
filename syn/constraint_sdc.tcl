set compile_enable_constant_propagation_with_no_boundary_opt false
set timing_enable_multiple_clocks_per_reg true
set enable_recovery_removal_arcs true

create_clock -name CLK_IN  -p 6.0 [get_ports clk] -waveform {0 1}

set_max_transition  1.0 [current_design]
set_max_transition  -clock_path 0.90 [all_clocks]
set_clock_transition 0.9 [all_clocks]
set_input_transition 0.89 [all_inputs]
#set_driving_cell -lib_cell and2a0 -pin Z -no_design_rule [all_inputs]
#set_driving_cell -lib_cell NAND2 -pin Z -no_design_rule  [all_inputs]
#set_load [load_of ${lib_slow}/NBUFFX2/INP] [all_outputs]
#set_load  0.02 [all_outputs]
#set_load  0.006484 [all_outputs]

set_input_delay 3 -clock CLK_IN [all_inputs]
set_input_delay -max 5 -clock CLK_IN  {seq}
set_input_delay -min 2 -clock CLK_IN  {seq}
set_output_delay 1 -clock CLK_IN {posi_reg}


#set_multicycle_path -setup  2 -from A -to B
#set_multicycle_path -hold   1 -from A -to B

# false path
set_false_path -from [get_ports rst_n]

