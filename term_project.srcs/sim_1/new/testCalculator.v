`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 11:36:09 PM
// Design Name: 
// Module Name: testCalculator
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


module testCalculator();

reg signed [31:0] value_in;
reg [1:0] op; 
reg reset, return, clk;
wire signed [31:0] result;
wire overflow;

calculator c(value_in, op, reset, return, clk, result, overflow);

always
    #10 clk=~clk;

initial
begin
    $monitor("input %d, op %b, reset %b, return %b, result %d, overflow %b", value_in, op, reset, return, result, overflow);
    #0 clk=0; value_in=0; return=0; reset=0; op=0;
    #10 value_in=10; op=0; // S = 10
    #20 value_in=13; op=0; // S = 23
    #20 return=1; // result = 23
    #20 return=0; value_in=100; op=0; // S = 123
    #20 value_in=1123; op=1; // S = -1000
    #20 value_in=2; op=2; // S = -2000
    #20 value_in=5; op=3; // S = -400
    #20 return=1; // result = -400
    #20 return=0; value_in=500; op=0; // S = 100
    #20 value_in=2; op=2; // S = 200
    #20 value_in=5; op=3; // S = 40
    #20 reset=1; // result = 0
    #20 reset=0; value_in=9999; op=0; // S = 9999
    #20 value_in=10; op=0; // overflow = 1
    #20 return=1;
    #20 $finish;
end  
    
                
endmodule
