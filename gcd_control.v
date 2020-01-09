`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/01/08 12:18:35
// Design Name: 
// Module Name: gcd_control
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


module gcd_control(
    input clk,
	input clr,
	input eqflg,
	input ltflg,
	output reg stop,
	output reg xld,
	output reg yld,
	output reg xmsel,
	output reg ymsel,
	output reg gld);

reg [2:0] current_state, next_state;
parameter start = 3'b000, 
           input1 = 3'b001, 
           test1 = 3'b010, 
           test2 = 3'b011, 
           update1 = 3'b100, 
           update2 = 3'b101, 
           done = 3'b110;

always @(posedge clk or clr) begin
	    if(clr) begin
	        current_state <= start;
	        stop <= 0;
	        end
	    else
	        current_state <= next_state;
	    end
	        
always @(*) begin 
		case(current_state)
			start:
					next_state <= input1;
			input1: 
			        next_state <= test1;
			test1: 
			    if(eqflg == 1)
					next_state <= done;
		        else
				    next_state <= test2;
			test2:
			     if(eqflg == 1)
					next_state <= done;
		        else if(ltflg == 1)
				    next_state <= update1;
				else
					next_state <= update2;
			update1: 
				next_state <= test1;
			update2:
				next_state <= test1;
			done: 
				next_state <= done;
			default:
				next_state = start;
		endcase
	end
	
always @(*) begin 
		case(current_state)
			start:
			    ;
			input1: begin
			    xmsel <= 1;
			    ymsel <= 1; 
			    xld <= 1;
			    yld <= 1; 
			    $display("data is input");
				end
			test1: begin
			    xmsel <= 0;
			    ymsel <= 0; 
			    xld <= 0;
			    yld <= 0;
			    $display("data is test1");
			    end
			test2: begin
			    xmsel <= 0;
			    ymsel <= 0; 
			    xld <= 0;
			    yld <= 0;
			    $display("data is test2");
					end
			update1: begin
			    yld <= 1;
			    xld <= 0;
			    ymsel <= 0;
			    $display("data is ud1");		
				end
			update2: begin
			    xld <= 1;
			    yld <= 0;
			    xmsel <= 0;
			    $display("data is ud2");
				end
			done: begin
			    gld <= 1;
			    stop <= 1;
			    $display("data is done");
				end
			default:
				next_state = start;
		endcase
	end
	
endmodule
