	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	# set run_time			"1 ns"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/concat.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/down_counter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/input_ram.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mult.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/output_ram.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_left_reg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_right_reg.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/zero_extend.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	