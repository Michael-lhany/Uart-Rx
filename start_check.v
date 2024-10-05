module start_check(
input wire CLK,
input wire RST,
input wire start_check_en,
input wire sampled_bit,
output reg start_glitch
);

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		start_glitch <= 'b0;
	end
	else if (start_check_en) begin
		if (sampled_bit == 'b0) begin
			start_glitch <= 'b0;
		end else begin
			start_glitch <= 'b1;
		end
	end
end

endmodule