`ifndef MY_SEQUENCE0__SV
`define MY_SEQUENCE0__SV


typedef class my_sequencer;
typedef class my_sequence_lib;



class my_sequence0 extends uvm_sequence#(my_transaction);
	
	
//	my_transaction m_trans;
	
	`uvm_object_utils(my_sequence0)
	`uvm_add_to_seq_lib(my_sequence0, my_sequence_lib)
	`uvm_declare_p_sequencer(my_sequencer)
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
	
		my_transaction m_trans;
		repeat (3) begin 
			`uvm_do_with(m_trans, {m_trans.dmac == p_sequencer.dmac;
				m_trans.smac == p_sequencer.dmac;
				})	
		end 
		
	endtask : body
	
	
endclass





`endif 