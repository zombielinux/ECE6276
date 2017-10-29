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
    generic(
	n: integer :=8
	);
    port(
          a_in,b_in,c_in : in std_logic_vector   ( n-1  downto 0);
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          mac_unit_out   : out std_logic_vector  ( 2*n downto 0)
        );
end mac ;

architecture mac_arch of mac is
begin
	with ctrl_in select
		mac_unit_out <= std_logic_vector("00000000000000000" + signed(a_in)+signed(c_in)) when "00",
		std_logic_vector("00000000000000000" + (signed(a_in) * signed(b_in))) when "01",
		std_logic_vector("00000000000000000" + (signed(a_in) * signed(b_in)) + signed(c_in)) when "10",
--		"00000000000000001" when "01",
--		"00000000000000010" when "10", 
		"00000000000000000" when others;


end mac_arch;
