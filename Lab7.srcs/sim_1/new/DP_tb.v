`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2016 07:05:31 PM
// Design Name: 
// Module Name: DP_tb
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


module DP_tb(

    );

reg [2:0] tb_in1, tb_in2, tb_expec;
reg [1:0] tb_s1, tb_wa, tb_raa, tb_rab, tb_c;
reg tb_we, tb_rea, tb_reb, tb_s2, tb_clk;
wire [2:0] tb_out;

DP DUT(.in1(tb_in1), .in2(tb_in2), .s1(tb_s1), .clk(tb_clk), .wa(tb_wa), .we(tb_we), .raa(tb_raa), .rea(tb_rea), .rab(tb_rab), .reb(tb_reb), .c(tb_c), .s2(tb_s2), .out(tb_out));


initial begin
	tb_clk=0;
	#5;
	forever begin 
	tb_clk=~tb_clk; //free running clock to be able to control inputs and outputs.
	#5;
	end
end

initial begin
	tb_in1=3'b101; //initializes the values of the inputs to the first mux.
	tb_in2=3'b010;

//this block intends to allow us to write 0 into register 0
	tb_we=1; // turns on write signal
	tb_wa=2'b00; //writes to register 0
	tb_s1=2'b01; //constant zero is the write data
	#20; //makes sure there are two cycles to allow a write TT:20

//this block intends to allow us to write in1 to register 1 in the register file.
	tb_wa=2'b01; //selects write address
	tb_s1=2'b11; //slects in1 to be the output of the first mux.
	#20; //makes sure there are two cyles to allow a write.TT:40


//this block intends to allow us to write in2 into register 2 in the register file. Write is still enabled.
	tb_wa=2'b10;
	tb_s1=2'b10;
	#20; //makes sure there are two cyles to allow a write.TT:60


//this block intends to have the outputs Dout_A and Dout_b established from the appropriate register
	tb_rea=1; //turns on the read enables on the register file.
	tb_reb=1; 

	tb_raa=2'b01;//sets Dout A to be the contents at register 1
	tb_rab=2'b10; //sets Dout B to be the contents at register 2
	//Combinational, so it won't need to wait for signals.


//this block will have the inputs to the ALU be added. , have the output stored at register three, then have out have the contents at register 3
	tb_wa=2'b11;//sets the write address to register 3.
	tb_s1=2'b00; //sets the Mux1 output as the output of the ALU
	tb_c=2'b00; //tells the ALU to add the two values together
	#6; //allows a write cycle to occur TT:66
	tb_raa=2'b00;//zero input to alu
	tb_rab=2'b11;//third register to alu
	tb_expec=3'b111;
	tb_s2=1;//mux2's output is the same as the contents of register three. 
	#2;//allow updates TT:68
	
	if(tb_out!=tb_expec) begin
		$display("Addition failed.");
		$stop;
	end
	#2;//now in a low, setting up next cycle TT:70

//this block will have a subtraction occur, have the output stored at register three, then have out have the contents at register 3
	tb_raa=2'b01;//sets Dout A to be the contents at register 1
	tb_rab=2'b10; //sets Dout B to be the contents at register 2
	tb_c=2'b01;//subtraction opcode for ALU
	tb_s2=0; //zero output at mux 2
	#6;//allows a write cycle to occur TT:76
	tb_c=2'b00; //tells the ALU to add the two values together
	tb_raa=2'b00;//zero input to alu
	tb_rab=2'b11;//third register to alu
	tb_s2=1;//mux2's output is the same as the contents of register three.
	tb_expec=3'b011; 
	#2;//allow updates TT:78
	if(tb_out!=tb_expec) begin
		$display("Subtraction failed.");
		$stop;
	end
	#2;//now in a low, setting up next cycle TT:80
	

//this block will have the inputs AND-ed, have the output stored at register three, then have out have the contents at register 3
	tb_raa=2'b01;//sets Dout A to be the contents at register 1
	tb_rab=2'b10; //sets Dout B to be the contents at register 2
	tb_c=2'b10; //AND opcode for ALU
	tb_s2=0;//zero output at mux 2
	#6; //allows for a write cycle to occur TT:86
	tb_c=2'b00; //tells the ALU to add the two values together
	tb_raa=2'b00;//zero input to alu
	tb_rab=2'b11;//third register to alu
	tb_s2=1;//mux2's output is the same as the contents of register three. 
	tb_expec=3'b000; 
	#2;//allow updates TT: 88
	if(tb_out!=tb_expec) begin
		$display("AND failed.");
		$stop;
	end
	#2;//now in a low, setting up next cycle TT:90

//this block will have the inputs XOR-ed, have the output stored at register three, then have out have the contents at register 3
	tb_raa=2'b01;//sets Dout A to be the contents at register 1
	tb_rab=2'b10; //sets Dout B to be the contents at register 2
	tb_c=2'b11; //XOR opcode for ALU
	tb_s2=0;//zero output at mux 2
	#6; //allows for a write cycle to occur TT:96
	tb_c=2'b00; //tells the ALU to add the two values together
	tb_raa=2'b00;//zero input to alu
	tb_rab=2'b11;//third register to alu
	tb_s2=1;//mux2's output is the same as the contents of register three.
	tb_expec=3'b111;
	#2;//allow updates TT:98
	if(tb_out!=tb_expec) begin
		$display("XOR failed.");
		$stop;
	end
	#2;//now in a low, setting up next cycle TT:100
	$display("All tests passed.");
	$finish; //should reach here at 100 ns

end




endmodule
