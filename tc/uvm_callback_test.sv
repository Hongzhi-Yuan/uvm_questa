`ifndef UVM_CALLBACK_TEST_SV
`define UVM_CALLBACK_TEST_SV


class demo_object extends uvm_object;
	/**
	
	 * @see uvm_pkg::uvm_object.new
	
	 * @param name - 
	
	 * @return 
	
	 */
	function new(string name = "demo_object");
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name);
	
		
	
		
	endfunction : new
endclass 



class demo_callback extends uvm_callback;
	/**
	
	 * @see uvm_pkg::uvm_callback.new
	
	 * @param name - 
	
	 * @return 
	
	 */
	function new(string name = "demo_callback");
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name);
	
		
	
		
	endfunction : new
	
	virtual function void pre_do;
		$display("pre_do called");
	endfunction 
endclass 


class uvm_callback_test extends uvm_test;
	
	`uvm_component_utils(uvm_callback_test)
	
	
	/**
	
	 * @see uvm_pkg::uvm_test.new
	
	 * @param name - 
	
	
	
	 * @param parent - 
	
	 * @return 
	
	 */
	function new(string name = "uvm_callback_test", uvm_component parent = null );
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name, parent);
	
		
	
		
	endfunction : new
	
	/**
	
	 * @see uvm_pkg::uvm_component.main_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual task main_phase(uvm_phase phase);
		// TODO Auto-generated task stub
		demo_callback cb = new("cb");
		demo_object t = new("t");
		uvm_callback_iter#(demo_object, demo_callback) iter = new(t);
		int intr;
		
		demo_callback user_cb;
		
		
		void'(uvm_callbacks#(demo_object, demo_callback)::m_register_pair("demo_object", "demo_callback"));
		
		uvm_callbacks#(demo_object, demo_callback)::add(t, cb, UVM_APPEND);
			
//		user_cb = uvm_callbacks#(demo_object, demo_callback)::get_first(intr, t);
		
		
		user_cb =  iter.first();
		
		user_cb.pre_do();
		
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase
	
endclass 





`endif 