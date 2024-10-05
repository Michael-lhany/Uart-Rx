module deserializer (
input wire CLK,
input wire RST,
input wire deserializer_en,
input wire sampled_data,
input wire [3:0] bit_cnt,
output reg [7:0] p_data
);


always @(posedge CLK or posedge RST) begin
	if (~RST) begin
		p_data <= 8'b00000000;
	end
	else if (deserializer_en) begin
		case (bit_cnt)
			4'b0001: begin
				p_data[0] <= sampled_data;
			end
			4'b0010: begin
				p_data[1] <= sampled_data;
			end
			4'b0011: begin
				p_data[2] <= sampled_data;
			end
			4'b0100: begin
				p_data[3] <= sampled_data;
			end
			4'b0101: begin
				p_data[4] <= sampled_data;
			end
			4'b0110: begin
				p_data[5] <= sampled_data;
			end
			4'b0111: begin
				p_data[6] <= sampled_data;
			end
			4'b1000: begin
				p_data[7] <= sampled_data;
			end
			default: begin
				p_data <= p_data;
			end
		endcase
	end
end

endmodule