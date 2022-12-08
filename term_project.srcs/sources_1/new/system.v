`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 09:26:24 PM
// Design Name: 
// Module Name: system
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


module system(
    output wire RsTx, 
    input wire RsRx,
    input btnC,
    input clk
    );
    
    reg en, last_rec;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire sent, received, baud;
    
    baudrate baudrate(clk, baud);
    uart_rx receiver(baud, RsRx, received, data_out);
    uart_tx transmitter(baud, data_in, en, sent, RsTx);
    
    wire reset;
    siglePulser sp(reset, btnC, baud);
    
    reg signed [31:0] value_in;
    reg [1:0] op;
    reg return, cal_en;
    wire signed [31:0] result;
    wire overflow;
    calculator cal(value_in, op, reset, return, cal_en, clk, result, overflow);
    
    reg state;
    reg [31:0] data_num;
    reg [7:0] data_op;
    reg [2:0] counter;
    initial begin
        state = 0; // 0 - read number, 1 - read operation & enable calculation
        counter = 0;
        data_num = 0;
        value_in = 0;
        op = 0;
        cal_en =0;
    end
    strToInt s(data_num, value_in);
    
    always @(posedge baud) begin
        if (en) en = 0;
        if (~last_rec & received) begin        
            data_in = data_out;
            if (data_in != 8'hFF) en = 1;
            case(state)
                0: begin
                    cal_en = 0;
                    if(data_out >= 8'h30 && data_out <= 8'h39) begin
                        case(counter)
                            0: data_num[7:0] = data_out;
                            1: data_num[15:8] = data_out;
                            2: data_num[23:16] = data_out;
                            3: data_num[31:24] = data_out;
                        endcase
                        counter = counter + 1;
                    end
                    else begin
                        counter = 0;
                        data_op = data_out;
                        state = 1;
                    end 
                end
                1: begin
                    case(data_op)
                        8'h2B: op = 2'b00;
                        8'h2D: op = 2'b01;
                        8'h2A: op = 2'b10;
                        8'h2F: op = 2'b11;
                        8'h3D: return = 1;
                    endcase
                    state = 0;
                    cal_en = 1;
                end
            endcase
        end
        last_rec = received;
    end
endmodule
