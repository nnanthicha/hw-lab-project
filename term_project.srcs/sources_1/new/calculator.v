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
    input clk,
    output reg signed [31:0] result,
    output wire overflow
    );
    reg state; // 0 - calculate, 1 - return result
    reg signed [31:0] S1;
    wire signed [31:0] S2;
    initial 
    begin
        state=0;
        S1 = 0;
    end
    always @(posedge clk)
    begin
        if(return)
            state = 1;
        if(reset)
            begin
                state = 0;
                S1 = 0;
                result = 0;
            end
        else
        begin
            if(state)
                begin
                    result = S2;
                    state = 0;
                end
            else if (state == 0)
                S1 = S2;
        end
        $monitor("state %b, S1 %d, S2 %d", state, S1, S2);
    end
    alu alu(S1, value_in, op, S2, overflow); 

endmodule
