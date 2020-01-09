`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/08 12:58:12
// Design Name: 
// Module Name: top
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

module top(
           input [31:0] a,b,
           output [31:0] gcd_out,
           output reg STOP,
           input clk, clr
           );
           
wire xsel, ysel, xmld, ymld, gmld, eqmflg, ltmflg;
wire stop;

gcd_datapath U1(.clk(clk), 
                .clr(clr), 
                .xmsel(xsel), 
                .ymsel(ysel), 
                .xld(xmld), 
                .yld(ymld), 
                .gld(gmld), 
                .xin(a), 
                .yin(b), 
                .eqflg(eqmflg), 
                .ltflg(ltmflg),
                .gcd(gcd_out));
    
gcd_control U2(.clk(clk), 
                .clr(clr), 
                .eqflg(eqmflg), 
                .ltflg(ltmflg),
                .stop(stop),
                .xld(xmld), 
                .yld(ymld), 
                .xmsel(xsel), 
                .ymsel(ysel), 
                .gld(gmld));
                
    always @ (posedge clk) begin
        STOP <= stop;
        end
        
endmodule
