`ifndef UVM_CALLBACK_TEST_SV
`define UVM_CALLBACK_TEST_SV


class callback_demo extends uvm_callback;
	`uvm_object_utils(callback_demo)
	function new(string name = "callback_demo");
		super.new(name);
	endfunction 
	
	virtual function void pre_task();
		$display("*****************************pre task*****************************");
	endfunction 

	virtual function void post_task();
		$display("*****************************post task****************************");
	endfunction 

endclass 



class component_demo extends uvm_component;
	`uvm_register_cb(component_demo, callback_demo)
	
	`uvm_component_utils(component_demo)
	function  new(string name = "component_demo", uvm_component parent = null );
		super.new(name, parent);
	endfunction 
	
	/**
	
	 * @see uvm_pkg::uvm_component.connect_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual function void connect_phase(uvm_phase phase);
		// TODO Auto-generated function stub
	
		super.connect_phase(phase);
	
		`uvm_do_callbacks(component_demo, callback_demo, pre_task)
	
		`uvm_do_callbacks(component_demo, callback_demo, post_task)
	endfunction : connect_phase
	
endclass 





class uvm_callback_test extends  uvm_test;
	callback_demo cb_demo__c0;
	component_demo comp_demo_t0;
	`uvm_component_utils(uvm_callback_test)
	function new(string name = "uvm_callback_test", uvm_component parent = null );
		super.new(name, parent);
	endfunction 
	
	/**
	
	 * @see uvm_pkg::uvm_component.build_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual function void build_phase(uvm_phase phase);
		// TODO Auto-generated function stub
	
		super.build_phase(phase);
		
		cb_demo__c0 = callback_demo::type_id::create("cb_demo__c0");
		comp_demo_t0 = component_demo::type_id::create("comp_demo_t0", this);
	
		uvm_callbacks#(component_demo, callback_demo)::add(comp_demo_t0, cb_demo__c0);
	
		
	endfunction : build_phase
endclass 





`endif 