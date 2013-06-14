include ../Project

# Directories which are scanned for sources (in this order).
DIRS    := ../vhd ../ise ../impl/$(DEST) ../sim

# These files are searched within the given directories.
FILES   := *.vhd *.v

# Order in which the files will be translated inside each directory.
ORDER   := %.v %_pack.vhd %_.vhd %_rtl.vhd %_sim.vhd %_struc.vhd tb%.vhd %.vhd

# All source files.
# Note! this variable is refined several times!
SOURCES := $(foreach dir,$(DIRS),$(foreach class,$(FILES),$(wildcard $(dir)/$(class))))

# Yeah ModelSim joy: packages to ignore for vmake
EXCLUDE := -i std_logic_1164 -i std_logic_arith -i numeric_std -i textio \
	   -i vital_primitives -i vital_timing 

.PHONY: all
all:	Makefile.inc

pre:	all whole_library	
	vsim -gui -novopt work.prelayout

post:	all whole_library
	vsim -gui work.postlayout

# Define a generic compile rule for a specific target.
define compile
VIRTUAL += work/$(subst /,_,./$(1))
work/$(subst /,_,./$(1)): $(1) | work
ifeq	($(suffix $(1)),.vhd)
	vcom -work ./work -nologo -quiet -93 $(1)
else
	vlog -work ./work -nologo -quiet $(1)
endif
	@touch work/$(subst /,_,./$(1))
endef

# Assure correct compile order of all sources within a directory.
define compile-order
TAKESRC := $(filter     $(1),$(SOURCES))
SOURCES := $(filter-out $(1),$(SOURCES))
$(foreach file,$(TAKESRC),$(eval $(call compile,$(file))))
endef

# Compile all source files in a directory.
define compile-dir
$(foreach type,$(ORDER),$(eval $(call compile-order,$(1)/$(type))))
endef

# Create makefile rules for all sources in all source directories.
$(foreach dir,$(DIRS),$(eval $(call compile-dir,$(dir))))

# Create xilinx library if it doesn't exist already.
xilinx:
	compxlib -s mti_se -f spartan3:u:s:c -l all -o xilinx

# Create our working library.
work:
	vlib work

# We have a two step build strategy, if we haven't created the include makefile
# with the help of vmake, compile all hdl sources in the (hopefully) correct order.
.PHONY: initial_library
initial_library: $(VIRTUAL) | work
	@echo "*** initial_library ready ***"

# If we have compiled the sources, then we are able to generate the include makefile.
# Don't even try to understand this sed command, it fixes a vmake bug. Vmake generates
# unquoted spaces in paths which leads to parse errors in the makefile.
Makefile.inc: | initial_library
	vmake $(EXCLUDE) | sed -e '/.*[ ]*=[ ]*.*/{h;s/.*[ ]*=[ ]*\(.*\)/\1/;s/ /\\ /g;G;s/\(.*\)\n\(.*[ ]*=[ ]*\).*/\2\1/}' > Makefile.inc

# Inherit automatically generated makefile
-include Makefile.inc

# Cleanup behind us.
.PHONY: clean
clean:
	rm -rf Makefile.inc work *~
