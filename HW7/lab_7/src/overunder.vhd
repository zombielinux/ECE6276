--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : mac.vhd
--Description  : implements a programmable mac unit
--              

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity overunder is
--port list
    generic(
		n: integer :=13
	);
    port(
		rounded_in : in signed ( n downto 0 );
		overunder_stat: out std_logic_vector( 1 downto 0 );
		overunder_out : out signed ( n downto 0 )
        );
end overunder ;

architecture overunder_arch of overunder is

begin

	overunder_out <= rounded_in;
	msbs <= rounded_in(n:n-5);

	if (rounded_in(n:n-5) = "11111") or (rounded_in(n:n-5) = "00000") then
		overunder_stat <= "00";
	else
		if (rounded_in(n) = '1') then
		--Underflow
			overunder_stat <= "01";
		else
		--Overflow		
			overunder_stat <= "10";
		end if;
	end if;
	


end overunder_arch;
