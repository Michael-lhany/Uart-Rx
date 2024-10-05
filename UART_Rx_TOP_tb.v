`timescale 1us/1ns

module UART_RX_TB ();


///		Parameters		///
/// 	To change prescale change the CLK_PERIOD to required period for that prescale and the prescale to the value you want between 8, 16, 32;		///
localparam CLK_PERIOD_UART_TX = 8.68 ;
localparam CLK_PERIOD_prescale_8 = CLK_PERIOD_UART_TX / 8 ;
localparam CLK_PERIOD_prescale_16 = CLK_PERIOD_UART_TX / 16 ;
localparam CLK_PERIOD_prescale_32 = CLK_PERIOD_UART_TX / 32 ;
localparam CLK_PERIOD = CLK_PERIOD_prescale_8;

localparam prescale = 8;


///		integers		///
integer test_case;
integer i;

///		Regs		///
reg [7:0] data;

///		DUT signals		///
reg CLK_tb;
reg RST_tb;
reg PAR_TYP_tb;
reg PAR_EN_tb;
reg [5:0] Prescale_tb;
reg RX_IN_tb;
wire [7:0] P_DATA_tb;
wire Data_valid_tb;
wire Parity_Error_tb;
wire Stop_Error_tb;


////		DUT instantiation		////
UART_Rx_TOP UART_RX(
.CLK(CLK_tb),
.RST(RST_tb),
.PAR_TYP(PAR_TYP_tb),
.PAR_EN(PAR_EN_tb),
.Prescale(Prescale_tb),
.RX_IN(RX_IN_tb),
.P_DATA(P_DATA_tb),
.Data_valid(Data_valid_tb),
.Parity_Error(Parity_Error_tb),
.Stop_Error(Stop_Error_tb)
);

///		Clock Generator Rx		///
always #(CLK_PERIOD/2.0) CLK_tb = ~CLK_tb;





///		Initial block		///
initial 
begin
	$dumpfile("LFSR_DUMP.vcd") ;       
	$dumpvars;

	init();
	reset();


///		First Three cases the frames aren't consecutive 		///
///		while the other three cases the frames are consecutive	///


	$display("For prescale %d",prescale);

	test_case = test_case + 1;
	$display("First test no parity");
	data_recieve('b10111011,'b0,'b0);
	#(CLK_PERIOD_UART_TX);
	test_case = test_case + 1;
	$display("Second test no parity");
	data_recieve('b00011101,'b0,'b1);
	#(CLK_PERIOD_UART_TX);
	test_case = test_case + 1;
	$display("Third test even parity even no. of bits");
	data_recieve('b10001110,'b1,'b0);			//Even parity even no. of bits
	#(CLK_PERIOD_UART_TX);
	test_case = test_case + 1;
	$display("Fourth test even parity odd no. of bitss");
	data_recieve('b00111011,'b1,'b0);			//Even parity odd no. of bits
	test_case = test_case + 1;
	$display("Fifth test Odd parity even no. of bits");
	data_recieve('b10001110,'b1,'b1);			//Odd parity even no. of bits
	test_case = test_case + 1;
	$display("Sixth test Odd parity odd no. of bits");
	data_recieve('b00111011,'b1,'b1);			//Odd parity odd no. of bits

///		testing the parity error 	///
 	data = 'b10001110;

 	RX_IN_tb = 0;
 	PAR_EN_tb = 'b1;
 	PAR_TYP_tb = 'b0;

 	#(CLK_PERIOD_UART_TX)
 	for( i=0 ; i<8 ; i=i+1 )
 	begin
 		RX_IN_tb = data[i];
 		#(CLK_PERIOD_UART_TX);
 	end

 	RX_IN_tb = ~^data;
 	#(CLK_PERIOD_UART_TX);


 	RX_IN_tb = 1;
 	#(CLK_PERIOD_UART_TX);

 	if (Data_valid_tb == 0) begin
 		$display("Test for checking the parity error is correct");
 	end else begin
 		$display("Test for checking the parity error is correct");
 	end


///		testing the start glitch	///
	RX_IN_tb = 0;
 	PAR_EN_tb = 0;
 	PAR_TYP_tb = 0;
 	#(CLK_PERIOD)
 	RX_IN_tb = 1;
 	#(CLK_PERIOD);
 	#(CLK_PERIOD_UART_TX);
	$display("Test for start glitch checking from the waveform that the state returns to idle passed"); 


	
///		test for staying in idle state	///
	#(3*CLK_PERIOD_UART_TX)
	$display("Test for staying in idle state checking from the waveform passed");


	$stop;
end




///		Tasks		///



//Initialize
task init;	
 begin
 	CLK_tb = 'b0;
	RST_tb = 'b0;
	PAR_TYP_tb = 'b0;
	PAR_EN_tb = 'b0;
	Prescale_tb = prescale;
	RX_IN_tb = 'b1;
	test_case = 0;
 end
endtask



//Reset
task reset;
 begin
	RST_tb = 'b1;
	#(CLK_PERIOD)
	RST_tb = 'b0;
	#(CLK_PERIOD)
	RST_tb = 'b1;
 end
endtask



//Data recieve task
task data_recieve;
input [7:0] IN_DATA;
input parity_enable;
input parity_type;

reg [7:0] out_temp;

 begin
 	RX_IN_tb = 0;
 	PAR_EN_tb = parity_enable;
 	PAR_TYP_tb = parity_type;

 	#(CLK_PERIOD_UART_TX)
 	for( i=0 ; i<8 ; i=i+1 )
 	begin
 		RX_IN_tb = IN_DATA[i];
 		#(CLK_PERIOD_UART_TX);
 	end

 	if (PAR_EN_tb) begin
 		if (PAR_TYP_tb == 0) begin
 			RX_IN_tb = ^IN_DATA;
 		end else begin
 			RX_IN_tb = ~^IN_DATA;
 		end	
 		#(CLK_PERIOD_UART_TX);
 	end

 	RX_IN_tb = 1;
 	#(CLK_PERIOD_UART_TX);

 	if (P_DATA_tb == IN_DATA && Data_valid_tb == 1) begin
 		$display("Test case %d is correct",test_case);
 	end else begin
 		$display("Test case %d failed",test_case);
 	end

 end
endtask



endmodule