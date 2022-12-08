`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 09:34:49 PM
// Design Name: 
// Module Name: testIntToStr
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


module testIntToStr();

wire [39:0] num_str;
reg signed [31:0] num_int;

IntToStr i(num_int, num_str);

initial
begin
    $monitor("int input: %d, str output: %s", num_int, num_str);
    #0 num_int = 1;
    #20 num_int = 12;
    #20 num_int = 123;
    #20 num_int = 1234;
    #20 num_int = -1;
    #20 num_int = -12;
    #20 num_int = -123;
    #20 num_int = -1234;
    #20 $finish;
end

endmodule
