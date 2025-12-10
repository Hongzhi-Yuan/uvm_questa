`ifndef UVM_PHASE_TEST__SV
`define UVM_PHASE_TEST__SV




class uvm_phase_test extends uvm_test;
	
	
	`uvm_component_utils(uvm_phase_test)
	/**
	
	 * @see uvm_pkg::uvm_test.new
	
	 * @param name - 
	
	
	
	 * @param parent - 
	
	 * @return 
	
	 */
	function new(string name = "uvm_phase_test", uvm_component parent = null );
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name, parent);
	
		
	
		
	endfunction : new
	
	
endclass 





`endif 