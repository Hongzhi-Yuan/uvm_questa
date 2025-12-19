`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV


class my_driver extends uvm_driver#(my_transaction);
	
	
	virtual my_if vif;

	`uvm_component_utils(my_driver)
	
	function new(string name = "my_driver", uvm_component parent = null );
		// TODO Auto-generated constructor stub
	
		
	
		super.new(name, parent);
	
		
	endfunction : new
	

	virtual function void build_phase(uvm_phase phase);
		// TODO Auto-generated function stub
		if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
			`uvm_fatal(get_full_name(), "virtual interface nust be set!!!!!!!!!!!")
			
		
		super.build_phase(phase);
		
	endfunction : build_phase
	

	virtual task main_phase(uvm_phase phase);
//		super.main_phase(phase);
		// TODO Auto-generated task stub
//		phase.raise_objection(this);
		/*
		 * wait reset done
		 */
		while(vif.reset)
			@(posedge vif.clock);
		
		
		/*
		 * drive 3 pkts
		 */
		
//		repeat (3) begin 
//			req = my_transaction::type_id::create("req");	
//			assert(
//				req.randomize() with {
//					req.pload.size() == 50;
//				}
//			)
//			drive_one_pkt(req);
//		end 
		
		
		forever  begin 
			this.seq_item_port.get_next_item(req);
			req.print();
			drive_one_pkt(req);
			this.seq_item_port.item_done();
		end 

//		phase.phase_done.set_drain_time(this, 200ns);

//		phase.drop_objection(this);
		
		/*
		 * drive one pkt
		 */
	
	
	
		
	
		
	endtask : main_phase


	virtual task drive_one_pkt(REQ trans);
		
		bit [47:0] data_tmp;
		byte pload_tmp [];
		
		
//		`uvm_info(get_full_name(), "Start drive one pkt", UVM_LOW)
		@(posedge vif.clock);
		vif.valid <= 'b1;
		
		/*
		 * dmac
		 */
		data_tmp = trans.dmac;
		for (int i = 0 ; i < 6 ; i++) begin 
			@(posedge vif.clock);
			vif.data <= data_tmp[47:40];
			data_tmp <<= 8;
		end 
		
		/*
		 * smac 
		 */
		data_tmp = trans.smac;
		for (int i = 0 ; i < 6 ; i++) begin 
			@(posedge vif.clock);
			vif.data <= data_tmp[47:40];
			data_tmp <<= 8;
		end 
		
		/*
		 * ether_type
		 */
		data_tmp[47-:16] = trans.smac;
		for (int i = 0 ; i < 6 ; i++) begin 
			@(posedge vif.clock);
			vif.data <= data_tmp[47:40];
			data_tmp <<= 8;
		end 
		
		
		/*
		 * pload
		 */
		pload_tmp = trans.pload;
		for (int i = 0; i < trans.pload.size(); i++) begin 
			@(posedge vif.clock);
			vif.data <= pload_tmp[i];
		end 
		
		
		/*
		 * crc
		 */
		data_tmp[47-:32] = trans.crc;
		for (int i = 0; i<4;i++) begin 
			@(posedge vif.clock);
			vif.data <= data_tmp[47-:8];
			data_tmp <<= 8;
		end 
		
		@(posedge vif.clock);
		vif.valid <= 'b0;
//		`uvm_info(get_full_name(), "Finish drive one pkt", UVM_LOW)
		
	endtask 

	
endclass



`endif 