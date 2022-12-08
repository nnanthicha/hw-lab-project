`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 10:47:34 PM
// Design Name: 
// Module Name: calculator
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


module calculator(
    input signed [31:0] value_in,
    input [1:0] op,
    input reset,
    input return,
    input enable,
    input clk,
    output reg signed [31:0] result,
    output wire overflow
    );
    reg state; // 0 - calculate, 1 - return result
    reg signed [31:0] A;
    wire signed [31:0] S;
    
    initial
        A = 0;
    always @(posedge clk)
    begin
        state = enable;
        if(return) begin
            result = S;
            state = 0;
        end
        if(reset) begin
            state = 0;
            A = 0;
            result = 0;
        end
        else begin
            if (state)
                A = S;
        end
//        $monitor("state %b, A %d, S %d", state, A, S);
    end
    alu alu(A, value_in, op, S, overflow); 

endmodule
