#.SILENT:
MAKEFLAGS += --silent

ifdef core1
	VAR1 = Including core_num1
else
	VAR1 = Not including core_num1
endif

ifneq (${core2},1)
	VAR2 = Not including core_num2
else
	VAR2 = Including core_num2
endif

ifdef core3
	ifeq (${core3.1},1)
		VAR3 = Including core_num3.1
	else
		VAR3 = Including core_num3.0
	endif
endif

ifndef TOP
	top = top.sv
endif

ifdef RUN
	run = -R
endif

ifdef COV
	cov = -cm line+cond
endif

#make printf1
include ./file1.mk

test:
	echo "testing123"

cpu:
	echo "Running cpu"
	echo "1. ${VAR1}"
	echo "2. ${VAR2}" 
	echo "3. ${VAR3}" 

vcs_cmd = vcs -sverilog ${run} ${cov} ${top}

test_build:
	echo "${vcs_cmd}"


arg2="arg2_string"
build:
	${call prebuild}
	${call build,"arg1",${arg2}}

define prebuild
	echo "Running prebuild"
endef

define build
	echo "Running build"
	echo $1,$2
endef

date_string = $(shell date +%YWW%V.%w)
pwd_string = $(shell pwd)

date_pwd:
	echo ${date_string}
	echo ${pwd_string}

gen_and_mv_newfile_here:
	cd dir1 ;\
	make create_file ;\
	mv newfile ..

run_py:
	mkdir -p testdir ;\
	cd testdir ;\
	echo "print('hello world')" >> script.py ;\
	echo "run_py:" > Makefile ;\
	echo "	python script.py" >> Makefile ;\
	make run_py

clean:
	rm -rf testdir