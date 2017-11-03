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
		clk : in std_logic;		
		over_stat : out std_logic_vector (1 downto 0);
		overunder_out : out signed ( n downto 0 )
        );
end overunder ;

architecture overunder_arch of overunder is

--alias topfive is rounded_in(n downto n-4);
signal topfive : std_logic_vector (4 downto 0);

begin

--	msbs <= rounded_in(n:n-4);
	topfive <= std_logic_vector(rounded_in(n downto n-4));
	process (clk) begin
		if (topfive = "11111") or (topfive = "00000") then 
			overunder_out <= rounded_in;
			over_stat <= "11";
		else
			over_stat(1) <= '0';
			over_stat(0) <= topfive(4);
		end if;
--	report "overunder complete";
	end process;

end overunder_arch;
