module par_check(
input wire CLK,
input wire RST,
input wire par_check_en,
input wire par_typ,
input wire [7:0] p_data,
input wire sampled_bit,
output reg par_err
);

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		par_err <= 'b0;
	end
	else if (par_check_en) begin
		if (par_typ == 'b0) begin	
			if (sampled_bit == ^p_data) begin
				par_err <= 'b0;
			end else begin
				par_err <= 'b1;
			end
		end else begin
			if (sampled_bit == ~^p_data) begin
				par_err <= 'b0;
			end else begin
				par_err <= 'b1;
			end
		end
	end
end

endmodule