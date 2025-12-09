`ifndef UVM_PRINTER_TEST__SVH
`define UVM_PRINTER_TEST__SVH





class uvm_printer_test extends uvm_test;
	
	`uvm_component_utils(uvm_printer_test)
	
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
	
		string demo_string = "***************************yuanhongzhi**************************";
		`uvm_print_string(demo_string)
	
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase


	
endclass 





`endif 