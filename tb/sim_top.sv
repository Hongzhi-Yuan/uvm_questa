`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"


`include "my_transaction.sv"

`include "my_interface.sv"

`include "my_sequence.sv"
`include "my_sequence0.sv"
`include "my_sequence1.sv"

`include "my_sequence_lib.sv"


`include "my_sequencer.sv"
`include "my_driver.sv"

`include "base_test.sv"

module sim_top;
	

	logic  	clock;
	logic 	reset;



	my_if input_if(.clock(clock), .reset(reset));
	my_if output_if(.clock(clock), .reset(reset));


	
	design_top u_design_top (
		.clock   (clock),
		.reset   (reset),
		.rx_data (input_if.data),
		.rx_valid(input_if.valid),
		.tx_data (output_if.data),
		.tx_en   (output_if.valid)
	);


	initial begin
		clock = 1;
		forever begin 
			#5ns;
			clock = ~clock;
		end 
	end
	
	initial begin
		reset = 1;
		#4005ns;
		reset= 0;
	end



	initial begin
		uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.drv", "vif", input_if);
	end



	initial begin
		run_test();
	end

	
	
	
	
endmodule 