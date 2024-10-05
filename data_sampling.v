module data_sampling (
input wire CLK,
input wire RST,
input wire [5:0] edge_cnt,
input wire data_sample_en,
input wire rx_in,
input wire [5:0] prescale,
output sampled_data 
);

reg [2:0] sampled_bits;

assign sampled_data = (sampled_bits[0] && sampled_bits[1]) | (sampled_bits[0] && sampled_bits[2]) | (sampled_bits[1] && sampled_bits[2]);

always @(posedge CLK or posedge RST) begin
	if (~RST) begin
		sampled_bits <= 3'b111;
	end
	else if (data_sample_en) begin
		if (edge_cnt == (prescale/2) - 1) begin
			sampled_bits[0] <= rx_in;
		end else if (edge_cnt == (prescale/2)) begin
			sampled_bits[1] <= rx_in;
		end else if (edge_cnt == (prescale/2) + 1) begin
			sampled_bits[2] <= rx_in;
		end
	end
end


endmodule