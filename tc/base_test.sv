`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
	
	`uvm_component_utils(base_test)
	function  new(string name = "base_test", uvm_component parent = null );
		super.new(name, parent);
	endfunction 
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_full_name(), "Helo work", UVM_LOW)
	endfunction 
	
endclass 

`endif 