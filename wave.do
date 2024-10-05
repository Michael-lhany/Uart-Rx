onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Tb signals} -color Gold /UART_RX_TB/CLK_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/RST_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/PAR_TYP_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/PAR_EN_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/Prescale_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/RX_IN_tb
add wave -noupdate -expand -group {Tb signals} -color Blue -radix binary /UART_RX_TB/P_DATA_tb
add wave -noupdate -expand -group {Tb signals} -color Pink /UART_RX_TB/Data_valid_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/Parity_Error_tb
add wave -noupdate -expand -group {Tb signals} /UART_RX_TB/Stop_Error_tb
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/next_state
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/current_state
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/rx_in
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/par_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/bit_cnt
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/edge_cnt
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/par_err
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/start_glitch
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/stop_err
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/prescale
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/data_sample_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/edge_bit_counter_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/par_check_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/start_check_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/stop_check_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/deserializer_en
add wave -noupdate -expand -group FSM /UART_RX_TB/UART_RX/FSM/data_valid
add wave -noupdate -group {Start check} /UART_RX_TB/UART_RX/Strt_check/start_check_en
add wave -noupdate -group {Start check} /UART_RX_TB/UART_RX/Strt_check/sampled_bit
add wave -noupdate -group {Start check} /UART_RX_TB/UART_RX/Strt_check/start_glitch
add wave -noupdate -group {stop check} /UART_RX_TB/UART_RX/stp_check/stop_check_en
add wave -noupdate -group {stop check} /UART_RX_TB/UART_RX/stp_check/sampled_bit
add wave -noupdate -group {stop check} /UART_RX_TB/UART_RX/stp_check/stop_err
add wave -noupdate -group {parity check} /UART_RX_TB/UART_RX/parity_check/par_check_en
add wave -noupdate -group {parity check} /UART_RX_TB/UART_RX/parity_check/par_typ
add wave -noupdate -group {parity check} /UART_RX_TB/UART_RX/parity_check/p_data
add wave -noupdate -group {parity check} /UART_RX_TB/UART_RX/parity_check/sampled_bit
add wave -noupdate -group {parity check} /UART_RX_TB/UART_RX/parity_check/par_err
add wave -noupdate -group {edge counter} /UART_RX_TB/UART_RX/counter/edge_bit_counter_en
add wave -noupdate -group {edge counter} /UART_RX_TB/UART_RX/counter/prescale
add wave -noupdate -group {edge counter} /UART_RX_TB/UART_RX/counter/par_en
add wave -noupdate -group {edge counter} /UART_RX_TB/UART_RX/counter/bit_cnt
add wave -noupdate -group {edge counter} /UART_RX_TB/UART_RX/counter/edge_cnt
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/edge_cnt
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/data_sample_en
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/rx_in
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/prescale
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/sampled_data
add wave -noupdate -group {data sampler} /UART_RX_TB/UART_RX/data_sampler/sampled_bits
add wave -noupdate -group deserializer /UART_RX_TB/UART_RX/deserializer/deserializer_en
add wave -noupdate -group deserializer /UART_RX_TB/UART_RX/deserializer/sampled_data
add wave -noupdate -group deserializer /UART_RX_TB/UART_RX/deserializer/bit_cnt
add wave -noupdate -group deserializer /UART_RX_TB/UART_RX/deserializer/p_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26784 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 138
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {7915 ns}
