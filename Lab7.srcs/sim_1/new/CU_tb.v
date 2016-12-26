`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2016 08:19:01 PM
// Design Name: 
// Module Name: CU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CU_tb(

    );

reg [1:0] tb_op;
reg tb_clk, tb_go;
wire tb_we, tb_rea, tb_reb, tb_sel2, tb_done;
wire [1:0] tb_sel1, tb_wa, tb_raa, tb_rab, tb_c;
wire [3:0] tb_current;
wire [14:0] tb_ctrl;
reg [14:0] e_ctrl;
integer i;
 

Calc_CU DUT(.clk(tb_clk),.go(tb_go),.op(tb_op),.we(tb_we),.rea(tb_rea),.reb(tb_reb),.sel2(tb_sel2),.done(tb_done),
			.sel1(tb_sel1), .wa(tb_wa), .raa(tb_raa), .rab(tb_rab), .c(tb_c),.Current(tb_current));

assign tb_ctrl={tb_sel1,tb_wa,tb_we,tb_raa,tb_rea,tb_rab,tb_reb,tb_c,tb_sel2,tb_done};
initial begin //free running clock
	tb_clk=0;
	#5;
	forever begin
	tb_clk=~tb_clk;
	#5;
	end
end

initial begin
	tb_go=0;
	tb_op=2'b00;
	e_ctrl=15'b010000000000000;
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
	tb_op=2'b01;
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
	tb_op=2'b10;
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
	tb_op=2'b11;
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; 
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		#10; //TT:200ns
		if (tb_ctrl!=e_ctrl) begin $display("Control signals are wrong with the %d opcode, and go disabled.",tb_op); $stop; end
		$display("Disabling go signal test passed.");
	tb_go=1;

for (i=0; i<=3; i=i+1) begin
	tb_op=i;//
		e_ctrl=15'b010000000000000;
		if (e_ctrl!=tb_ctrl) begin $display("Control signals for state 0 (IDLE) are wrong with opcode %d.",i); $stop; end
	#10;
		e_ctrl=15'b110110000000000;
		if (e_ctrl!=tb_ctrl) begin $display("Control signals for state 1 (LOAD1) are wrong with opcode %d.",i); $stop; end
	#10;
		e_ctrl=15'b101010000000000;
		if (e_ctrl!=tb_ctrl) begin $display("Control signals for state 2 (LOAD2) are wrong with opcode %d.",i); $stop; end
	#10;
		e_ctrl=15'b010000000000000;
		if (e_ctrl!=tb_ctrl) begin $display("Control signals for state 3 (WAIT) are wrong with opcode %d.",i); $stop; end
	#10
		case(i)
		 2'b00: begin e_ctrl=15'b001110111011100; 
		 		if (e_ctrl!=tb_ctrl)begin $display("Control signals for XOR failed with opcode %d",i); $stop; end end
		 2'b01: begin e_ctrl=15'b001110111011000; 
		 		if (e_ctrl!=tb_ctrl)begin $display("Control signals for AND failed with opcode %d",i); $stop; end end
		 2'b10: begin e_ctrl=15'b001110111010100; 
		 		if (e_ctrl!=tb_ctrl)begin $display("Control signals for SUB failed with opcode %d",i); $stop; end end
		 2'b11: begin e_ctrl=15'b001110111010000; 
		 		if (e_ctrl!=tb_ctrl)begin $display("Control signals for ADD failed with opcode %d",i); $stop; end end
		 endcase
	#10;
		e_ctrl=15'b010001111111011;
		if (e_ctrl!=tb_ctrl) begin $display("Control signals for state 5 (DONE) are wrong with opcode %d.",i); $stop; end
	#10;	
end

$display("All tests passed.");
$finish; //must run for at least 450ns.
end

endmodule
