vlib work
vlog *.*v
vsim -gui -voptargs=+acc work.UART_RX_TB
do wave.do
run -all