`ifndef UVM_PACKER__SV
`define UVM_PACKER__SV




class uvm_packer_test extends uvm_test;
	
	`uvm_component_utils(uvm_packer_test)
	/**
	
	 * @see uvm_pkg::uvm_test.new
	
	 * @param name - 
	
	
	
	 * @param parent - 
	
	 * @return 
	
	 */
	function new(string name, uvm_component parent);
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name, parent);
	
		
	
		
	endfunction : new
	
	/**
	
	 * @see uvm_pkg::uvm_component.build_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual function void build_phase(uvm_phase phase);
		// TODO Auto-generated function stub
	
		
	
		super.build_phase(phase);
	
		
	
		
	endfunction : build_phase
	
	/**
	
	 * @see uvm_pkg::uvm_component.main_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual task main_phase(uvm_phase phase);
		// TODO Auto-generated task stub
	
		
	
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase
	
	
	
	virtual function  void  parker_test(string cmd);
		
	endfunction 
	
endclass 




`endif 