`ifndef MY_SEQUENCE1__SV
`define MY_SEQUENCE1__SV

class my_sequence1 extends uvm_sequence#(my_transaction);

	my_transaction m_trans;

	`uvm_object_utils(my_sequence1)
	`uvm_add_to_seq_lib(my_sequence1, my_sequence_lib)
	/**
	
	 * @see uvm_pkg::uvm_sequence.new
	
	 * @param name - 
	
	 * @return 
	
	 */
	function new(string name = "uvm_sequence");
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name);
		set_automatic_phase_objection(1);
		
	endfunction : new


	/**
	
	 * @see uvm_pkg::uvm_sequence_base.body
	
	 * 
	
	 * 
	
	 */
	virtual task body();
		// TODO Auto-generated task stub
	
		
		repeat (3) begin 
			`uvm_do_pri(m_trans, 200)
		end 
	
		
	endtask : body


	
endclass 




`endif 