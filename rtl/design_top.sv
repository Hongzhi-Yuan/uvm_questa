`timescale 1ns/1ps

module design_top(
	input 			clock,
	input 			reset,
	input 			rx_valid,
	input 	[7:0]   rx_data,
	output reg		tx_en,
	output reg [7:0]tx_data 
	);
	

	always  @  (posedge clock, posedge reset) begin 
		if (reset) begin 
			tx_en <= 'b0;
			tx_data <= 'b0;
		end else begin 
			tx_data <= rx_data;
			tx_en <= rx_valid;
		end 
	end 



endmodule 