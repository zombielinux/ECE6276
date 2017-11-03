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
		n: integer := 13
	);
    port(
		overunder_in : in signed ( n downto 0 );
		clk : in std_logic;
		overunder_stat : in std_logic_vector (1 downto 0);
		saturation_out : out signed ( 8 downto 0 )
        );
end saturation ;

architecture saturation_arch of saturation is

signal temp : std_logic_vector ( n downto 0);
begin
	process (clk) begin
	
		if (overunder_stat = "01") then
			saturation_out <= "100000000";
		elsif (overunder_Stat = "00") then
			saturation_out <= "011111111";
		else
			saturation_out <= overunder_in(8 downto 0);
			--saturation_out <= "010101010";
		end if;
	end process;

end saturation_arch;
