--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_mult is
    port(
         
         a_real : in std_logic_vector ( 7 downto 0 );
         a_imag : in std_logic_vector ( 7 downto 0 );
         b_real : in std_logic_vector ( 7 downto 0 );
         b_imag : in std_logic_vector ( 7 downto 0 );
         
         res_real : out std_logic_vector ( 17 downto 0 );
         res_imag : out std_logic_vector ( 17 downto 0 )
         
        );
end complex_mult ;

architecture complex_mult_arch of complex_mult is

begin

	res_real <= std_logic_vector(signed(a_real)*signed(b_real) - signed(a_imag)*signed(b_imag));
	res_imag <= std_logic_vector(signed(a_imag)*signed(b_real) + signed(b_imag)*signed(a_real));


end complex_mult_arch;
