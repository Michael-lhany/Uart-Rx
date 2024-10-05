module FSM_UART_Rx (
input wire CLK,
input wire RST,
input wire rx_in,
input wire par_en,
input wire [3:0] bit_cnt,
input wire [5:0] edge_cnt, 
input wire par_err,
input wire start_glitch,
input wire stop_err,
input wire [5:0] prescale,
output reg data_sample_en,
output reg edge_bit_counter_en,
output reg par_check_en,
output reg start_check_en,
output reg stop_check_en,
output reg deserializer_en,
output reg data_valid
); 

typedef enum bit [2:0] {	
		IDLE = 3'b000,
		START = 3'b001,
		DATA = 3'b011,
		PARITY = 3'b010,
		STOP = 3'b110
} states;

states		current_state,
			next_state ;

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		current_state <= IDLE;
	end
	else begin
		current_state <= next_state;
	end
end

always @(*) begin
	case(current_state)
	IDLE : begin
		if (rx_in == 0) begin
			next_state = START;
		end else begin
			next_state = IDLE;
		end
	end
	START : begin
		if (bit_cnt == 1) begin
			if (start_glitch == 0) begin
				next_state = DATA;
			end else begin
				next_state = IDLE;
			end
		end else begin
			next_state = START;
		end
	end
	DATA : begin
		if (bit_cnt == 9) begin
			if (par_en == 1) begin
				next_state = PARITY;
			end else begin
				next_state = STOP;
			end
		end else begin
			next_state = DATA;
		end
	end
	PARITY : begin
		if (bit_cnt == 10) begin
			next_state = STOP;
		end else begin
			next_state = PARITY;
		end
	end
	STOP : begin
		if (bit_cnt == 0) begin
			if (rx_in == 0) begin
				next_state = START;
			end else begin
				next_state = IDLE;
			end
		end	else begin
			next_state = STOP;
		end		
	end
	default : begin
		next_state = IDLE;
	end
	endcase
end

always @(*) begin
	case(current_state)
	IDLE  : begin
		data_sample_en = 0;
		edge_bit_counter_en = 0;
 		par_check_en = 0;
		start_check_en = 0;
		stop_check_en = 0;
		deserializer_en = 0;
		data_valid = 0;
	end
	START : begin
		data_sample_en = 1;
		edge_bit_counter_en = 1;
 		par_check_en = 0;
		if (edge_cnt == (prescale/2) + 1) begin
			start_check_en = 1;
		end else begin
			start_check_en = 0;
		end
		stop_check_en = 0;
		deserializer_en = 0;
		data_valid = 0;
	end
	DATA : begin
		data_sample_en = 1;
		edge_bit_counter_en = 1;
 		par_check_en = 0;
		if (edge_cnt == (prescale/2) + 1) begin
			deserializer_en = 1;
		end else begin
			deserializer_en = 0;
		end
		stop_check_en = 0;
		start_check_en = 0;
		data_valid = 0;
	end
	PARITY : begin
		data_sample_en = 1;
		edge_bit_counter_en = 1;
 		deserializer_en = 0;
		if (edge_cnt == (prescale/2) + 1) begin
			par_check_en = 1;
		end else begin
			par_check_en = 0;
		end
		stop_check_en = 0;
		start_check_en = 0;
		data_valid = 0;
	end
	STOP : begin
		data_sample_en = 1;
		edge_bit_counter_en = 1;
 		par_check_en = 0;
		if (edge_cnt == (prescale/2) + 1) begin
			stop_check_en = 1;
		end else begin
			stop_check_en = 0;
		end
		start_check_en = 0;
		deserializer_en = 0;
		if (par_err == 0 && stop_err == 0) begin
			data_valid = 1;
		end else begin
			data_valid = 0;
		end
	end
	default  : begin
		data_sample_en = 0;
		edge_bit_counter_en = 0;
 		par_check_en = 0;
		start_check_en = 0;
		stop_check_en = 0;
		deserializer_en = 0;
		data_valid = 0;
	end
	endcase
end

endmodule