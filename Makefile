VSIM := vsim.exe
modelsim:
	cd ./simulation/ && $(VSIM) -do make_sim.do

QUARTUS_DIR  := /mnt/d/AlteraQuartusLite/quartus/bin64/
QUARTUS      := $(QUARTUS_DIR)/quartus.exe
# QUARTUS_SH   := $(QUARTUS_DIR)/quartus_sh.exe
# QUARTUS_PGM  := $(QUARTUS_DIR)/quartus_pgm.exe
QUARTUS_MAP  := $(QUARTUS_DIR)/quartus_map.exe

# CABLE_NAME   := "USB-Blaster"
PROJECT_NAME := crossbar

run_quartus:
	$(QUARTUS_MAP) $(PROJECT_NAME) &

# load:
# 	$(QUARTUS_PGM) -c $(CABLE_NAME) -m JTAG -o "p;./output_files/$(PROJECT_NAME).sof"