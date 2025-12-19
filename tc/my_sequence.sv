`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV



typedef class my_sequencer;


class my_sequence extends uvm_sequence#(my_transaction);
	my_transaction m_trans;

//	my_sequencer p_sequencer;

	`uvm_object_utils(my_sequence)
//	`uvm_declare_p_sequencer(my_sequencer)
	function new(string name = "uvm_sequence");
		// TODO Auto-generated constructor stub
	
	
		super.new(name);
		set_automatic_phase_objection(1);
		
	
		
	endfunction : new

	
	
	virtual task body();
		
		
		uvm_phase p;

    	// 拿到当前执行本 sequence 的 phase（通常是 run 或 main）
    	p = get_starting_phase();
    	if (p != null) begin
      		p.get_objection().set_drain_time(this, 200ns);
    	end
		
		repeat (3) begin 
			
//			uvm_test_done.raise_objection(this);
			
			`uvm_create(m_trans)
			`uvm_send(m_trans)
			
			
//			uvm_test_done.drop_objection(this);
		end 
		
		
	endtask : body
	
	
endclass 



`endif 