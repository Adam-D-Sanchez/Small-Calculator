`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 08:09:15 PM
// Design Name: 
// Module Name: Calc_tb
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


module Calc_tb(

    );

reg tb_clk, tb_go;
reg [1:0] tb_op;
reg [2:0] tb_in1, tb_in2;
wire [2:0] tb_out;
wire tb_done;
wire[3:0] tb_current;
integer one, two, opper;
reg[2:0] e_out;

FSM_Calc DUT(.CLK(tb_clk),.GO(tb_go),.OP(tb_op),.IN1(tb_in1),.IN2(tb_in2),.OUT(tb_out),.DONE(tb_done),.CURRENT(tb_current));

initial begin
	tb_clk=0;
	#1;
	forever begin
		tb_clk=~tb_clk;
		#1; //Free running clock/
	end
end


initial begin
	for(one=0;one<=3'b111;one=one+1)begin
		for(two=0;two<=3'b111;two=two+1)begin 
			for(opper=0;opper<=2'b11;opper=opper+1)begin
				tb_in1=one;
				tb_in2=two;
				tb_op=opper;
				tb_go=1;
				case(opper)
				2'b00: e_out=one^two;
				2'b01: e_out=one&two;
				2'b10: e_out=one-two;
				default: e_out=one+two;
				endcase
				#2;
				tb_go=0;
				#8;
				if(tb_out!=e_out) begin $display("Operation %d failed with input %d and %d",opper, one,two); $stop; end
				if(!tb_done) begin $display("Done signal failed with operation %d and inputs %d and %d.", opper, one, two); $stop; end
				#2;
			end
	end
	
end
$display("All tests successful.");
$finish;

end

endmodule
