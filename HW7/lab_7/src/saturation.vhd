--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : mac.vhd
--Description  : implements a programmable mac unit
--              

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity saturation is
--port list
    generic(
		n: integer :=13
	);
    port(
		overunder_in : in signed ( n downto 0 );
		overunder_stat: in std_logic_vector( 1 downto 0 );
		saturation_out : out signed ( n-5 downto 0 )
        );
end saturation ;

architecture overunder_arch of overunder is

begin

	if (overunder_stat = "00") then
		saturation_out <= overunder_in( n-5 downto 0 );
	else
		if (overunder_stat(0) = '1') then 
			--Underflow
			saturation_out <= "100000000";
		else
			saturation_out <= "011111111";
		end if
	end if

end overunder_arch;
