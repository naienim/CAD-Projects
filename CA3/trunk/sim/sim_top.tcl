	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	# set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Adder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/AND5.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/c1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/c2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/FA.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/modules.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mult.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux2to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux4to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/NOT.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/OR5.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_1bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/s1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/s2.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shift_l_r.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/up_down_cnt.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/XOR.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/HA.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -bin -group 	 	{TB}				sim:/$TB/*
	add wave -bin -group 	 	{top}				sim:/$TB/uut/*	
	add wave -bin -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	