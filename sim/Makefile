#Makefile for simulink the project
#-------------------------------------------------------

#        vcs  -notice -debug_acc+all -j8 -timescale=1ns/1ps \
#-cpp g++-4.8 -cc gcc-4.8
export TEST_NAME = tb_default_top_name
export SIMDIR = sim
FILE_LIST = filelist.f


PLATFORM = LINUX64
waveform = $(TEST_NAME).fsdb
 
cs_all: clean list vcs_compile vcs_simulate
vcs_compile:
	vcs -notice -debug_acc+all -j8 -timescale=1ns/1ps \
	-sverilog -LDFLAGS -rdynamic -full64 \
  -P $(VERDI_HOME)/share/PLI/VCS/$(PLATFORM)/novas.tab \
     $(VERDI_HOME)/share/PLI/VCS/$(PLATFORM)/pli.a \
	-f $(FILE_LIST) \
  +vcs+lic+wait \
  -l compile.log
        
vcs_simulate:
	./simv \
  +fsdb+autoflush \
  -l sim.log 


run_verdi:
	verdi -nologo -sv -f $(FILE_LIST) -ssf $(TEST_NAME).fsdb &


clean:
	@rm -rf csrc DVEfiles simv simv.daidir ucli.key novas* VCS* *dat *.fsdb  *.log verdiLog/ *.f *.log 
	@find . -name "*.log" |xargs rm -f
list:
	find ../src ./ -name "*.v" >filelist.f
