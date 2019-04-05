library ieee;
library briscola_package;
library briscola_lisci_package;
library briscola_situazioniNoLisci_package;
library briscola_utility_package;

use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use briscola_package.briscola_package.all;
use briscola_lisci_package.briscola_lisci_package.all;
use briscola_situazioniNoLisci_package.briscola_situazioniNoLisci_package.all;
use briscola_utility_package.briscola_utility_package.all;

entity Briscola is 
	port ( 
			SW 		: IN std_logic_vector(0 to 9);
			CLOCK_50 : IN std_logic;
			
			HEX0 		: OUT std_logic_vector(0 to 6);
			HEX1 		: OUT std_logic_vector(0 to 6);
			HEX2 		: OUT std_logic_vector(0 to 6);
			HEX3 		: OUT std_logic_vector(0 to 6);
			
			LEDR 		: OUT std_logic_vector(0 to 9);
			LEDG		: OUT std_logic_vector(0 to 7));
end entity;

--architecture Behaviour of Briscola is
--begin 
--	process (CLOCK_50)
--		constant HEX_OFF						: std_logic_vector := "1111110";
--		
--		constant LEDR_ON						: std_logic_vector := "1111111111";
--		constant LEDG_ON						: std_logic_vector := "11111111";
--		constant LEDR_OFF						: std_logic_vector := "0000000000";
--		constant LEDG_OFF						: std_logic_vector := "00000000";
--	
--		variable carta1, carta2, carta3 	: carta;
--		variable mano 							: mano_cpu;
--		
--		variable num_briscole				: integer;
--		variable num_carichi					: integer;
--		variable indice						: integer;
--	begin
--		-- inizializza il display e i led a OFF
--		HEX0 <= HEX_OFF;
--		HEX1 <= HEX_OFF;
--		HEX2 <= HEX_OFF;
--		HEX3 <= HEX_OFF;
--		
--		LEDG <= LEDG_OFF;
--		LEDR <= LEDR_OFF;
--		
--		-- crea la mano della cpu
--		HEX0 <= digitTo7SegmentDisplay('-');
--		HEX1 <= digitTo7SegmentDisplay('U');		
--		HEX2 <= digitTo7SegmentDisplay('P');
--		HEX3 <= digitTo7SegmentDisplay('C');
--		
--		carta1 	:= (3, DENARI, 10, false);
--		carta2 	:= (2, COPPE, 0, false);
--		carta3 	:=	(1, SPADE, 11, true);
--		mano 		:= (carta1, carta2, carta3);
--		
--		-- determina la situazione in cui ci si trova
--		if(isLiscio(mano)) then 
--			LEDR(0) <= '1';
--			
--			HEX3 <= HEX_OFF;
--			HEX2 <= HEX_OFF;
--			HEX1 <= HEX_OFF;
--
--			indice := getCartaLiscia(mano);
--			HEX0 <= numberTo7SegmentDisplay(indice);
--		else
--			LEDG(0) <= '1';
--	
--			HEX3 <= HEX_OFF;
--			HEX2 <= HEX_OFF;
--			HEX1 <= HEX_OFF;
--			
--			num_briscole := getNumeroBriscole(mano);
--			num_carichi := getNumeroCarichi(mano);
--			indice := determinaSituazioneNoLisci(num_carichi, num_briscole, mano);
--			HEX0 <= numberTo7SegmentDisplay(indice);
--		end if;
--	
--	end process;
--end architecture;