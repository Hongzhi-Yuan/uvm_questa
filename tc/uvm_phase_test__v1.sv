`ifndef UVM_PHASE_TEST__V1__SV
`define UVM_PHASE_TEST__V1__SV


class uvm_phase_test__v1 extends uvm_test;
	
	`uvm_component_utils(uvm_phase_test__v1)
	/**
	
	 * @see uvm_pkg::uvm_test.new
	
	 * @param name - 
	
	
	
	 * @param parent - 
	
	 * @return 
	
	 */
	function new(string name = "uvm_phase_test__v1", uvm_component parent = null );
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
	
		begin 
			$display("\n\n ==========================================\n\n");
		end 
		
	
		uvm_phase_try_0();
		
		begin 
			$display("\n\n ==========================================\n\n");
		end 
		uvm_phase_try_1();
		
		begin 
			$display("\n\n ==========================================\n\n");
		end 
		
		
		
	
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase
	

	virtual  function  void uvm_phase_try_0;
		uvm_phase A = new(.name("A"), .phase_type(UVM_PHASE_SCHEDULE), .parent(null));
		
		/*
		 * return phase_type
		 */
		begin 
			uvm_phase_type type_e;
			type_e = A.get_phase_type();
			$display("type_e = 0x%0h", type_e);
		end 
		
		
		/*
		 * retuen phase_state
		 */
		begin 
			uvm_phase_state state_e;
			state_e = A.get_state();
			$display("state_e = 0x%0h", state_e);
		end 
		
		/*
		 * return run count
		 */
		begin 
			int count = 0;
			count = A.get_run_count();
			$display("count = %0d", count);
		end 
		
		/*
		 * return parent
		 */
		begin 
			if (A.get_parent() != null )
				$display("----------- pass -------------");
			else 
				$display("------------failed------------");
		end 
		
		/*
		 * return successors  node
		 */
		 
		begin 
			uvm_phase A_next_node ;
			uvm_phase_type type_e;
			A_next_node  = A.get_end_node();
			type_e = A_next_node.get_phase_type();
			$display("phase type of next node is 0x%0h", type_e);
		end 
		
	endfunction 


	virtual function void uvm_phase_try_1;
		begin 
			uvm_phase A = new(.name("A"), .phase_type(UVM_PHASE_SCHEDULE), .parent(null));
//			A.add(null);
		end
		
		begin 
			uvm_phase A = new(.name("A"), .phase_type(UVM_PHASE_SCHEDULE), .parent(null));
			A.add(A);

		end
		
		
		
	endfunction 


endclass 





`endif 