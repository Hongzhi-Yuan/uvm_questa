`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

class my_sequencer extends uvm_sequencer#(my_transaction);

	rand bit [47:0] dmac;
	rand bit [47:0] smac;


//	my_sequence m_seq;
	`uvm_component_utils_begin(my_sequencer)
		`uvm_field_int(dmac, UVM_ALL_ON)
		`uvm_field_int(smac, UVM_ALL_ON)
	`uvm_component_utils_end

//	`uvm_component_utils_beign(my_sequencer)
//		`uvm_field_int(dmac, UVM_ALL_ON)
//		`uvm_field_int(smac, UVM_ALL_ON)
//	`uvm_component_utils_end

	function new(string name = "my_sequencer", uvm_component parent = null);
		// TODO Auto-generated constructor stub
	
		super.new(name, parent);
	
		
	
		
	endfunction : new
	
	
	
	/**
	
	 * @see uvm_pkg::uvm_component.main_phase
	
	 * @param phase - 
	
	 * 
	
	 */
//	virtual task main_phase(uvm_phase phase);
//		// TODO Auto-generated task stub
//		m_seq = my_sequence::type_id::create("m_seq");
//		m_seq.start(this);
//		super.main_phase(phase);
//	
//		
//	
//		
//	endtask : main_phase
//	
	

	
endclass 





`endif 