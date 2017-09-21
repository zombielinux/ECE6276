--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : mac.vhd
--Description  : implements a programmable mac unit
--              

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac is
--port list
    port(
          a_in,b_in,c_in : in std_logic_vector   ( 7  downto 0);
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          mac_unit_out   : out std_logic_vector  ( 16 downto 0)
        );
end mac ;

architecture mac_arch of mac is

	variable mul_a : std_logic_vector ( 7 downto 0);
	variable mul_b : std_logic_vector ( 7 downto 0);
	variable sum_c : std_logic_vector ( 7 downto 0);

begin


	with ctrl_in select
		mul_a <= "00000000" when "11",
		a_in when others;
		
	with ctrl_in select
		mul_b <= "00000001" when "00",
		b_in when others;
	

	with ctrl_in(0) select	
		sum_c <= c_in when '0';
		"00000000" when others;
		
		
	mac_unit_out <= std_logic_vector("00000000000000000" + signed(mul_a)*signed(mul_b)+signed(sum_c));



end mac_arch;
