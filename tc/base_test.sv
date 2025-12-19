`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
	
	my_driver drv;
	my_sequencer sqr;
//	my_sequence seq;
	uvm_sequence_library_cfg cfg;

	`uvm_component_utils(base_test)
	function  new(string name = "base_test", uvm_component parent = null );
		super.new(name, parent);
	endfunction 
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		cfg = new("cfg",UVM_SEQ_LIB_RAND, 5, 5);
		
		drv = my_driver::type_id::create("drv", this);
		sqr = my_sequencer::type_id::create("sqr", this);
//		uvm_config_db#(uvm_object_wrapper)::set(
//			this, 
//			"sqr.main_phase", 
//			"default_sequence", 
//			my_sequence0::type_id::get()
//			);



//		uvm_config_db#(uvm_object_wrapper)::set(
//			this, 
//			"sqr.main_phase", 
//			"default_sequence", 
//			my_sequence1::type_id::get()
//			);

		uvm_config_wrapper::set(
			this, 
			"sqr.main_phase",
			"default_sequence",
			my_sequence_lib::type_id::get());

		uvm_config_db#(uvm_sequence_library_cfg)::set(
			this,
			"sqr.main_phase",
			"default_sequence.config",
			cfg
			);
		
		
	
	endfunction 
	
	
	virtual function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);

		super.connect_phase(phase);
		
	endfunction : connect_phase
	

	
	
endclass 

`endif 