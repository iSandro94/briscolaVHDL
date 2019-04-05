library ieee;
library briscola_package;
library briscola_datapath_package;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use briscola_package.briscola_package.all;
use briscola_datapath_package.briscola_datapath_package.all;

entity Briscola_Datapath is
	port (
		CLOCK								: in  std_logic;
		RESET_N        				: in  std_logic;
		
		--
		NUOVO_TURNO						: in std_logic;
		IS_PENULTIMO 					: out std_logic;

		--
	--	LANCIA_CARTA_CPU				: in std_logic;
		
		CARTA_DA_AGGIUNGERE_CPU		: in carta;
		AGGIUNGI_CARTA_CPU			: in std_logic;
		
		DECIDI_CARTA_CPU				: in std_logic;
		--INDICE_CARTA_DA_GIOCARE		: out integer;
		
		--
		FINE_MANO						: in std_logic
	);
end entity;

architecture RTL of Briscola_Datapath is
	signal punti_cpu				: integer;
	signal punti_player 			: integer;
	signal turno_in_corso		: integer;
	signal mano						: mano_cpu;
	signal carta_giocata_pl		: carta;
	signal carta_giocata_cpu 	: carta;
begin 
--	-- Potremmo dover usare le operazioni di aggiunta punti direttamente nel valutaFinePresa
--	AggiungiPuntiCPU : process(CLOCK, RESET_N, AGGIUNGI_CPU) is
--	begin
--
--		if(RESET_N = '0') then
--			punti_cpu <= 0;
--		elsif(rising_edge(CLOCK)) then
--			if(AGGIUNGI_CPU = '1') then
--				punti_cpu <= punti_cpu + PUNTI_COM;
--			end if;
--		end if;
--
--	end process;
--	
--	-- 
--	AggiungiPuntiPlayer : process(CLOCK, RESET_N, AGGIUNGI_PLAYER) is
--	begin
--
--		if(RESET_N = '0') then
--			punti_player <= 0;
--		elsif(rising_edge(CLOCK)) then
--			if(AGGIUNGI_PLAYER = '1') then
--				punti_player <= punti_player + PUNTI_PL;
--			end if;
--		end if;
--
--	end process;
	
	-- 
	AggiornaTurno : process(CLOCK, RESET_N, NUOVO_TURNO) is
	begin
	
		if(RESET_N = '0') then
			turno_in_corso <= 0;
			IS_PENULTIMO <= '0';
		elsif(rising_edge(CLOCK)) then
			if(NUOVO_TURNO = '1') then
				turno_in_corso <= turno_in_corso + 1;
			end if;
			
			if(turno_in_corso = 19) then 
				IS_PENULTIMO <= '1';
			end if;
		end if;
	
	end process;

	--
	--RegistroCarteCPU : process(CLOCK, RESET_N, LANCIA_CARTA_CPU, AGGIUNGI_CARTA_CPU, DECIDI_CARTA_CPU) is
	RegistroCarteCPU : process(CLOCK, RESET_N, AGGIUNGI_CARTA_CPU, DECIDI_CARTA_CPU) is
		variable carta_reset : carta;
	begin
		
		if(RESET_N = '0') then
			carta_reset := (0, DENARI, 0, false);
			
			for i in 0 to 2 loop 
				mano(i) <= (carta_reset);
			end loop;
		elsif(rising_edge(CLOCK)) then
--			if(LANCIA_CARTA_CPU = '1') then 
--				carta_giocata_cpu <= mano(INDICE_CARTA_DA_GIOCARE);
			if(AGGIUNGI_CARTA_CPU = '1') then
				for i in 0 to 2 loop 
					if(mano(i) = carta_reset) then
						mano(i) <= CARTA_DA_AGGIUNGERE_CPU;
						exit;
					end if;
				end loop;
			elsif(DECIDI_CARTA_CPU = '1') then
				carta_giocata_cpu <= mano(decidiCarta(mano));
				--INDICE_CARTA_DA_GIOCARE <= decidiCarta(mano);
			end if;
		end if;
	
	end process;

	--
	ValutaPuntiPresa : process(CLOCK, FINE_MANO) is	
		variable carta_reset : carta := (0, DENARI, 0, false);
		variable risultato : boolean;
	begin 
		if(rising_edge(CLOCK)) then
			if(FINE_MANO = '1') then 
			-- interviene il token, devo vedere chi gioca per primo (da fare)
				risultato := valutaPresa(carta_giocata_cpu, carta_giocata_pl);
				if(risultato) then 
					punti_cpu <= punti_cpu + carta_giocata_cpu.valore + carta_giocata_pl.valore;
				else
					punti_player <= punti_player + carta_giocata_cpu.valore + carta_giocata_pl.valore;
				end if;
	
				-- resetto le due carte a terra (ex FineMano)
				carta_giocata_cpu <= carta_reset;
				carta_giocata_pl <= carta_reset;
			end if;
		end if;
	
	end process;
	
end architecture;