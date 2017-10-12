--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_mult_big is
    generic(
    	n: integer
    );
    port(
         
         a_real : in std_logic_vector ( n downto 0 );
         a_imag : in std_logic_vector ( n downto 0 );

         b_real : in std_logic_vector ( n-1 downto 0 );
         b_imag : in std_logic_vector ( n-1 downto 0 );
         
         res_real : out std_logic_vector ( 19 downto 0 );
         res_imag : out std_logic_vector ( 19 downto 0 )
         
        );
end complex_mult_big ;

architecture complex_mult_big_arch of complex_mult_big is

begin

	res_real <= std_logic_vector(resize(signed(a_real)*signed(b_real),20) - resize(signed(a_imag)*signed(b_imag),20));
	res_imag <= std_logic_vector(resize(signed(a_imag)*signed(b_real),20) + resize(signed(b_imag)*signed(a_real),20));



end complex_mult_big_arch;
