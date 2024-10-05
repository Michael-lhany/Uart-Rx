# UART_Rx project
## Description
* There are many serial communication protocol as I2C, UART and SPI.
* A Universal Asynchronous Receiver/Transmitter (UART) is a block of circuitry responsible for implementing serial communication.
* UART is Full Duplex protocol (data transmission in both directions
simultaneously)
* Transmitting UART converts parallel data from the master device (eg. CPU) into serial form and transmit in serial to receiving UART.
* Receiving UART will then convert the serial data back into parallel data for the receiving device.
* On this project we will focusing on the receiving UART
## Specifications:
* UART RX receive a UART frame on RX_IN.
* UART_RX support oversampling by 8, 16, 32
* RX_IN is high in the IDLE case (No transmission).
* PAR_ERR signal is high when the calculated parity bit not equal
the received frame parity bit as this mean that the frame is
corrupted.
* STP_ERR signal is high when the received stop bit not equal 1 as
this mean that the frame is corrupted.
* DATA is extracted from the received frame and then sent
through P_DATA bus associated with DATA_VLD signal only after
checking that the frame is received correctly and not corrupted.
(PAR_ERR = 0 && STP_ERR = 0).
* UART_RX can accept consequent frames without any gap.
* Registers are cleared using asynchronous active low reset
* PAR_EN (Configuration)
0: To disable frame parity bit
1: To enable frame parity bit
* PAR_TYP (Configuration)
0: Even parity bit
1: Odd parity bit
## Block diagram
(Rx block diagram .png)
##
* I have added a run.do and a wave.do so it can be easier for you to try the project out on questasim
