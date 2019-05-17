library ieee;
library briscola_package;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use briscola_package.briscola_package.all;

-------------------------------------------
-- Funzioni utilizzate in fase 2
-------------------------------------------

package body BriscolaFase2_package is 

	-- se ho carte non briscola che prendono
	function getCartanoBriscolaPresa(mano: mano_cpu, carta: cartaTerra) return integer is
	
	begin 
		for i in 0 to 2 loop
			if (mano(i).briscola = true) then 
				next;
			end if;
			
			if (carta(i).seme /= mano(i).seme) then 
			next;
			end if;
			
			if( mano(i).valore > carta(i).valore) then
				return i;
			else if 
				return getCartaLiscia(mano);
			end if;
		end loop;
	end function;