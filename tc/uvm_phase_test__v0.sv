`ifndef UVM_PHASE_TEST__V0__SV
`define UVM_PHASE_TEST__V0__SV





class uvm_phase_test__v0 extends uvm_test;
	
	
	`uvm_component_utils(uvm_phase_test__v0)
	/**
	
	 * @see uvm_pkg::uvm_test.new
	
	 * @param name - 
	
	
	
	 * @param parent - 
	
	 * @return 
	
	 */
	function new(string name = "uvm_phase_test__v0", uvm_component parent = null );
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
	
		this.try_0();
	
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase
	
	
	function  void  try_0;
		uvm_phase A = new(.name("A"), .phase_type(UVM_PHASE_SCHEDULE), .parent(null));
		begin 
			string domain_name = "";
			domain_name = A.get_domain_name();
			$display("demoname = %0s", domain_name);
		end 
		
		begin 
			string schedule_name =  "";
			schedule_name = A.get_schedule_name(0);
			$display("schedule_name = %0s", schedule_name);
		end 
		
		begin 
			string full_name = "";
			full_name  = A.get_full_name();
			$display("full_name  = %0s", full_name);
		end 
		
		
		begin 
			uvm_phase_type A_type;
			A_type = A.get_phase_type();
			$display("A_type = 0x%0h", A_type);
		end 
		
		begin 
			uvm_phase_state A_state;
			A_state = A.get_state();
			$display("A_state = 0x%0h", A_state);
		end 
		
		begin 
			int count = -1;
			count = A.get_run_count();
			$display("count = %0d", count);
		end 
		
		begin
			A.m_print_successors();
		end 
		
	endfunction 
	
endclass 





`endif 