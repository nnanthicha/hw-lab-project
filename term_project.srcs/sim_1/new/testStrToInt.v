`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 04:47:35 PM
// Design Name: 
// Module Name: testStrToInt
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


module testStrToInt();

reg [31:0] num_str;
wire [31:0] num_int;

strToInt s(num_str, num_int);

initial
begin
    $monitor("str input: %s, int output: %d", num_str, num_int);
    #0 num_str = 8'h31; 
    #10 num_str = 16'h31_32; 
    #10 num_str = 24'h31_32_33; 
    #10 num_str = 32'h31_32_33_34; 
    #20 $finish;
end

endmodule
