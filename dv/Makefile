.SILENT:

test:
	echo "TEST"

export REPO_ROOT = ${realpath ..}
export DV_ROOT = ${REPO_ROOT}/dv
export RTL_ROOT = ${REPO_ROOT}/src/rtl
export UVM_HOME = /proj/verif_release_ro/uvmkit-1.2/5.2.2/uvm

export SYNOPSYS_SIM_SETUP = ${DV_ROOT}/synopsys_sim.setup

clean:
	rm -rf AN.DB 
	rm -rf csrc 
	rm -rf simv.daidir 
	rm -rf vc_hdrs.h 
	rm -rf *log 
	rm -rf work_*
	rm -rf simv
	rm -rf DVEfiles
	rm -rf ucli.key
	rm -rf inter.vpd

build_uvm:
	vlogan -work work_uvm \
	-ntb_opts uvm -full64 \
	-l build_uvm.log \

build_dut:
	vlogan -work work_dut \
	-ntb_opts uvm -full64 \
	-file ${RTL_ROOT}/files.f \
	-l build_dut.log \

build_tb:
	vlogan -sverilog -work work_tb \
	-ntb_opts uvm -full64 \
	${DV_ROOT}/tb/tb_top.sv \
	${DV_ROOT}/intf/fifo_if.sv \
	-l build_tb.log 

build_all:
	make -j \
		build_uvm \
		build_dut \
		build_tb

build: build_all
	vcs -top tb_top -sverilog -full64 -debug_access+all \
	-ntb_opts uvm \
	-override_timescale=1ps/1fs \
	+vcs+lic+wait

