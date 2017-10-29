--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : mac.vhd
--Description  : implements a programmable mac unit
--              

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity round is
--port list
    generic(
		n: integer :=16;
		o: integer :=13
	);
    port(
		result_in : in signed ( n downto 0 );

		rouded_out : out signed ( o downto 0 )
        );
end round ;

architecture round_arch of round is

signal preshifted : signed ( 31 downto 0 );

begin
	preshifted <= "11111" + result_in;
	rounded_out <= preshifted(n+1:n+1-o);


end round_arch;
