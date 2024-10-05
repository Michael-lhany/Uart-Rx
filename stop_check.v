module stop_check(
input wire CLK,
input wire RST,
input wire stop_check_en,
input wire sampled_bit,
output reg stop_err
);

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		stop_err <= 'b0;
	end
	else if (stop_check_en) begin
		if (sampled_bit == 'b1) begin
			stop_err <= 'b0;
		end else begin
			stop_err <= 'b1;
		end
	end
end

endmodule