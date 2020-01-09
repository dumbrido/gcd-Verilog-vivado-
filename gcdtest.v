`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/08 13:04:00
// Design Name: 
// Module Name: gcdtest
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

module gcdtest();
reg [31:0] a;
reg [31:0] b;
reg clk;
reg clr;
wire [31:0] gcd_out;
wire stop;

top uut(.a(a),
        .b(b),
        .gcd_out(gcd_out),
        .STOP(stop),
        .clk(clk),
        .clr(clr));

initial begin
    a = 0;
    b = 0;
    clk = 0;
    clr = 1;
    end
    
always 
    #10 clk = ~clk;
    
initial begin
    #80;
    clr = 0;
    end
    
initial begin
    #30;
    a = 98;
    b = 63;
    end

endmodule
