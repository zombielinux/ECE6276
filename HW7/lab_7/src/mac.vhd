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
          a_in,b_in,c_in : in signed   ( n-1  downto 0);
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          mac_unit_out   : out signed  ( 16 downto 0)
        );
end mac ;

architecture mac_arch of mac is

	constant mac_out_length : integer := mac_unit_out'length;
	signal mul_a,mul_b,sum_c : signed (n-1 downto 0);

begin

	with (ctrl_in(0) and ctrl_in(1)) select
		mul_a <= (others => '0') when '1',
		a_in when others;

	with (ctrl_in(0) xor ctrl_in(1)) select
		mul_b <= (0 => '1', others => '0') when '0',
		b_in when others;

	with ctrl_in(0) select
		sum_c <= c_in when '0',
		(others => '0') when others;

	mac_unit_out <= resize(mul_a*mul_b+sum_c,mac_out_length);

end mac_arch;
