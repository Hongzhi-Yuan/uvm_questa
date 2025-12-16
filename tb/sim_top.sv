`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "base_test.sv"

`include "uvm_phase_test__v0.sv"
`include "uvm_phase_test__v1.sv"
`include "uvm_phase_test__v2.sv"

module sim_top;
	
	initial begin
//		run_test();
	end


	initial begin 
//		info();

	end 
	
	initial begin
		phase_test_02();
	end

	
	
	
	
	
endmodule 