module edge_bit_counter(
input wire CLK,
input wire RST,
input wire edge_bit_counter_en,
input wire [5:0] prescale,
input wire par_en,
output reg [3:0] bit_cnt,
output reg [5:0] edge_cnt
);


always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		bit_cnt <= 4'b0;
		edge_cnt <= 6'b0;		
	end
	else if (edge_bit_counter_en) begin
		 if (edge_cnt == (prescale-1)) begin
			bit_cnt <= bit_cnt + 1;
			if (bit_cnt == 9 && par_en ==0) begin
				bit_cnt <= 4'b0;
				edge_cnt <= 6'b0;
			end else if(bit_cnt == 10 && par_en ==1) begin
				bit_cnt <= 4'b0;
				edge_cnt <= 6'b0;
			end else begin
				edge_cnt <= 6'b0;
			end
		end else begin
			edge_cnt <= edge_cnt + 1;
		end
	end
end

endmodule