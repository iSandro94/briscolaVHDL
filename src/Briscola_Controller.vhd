library ieee;
library briscola_package;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use briscola_package.briscola_package.all;

entity Briscola_Controller is
	port (
		CLOCK_50		: in std_logic;
		
		SW				: in std_logic_vector(0 to 7);
		KEY			: in std_logic_vector(0 to 3);
		
		LEDR			: out std_logic_vector(0 to 9);
		LEDG			: out std_logic_vector(0 to 7);
		
		UART_TX 		: out std_logic;
		UART_RX		: in std_logic
	);
end entity;


architecture RTL of Briscola_Controller is
	-- SEGNALI
	signal tx_data 	: std_logic_vector(0 to 7);
	signal tx_start	: std_logic := '0';
	signal tx_busy		: std_logic;
	signal tx_stop		: std_logic;
	
	signal rx_data 	: std_logic_vector(0 to 7);
	signal rx_start	: std_logic;
	
	-- COMPONENTI
	component TX_UART
		port (
			i_Clk       : in  std_logic;
			i_TX_DV     : in  std_logic;
			i_TX_Byte   : in  std_logic_vector(0 to 7);
    
			o_TX_Active : out std_logic;
			o_TX_Serial : out std_logic;
			o_TX_Done   : out std_logic
		);
	end component;
	
--	component RX_UART
--		port (
--			i_Clk       : in  std_logic;
--			i_RX_Serial : in  std_logic;
--			o_RX_DV     : out std_logic;
--			o_RX_Byte   : out std_logic_vector(0 to 7)
--		);
--	end component;
--	
	begin
		transmitter : TX_UART port map (CLOCK_50, tx_start, tx_data, tx_busy, UART_TX, tx_stop);
		--receiver		: RX_UART port map (CLOCK_50, rx_start, UART_RX, rx_data);

		process(CLOCK_50) is
		begin 
			if(rising_edge(CLOCK_50)) then
				if(KEY(0) = '0' AND tx_busy = '0') then 
					tx_data <= SW;
					tx_start <= '1';
					LEDG <= tx_data;
				else 
					tx_start <= '0';
				end if;
			end if;
		end process;

end architecture;