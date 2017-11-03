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

		rounded_out : out signed ( o downto 0 )
        );
end round ;

architecture round_arch of round is
constant thirtyone : positive := 31;
signal preshifted : signed( 17 downto 0 );

begin
	preshifted <= to_signed(thirtyone,n+2) + result_in;
	rounded_out <= preshifted(17 downto 4);

end round_arch;
