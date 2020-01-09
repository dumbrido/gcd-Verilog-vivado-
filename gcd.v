`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/24 19:33:55
// Design Name: 
// Module Name: gcd
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

module gcd_datapath(
    input clk,
    input clr,
    input xmsel,
    input ymsel,
    input xld,
    input yld,
    input gld,
    input [31:0] xin,
    input [31:0] yin,
    output reg eqflg,
    output reg ltflg,
    output /*wire*/ reg [3:0] gcd);

wire [31:0] xmy, ymx;
//wire [3:0] x, y, x1, y1;
reg [31:0] x, y, x1, y1;

always @(*) begin //xmux
    if(xmsel == 1)
        assign x1 = xin;
    else
        assign x1 = xmy;
    end
    
always @(*) begin //ymux
    if(ymsel == 1)
        assign y1 = yin;
    else
        assign y1 = ymx;
    end
    
always @(posedge clk) begin //xreg
            if(clr == 1) begin
                x <= 0;
                end
            else if(xld == 1) begin
                x <= x1;
                end
            else begin
                x <= x;
                end
    end
    
always @(posedge clk) begin //yreg
            if(clr == 1) begin
                y <= 0;
                end
            else if(yld == 1) begin
                y <= y1;
                end
            else begin
                y <= y;
                end
    end

always @(posedge clk) begin //gcdreg
            if(clr == 1) begin
                gcd <= 0;
                end
            else if(gld == 1) begin
                gcd <= x;
                end
            else begin
                gcd <= gcd;
                end
    end
    
/*    
mux xmux(
    .sel(xmsel),
    .in0(xmy),
    .in1(xin),
    .muxout(x1)
);

mux ymux(
    .sel(ymsel),
    .in0(ymx),
    .in1(yin),
    .muxout(y1)
);

reg_file x_reg(
    .clk(clk),
    .clr(clr),
    .load(xld),
    .data(x1),
    .out(x)
);

reg_file y_reg(
    .clk(clk),
    .clr(clr),
    .load(yld),
    .data(y1),
    .out(y)
);

reg_file gcd_reg(
    .clk(clk),
    .clr(clr),
    .load(gld),
    .data(x),
    .out(gcd)
);
*/

assign xmy = x - y;
assign ymx = y - x;

always @(*) begin 
    if(x == y)
        eqflg <= 1;
    else
        eqflg <= 0;
end

always @(*) begin 
    if(x < y)
        ltflg <= 1;
    else
        ltflg <= 0;
end
 
endmodule
