`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 09:27:01 PM
// Design Name: 
// Module Name: testALU
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


module testALU();

reg signed [31:0] A, B;
reg [1:0] alu_op;
wire signed [31:0] S;
wire overflow;
alu a(A, B, alu_op, S, overflow);

initial
begin
    $monitor("A %d, B %d, op %b, result %d, overflow %b",A, B, alu_op, S, overflow);
    #0 A=0; B=0; alu_op=0;
    #10 A=167; B=3456; alu_op=0;
    #10 A=1000; B=-100; alu_op=0;
    #10 A=897; B=123; alu_op=1;
    #10 A=123; B=897; alu_op=1;
    #10 A=111; B=22; alu_op=2;
    #10 A=22; B=100; alu_op=2;
    #10 A=1000; B=5; alu_op=3;
    #10 A=100; B=3; alu_op=3;
    #10 A=5; B=10; alu_op=3;
    #10 A=9999; B=1; alu_op=0;
    #10 A=-10; B=9999; alu_op=1;
    #5 $finish; 
end
endmodule
