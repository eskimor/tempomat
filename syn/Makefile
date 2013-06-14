include ../Project

TARGET  := $(DESIGN).edf
SOURCES := $(subst ",,$(shell grep ^add_file $(PROJECT).prj | sed -e s/[^\"]*//))

.PHONY: all gui
all:	$(DEST)/$(TARGET)
	@echo "*** $(TARGET) generated ***"
	@grep "Worst slack" $(DEST)/$(DESIGN).srr

$(DEST)/$(TARGET): $(SOURCES) $(PROJECT).sdc
	sed -e "s/^set REV .*/set REV rev_${REVISION}/g" -i~ $(PROJECT).prj
	synplify_premier -licensetype synplifypremierdp -batch -runall $(PROJECT).prj

gui:
	sed -e "s/^set REV .*/set REV rev_${REVISION}/g" -i~ $(PROJECT).prj
	synplify_premier -licensetype synplifypremierdp -runall $(PROJECT).prj

.PHONY: clean
clean:
	rm -rf $(DEST) stdout.log *~
