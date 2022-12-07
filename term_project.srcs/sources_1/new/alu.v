`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 08:46:57 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input signed [31:0] A,
    input signed [31:0] B,
    input [1:0] alu_op,
    output reg signed [31:0] S,
    output reg overflow
    );
    
    always @(A or B or alu_op)
    begin
        case(alu_op)
            2'b00: S = A + B;
            2'b01: S = A - B;
            2'b10: S = A * B;
            2'b11: S = A / B;
        endcase
        overflow = (S>9999 || S<-9999); 
    end

endmodule
