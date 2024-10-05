module UART_Rx_TOP (
input wire CLK,
input wire RST,
input wire PAR_TYP,
input wire PAR_EN,
input wire [5:0] Prescale,
input wire RX_IN,
output wire [7:0] P_DATA,
output wire Data_valid,
output wire Parity_Error,
output wire Stop_Error
);

wire 	start_check_en, 
		sampled_bit, 
		start_glitch,
		stop_check_en,
		par_check_en,
		edge_bit_counter_en,
		data_sample_en,
		deserializer_en;


wire [3:0] bit_cnt;
wire [5:0] edge_cnt;


start_check Strt_check(
.CLK(CLK),
.RST(RST),
.start_check_en(start_check_en),
.sampled_bit(sampled_bit),
.start_glitch(start_glitch)
);

stop_check stp_check(
.CLK(CLK),
.RST(RST),
.stop_check_en(stop_check_en),
.sampled_bit(sampled_bit),
.stop_err(Stop_Error)
);

par_check parity_check(
.CLK(CLK),
.RST(RST),
.par_check_en(par_check_en),
.par_typ(PAR_TYP),
.p_data(P_DATA),
.sampled_bit(sampled_bit),
.par_err(Parity_Error)
);

edge_bit_counter counter(
.CLK(CLK),
.RST(RST),
.edge_bit_counter_en(edge_bit_counter_en),
.prescale(Prescale),
.par_en(PAR_EN),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt)
);

data_sampling data_sampler(
.CLK(CLK),
.RST(RST),
.edge_cnt(edge_cnt),
.data_sample_en(data_sample_en),
.rx_in(RX_IN),
.prescale(Prescale),
.sampled_data(sampled_bit)
);

deserializer deserializer(
.CLK(CLK),
.RST(RST),
.deserializer_en(deserializer_en),
.sampled_data(sampled_bit),
.bit_cnt(bit_cnt),
.p_data(P_DATA)
);

FSM_UART_Rx FSM(
.CLK(CLK),
.RST(RST),
.rx_in(RX_IN),
.par_en(PAR_EN),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt),
.par_err(Parity_Error),
.start_glitch(start_glitch),
.stop_err(Stop_Error),
.prescale(Prescale),
.data_sample_en(data_sample_en),
.edge_bit_counter_en(edge_bit_counter_en),
.par_check_en(par_check_en),
.start_check_en(start_check_en),
.stop_check_en(stop_check_en),
.deserializer_en(deserializer_en),
.data_valid(Data_valid)
);

endmodule