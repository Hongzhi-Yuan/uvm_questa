`ifndef MY_SEQUENCE_LIB__SV
`define MY_SEQUENCE_LIB__SV

class my_sequence_lib extends uvm_sequence_library#(my_transaction);
	
	`uvm_object_utils(my_sequence_lib)
	`uvm_sequence_library_utils(my_sequence_lib)
	
	function new(string name = "");
		// TODO Auto-generated constructor stub
	
		
		super.new(name);
		init_sequence_library();
		
	endfunction : new
	
endclass


`endif 