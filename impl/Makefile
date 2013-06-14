export XIL_PAR_DESIGN_CHECK_VERBOSE=1

include ../Project

PART    := xc3s700a-fg484
TARGET  := $(PROJECT).bit
SRCDIR  := ../syn/$(DEST)
SOURCES := $(SRCDIR)/$(DESIGN).edf $(SRCDIR)/$(DESIGN).ncf

.PHONY: all
all:	$(DEST)/$(TARGET) $(DEST)/$(DESIGN).twr 
	@echo "*** $(TARGET) generated ***"
	@grep -C3 -i slice stdout.log
	@grep "Timing errors" stdout.log

.PHONY: sim
sim:	$(DEST)/$(DESIGN)_timing.vhd
	@echo "*** $(DESIGN) timing simulation model generated ***"

.PHONY: pgm
pgm:	# $(DEST)/$(TARGET)
	@echo "# Program the FPGA Development Board" > $(DEST)/fpga.cmd
	@echo "setMode -bscan" >> $(DEST)/fpga.cmd
	@echo "setCable -p usb21" >> $(DEST)/fpga.cmd
	@echo "addDevice -p 1 -part xc3s700a" >> $(DEST)/fpga.cmd
	@echo "addDevice -p 2 -part xcf04s" >> $(DEST)/fpga.cmd
	@echo "assignFile -p 1 -file $(TARGET)" >> $(DEST)/fpga.cmd
	@echo "program -p 1" >> $(DEST)/fpga.cmd
	@echo "quit" >> $(DEST)/fpga.cmd	
	cd $(DEST) && impact -batch fpga.cmd

.PHONY: rmlog
rmlog:
	@rm -f stdout.log

$(DEST)/fpga.cmd:
	@echo 	

$(DEST)/$(DESIGN).ngd: $(DESIGN).ucf $(SRCDIR)/$(DESIGN).edf $(SRCDIR)/$(DESIGN).ncf
	ngdbuild -p $(PART) -uc $(DESIGN).ucf -sd $(SRCDIR) -sd $(ISESRC) -dd $(DEST) $(DESIGN).edf $(DEST)/$(DESIGN).ngd > stdout.log

$(DEST)/map.ncd: $(DEST)/$(DESIGN).ngd
	map -p $(PART) -c 50 -cm balanced -pr b -ol high -xe c -timing \
            -o $(DEST)/map.ncd $(DEST)/$(DESIGN).ngd $(DEST)/$(DESIGN).pcf >> stdout.log

$(DEST)/$(DESIGN).ncd: $(DEST)/map.ncd $(DEST)/$(DESIGN).pcf
	par -w -ol high $(DEST)/map.ncd $(DEST)/$(DESIGN).ncd $(DEST)/$(DESIGN).pcf >> stdout.log

$(DEST)/$(DESIGN).twr: $(DEST)/$(DESIGN).ncd $(DEST)/$(DESIGN).pcf
	trce $(DEST)/$(DESIGN).ncd $(DEST)/$(DESIGN).pcf -e 50 -u -o $(DEST)/$(DESIGN).twr >> stdout.log

$(DEST)/$(DESIGN).bit: $(DEST)/$(DESIGN).ncd 
	bitgen $(DEST)/$(DESIGN).ncd -b -l -w -f $(DESIGN).ut >> stdout.log

$(DEST)/$(PROJECT).bit: $(DEST)/$(DESIGN).bit ../sim/firmware.mem
	data2mem -bm $(DESIGN).bmm -bt $(DEST)/$(DESIGN).bit -bd ../sim/firmware.mem -o b $(DEST)/$(PROJECT).bit

$(DEST)/$(DESIGN)_timing.vhd: $(DEST)/$(DESIGN).ncd $(DEST)/$(DESIGN).pcf $(DEST)/map.ngm
	netgen -sim -ofmt vhdl -pcf $(DEST)/$(DESIGN).pcf $(DEST)/$(DESIGN).ncd -w $(DEST)/$(DESIGN)_timing.vhd

.PHONY: clean

clean:	rmlog
	rm -rf $(DEST) stdout.log *~
