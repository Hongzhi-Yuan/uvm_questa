`ifndef UVM_CONTAINER_TEST__SV
`define UVM_CONTAINER_TEST__SV







class uvm_container_test extends  uvm_test;
	uvm_queue#(int) global_queue;
	`uvm_component_utils(uvm_container_test)
	
	function new(string  name = "uvm_container_test", uvm_component parent = null );
		super.new(name, parent);	
	endfunction 
	
	/**
	
	 * @see uvm_pkg::uvm_component.main_phase
	
	 * @param phase - 
	
	 * 
	
	 */
	virtual task main_phase(uvm_phase phase);
		// TODO Auto-generated task stub
//		test_queue();
		test_pool();
		
		super.main_phase(phase);
		
	endtask : main_phase
	
	
	virtual  function void test_queue();
		this.uvm_queue_test("demo");	
		this.uvm_queue_test("demo_push_back");
		this.uvm_queue_test("demo_push_front");
		this.uvm_queue_test("demo_insert");
		this.uvm_queue_test("demo_delete");
		this.uvm_queue_test("demo_pop_front");
		this.uvm_queue_test("demo_pop_back");
		this.uvm_queue_test("demo_cover2string");
	endfunction 


	virtual function void uvm_queue_test(string cmd);
		static uvm_queue#(int) static_int_queue;
		static string queue2string;
		static_int_queue = uvm_queue#(int)::get_global_queue();
		
		case (cmd)
			"global" : begin 
				uvm_queue#(int) demo_queue = uvm_queue#(int)::get_global_queue();
				string type_name = "";
				type_name = demo_queue.get_type_name();
				
			end 
			
			"demo"	: begin 
				uvm_queue#(int) demo_queue ;
				uvm_queue#(int) demo_new_queue ;
				
				demo_queue = uvm_queue#(int)::get_global_queue();
				if ($cast(demo_queue, demo_queue.create("demo_queue"))) begin 
					string name = "";
					name = demo_queue.get_name();
					$display(name);
				end 
				
			end 
			
			"demo_push_back": begin 
				static_int_queue.push_back(100);
				static_int_queue.push_back(200);
				static_int_queue.push_back(300);
				static_int_queue.push_back(400);
				static_int_queue.push_back(500);
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			"demo_push_front" : begin 
				static_int_queue.push_front(50);
				static_int_queue.push_front(40);
				static_int_queue.push_front(30);
				static_int_queue.push_front(20);
				static_int_queue.push_front(10);
				
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			"demo_pop_front" : begin 
				void'(static_int_queue.pop_back());
				void'(static_int_queue.pop_back());
				void'(static_int_queue.pop_back());
				void'(static_int_queue.pop_back());
				void'(static_int_queue.pop_back());
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			
			"demo_pop_back" : begin 
				void'(static_int_queue.pop_front());
				void'(static_int_queue.pop_front());
				void'(static_int_queue.pop_front());
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			"demo_insert" : begin 
				static_int_queue.insert(0, 5);
				static_int_queue.insert(0, 4);
				static_int_queue.insert(0, 3);
				static_int_queue.insert(0, 2);
				static_int_queue.insert(0, 1);
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			"demo_delete" : begin 
				static_int_queue.delete(0);
				static_int_queue.delete(0);
				static_int_queue.delete(0);
				static_int_queue.delete(0);
				static_int_queue.delete(0);
				queue2string = static_int_queue.convert2string();
				$display(queue2string);
			end 
			
			"demo_docopy" : begin 
				
			end 
			
			"demo_cover2string" : begin 
				uvm_queue#(int) demo_queue;
				string queue_string = "";
				demo_queue = new("demo_queue");
				demo_queue.push_back(10);
				demo_queue.push_back(20);
				demo_queue.push_back(30);
				demo_queue.push_back(40);
				demo_queue.push_back(50);
				queue_string = demo_queue.convert2string();
				$display(queue_string);
			end 
			
			
			
			default :
				return ;
			
			
		endcase 

		
	endfunction 
	
	
	virtual function  void  test_pool();
		this.uvm_pool_test("globol");
		this.uvm_pool_test("demo");
		this.uvm_pool_test("demo_add");
	endfunction 
	
	
	virtual function void uvm_pool_test(string cmd);
		static uvm_pool#(string, int) static_pool;
		string type_name;
		static_pool = new("static_pool");
		case (cmd) 
			"globol" : begin 
				static_pool = uvm_pool#(string, int)::get_global_pool();
				type_name = static_pool.get_type_name();
				$display("********************type_name  = %0s******************************",   type_name);
			end 
			
			"demo" : begin 
				void'($cast(static_pool, static_pool.create("static_pool")));
				type_name = static_pool.get_name();
				$display(type_name);
			end 
			
			"demo_add":begin 
				static_pool.add("A", 1);
				static_pool.add("B", 2);
				static_pool.add("C", 3);
				static_pool.add("D", 4);
				static_pool.add("E", 5);
				
				$display("%0d",static_pool.get("A"));
				$display("%0d",static_pool.get("B"));
				$display("%0d",static_pool.get("C"));
				$display("%0d",static_pool.get("D"));
				$display("%0d",static_pool.get("E"));
				
				
			end 
			
			"demo_del":begin
				
			end 
			
				
			
			default:
				return ;
		endcase 
	endfunction 
endclass 



`endif 