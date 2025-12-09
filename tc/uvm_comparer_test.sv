`ifndef UVM_COMPARER_TEST__SV
`define UVM_COMPARER_TEST__SV



class uvm_comparer_test extends uvm_test;
	
	`uvm_component_utils(uvm_comparer_test)

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
	
//		demo_compare("compare_field");
		
//		demo_compare("compare_field_int");
		demo_compare("compare_object");
		super.main_phase(phase);
	
		
	
		
	endtask : main_phase
	
	
	virtual function void demo_compare(string cmd);
		case (cmd) 
			"compare_field" : begin 
				string name = "test0";
				uvm_bitstream_t  src_stream = 'h11223344;
				uvm_bitstream_t  dst_stream = 'h11aa3344;
				
				if (uvm_comparer::init().compare_field(name, src_stream, dst_stream, 20))
					$display("---------------------true-----------------");
				else 
					$display("---------------------false----------------");
			end 
			
			
			"compare_field_int" : begin 
				string name = "test1";
				uvm_integral_t lhs = 'h112233;
				uvm_integral_t rhs = 'haabb33;
				if (uvm_comparer::init().compare_field_int(name, lhs, rhs, 10))
					$display("--------------------true-------------------");
				else 
					$display("--------------------false------------------");
			end 
			
			
			
			"compare_object" : begin 
				string name = "test2";
				
				uvm_driver  drv1 = new(name, null);
				uvm_driver  drv2 = new(name, null);
				
				if (uvm_comparer::init().compare_object(name, drv1, drv1)) 
					$display("-------------------true-------------------");
				else 
					$display("-------------------false------------------");
				
				
			end 
			
			default:
				return ;
		endcase 
	endfunction 
	
	
	
endclass 



`endif 