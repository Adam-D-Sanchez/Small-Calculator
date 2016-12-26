`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2016 05:14:43 PM
// Design Name: 
// Module Name: FSMCalcFPGA
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


module FSMCalcFPGA(
input [2:0] in1, in2,
input [1:0] op,
input clk100MHz, go, button, rst,
output done,
output [7:0] LEDSEL, LEDOUT
    );
    
    supply1 [7:0] vcc;
    wire clk,p_clk;
    wire[2:0] A;
    wire [3:0] CURR;
    wire [6:0] B,D,E,F;
clk_gen ClockMaker(.clk100MHz(clk100MHz),.rst(rst),.clk_5KHz(p_clk));
debounce pushClock(.pb(button),.clk(p_clk),.pb_debounced(clk));
FSM_Calc Calculator(.CLK(clk),.GO(go),.OP(op),.IN1(in1),.IN2(in2),.OUT(A),.DONE(done),.CURRENT(CURR));
b27 CurrentState(.in(CURR),.s(B));
b27 Output(.in({1'b0,A}),.s(D));
b27 In1(.in({1'b0,in1}),.s(E));
b27 In2(.in({1'b0,in2}),.s(F));
led_mux DisplayDigits(.clk(p_clk),.rst(rst),.LED0({1'b1,E}),.LED1({1'b1,F}),.LED2(vcc),.LED3({1'b1,B}),.LED4(vcc),.LED5(vcc),.LED6(vcc),.LED7({1'b1,D}),.LEDSEL(LEDOUT),.LEDOUT(LEDSEL));


endmodule
