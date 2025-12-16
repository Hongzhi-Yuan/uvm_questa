`ifndef uvm_phase_test__v2__sv
`define uvm_phase_test__v2__sv


function automatic void info();

	uvm_phase demo;
	demo = new("demo", UVM_PHASE_SCHEDULE, null);
	$display(demo.get_state());
	
endfunction 

function automatic  void  phase_test01();
	
	/*
	 * 与 m_end_node建立链接节点
	 */
	
	uvm_phase phase_stp0 = new("phase_stp0", UVM_PHASE_SCHEDULE, null);
	uvm_phase phase_stp0_1 = new("phase_stp0_1", UVM_PHASE_NODE, phase_stp0);
	uvm_phase phase_stp0_2 = new("phase_stp0_2", UVM_PHASE_NODE, phase_stp0);
	uvm_phase phase_stp0_3 = new("phase_stp0_3", UVM_PHASE_NODE, phase_stp0);
	uvm_phase phase_stp1 = new("phase_stp1", UVM_PHASE_NODE, phase_stp0);
	uvm_phase phase_stp1_1 = new("phase_stp1_1", UVM_PHASE_NODE, phase_stp1);
	uvm_phase phase_stp1_2 = new("phase_stp1_2", UVM_PHASE_NODE, phase_stp1_1);
	uvm_phase phase_stp1_3 = new("phase_stp1_3", UVM_PHASE_NODE, phase_stp1_2);


	
	/*
	 * get parent node 
	 */
	
	begin 
		uvm_phase parent_node = phase_stp1_3.get_parent();
		$display(parent_node.get_name());
	end 
	
	
	/*
	 * get imp
	 */
	begin 
		if (phase_stp0.get_imp() == null )
			$display("null");
	end 
	
	/*
	 * get domain name
	 */
	
//	begin 
//		string name1 = "";
//		string name2 = "";
//		string name3 = "";
//		name1 = phase_stp0_1.get_domain_name();
//		name2 = phase_stp0_3.get_domain_name();
//		name3 = phase_stp1_3.get_domain_name();
//		$display("name1 = %0s", name1);
//		$display("name2 = %0s", name2);
//		$display("name3 = %0s", name3);
//	end 



	/*
	 * get schdule name 
	 */
	begin 
		string schedule_name = "";
		schedule_name = phase_stp1_2.get_schedule_name(0);
		$display("schedule_name = %0s", schedule_name);
	end 
	
	
	/*
	 * get full name
	 */
	begin 
		string full_name = "";
		full_name = phase_stp1_3.get_full_name();
		$display("full_name = %0s", full_name);
	end 
	
	
	
	/*
	 * print successors
	 */
	begin 
		phase_stp0.m_print_successors();
	end 
	
	
	
	
	
endfunction 


function automatic void phase_test_02();
	uvm_phase ph0 = new("ph0");
	uvm_phase ph1 = new("ph1");
	uvm_phase ph2 = new("ph2");
	uvm_phase ph3 = new("ph3");
	
	uvm_phase sch = new("sch", UVM_PHASE_DOMAIN);
	
	begin 
		sch.add(ph0);
//		sch.add(ph0);
//		sch.add(ph1);
//		sch.add(ph2);
//		sch.add(ph3);
//		sch.m_print_successors();
	end 
	
	
	
	
endfunction 








`endif 