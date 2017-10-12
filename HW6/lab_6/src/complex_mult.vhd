--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_mult is
    generic(
    	w: integer := 8;
	n: integer;
	s: integer := 2 
    )
    port(
         
         a_real : in signed ( w downto 0 );
         a_imag : in signed ( w downto 0 );

         b_real : in signed ( n downto 0 );
         b_imag : in signed ( n downto 0 ) := (others=>'0');
         
         res_real : out signed ( n+w+s downto 0 );
         res_imag : out signed ( n+w+s downto 0 )
         
        );
end complex_mult ;

architecture complex_mult_arch of complex_mult is

	constant out_width: integer  := n+w+s;

begin

	res_real <= std_logic_vector(resize(signed(a_real)*signed(b_real),out_width) - resize(signed(a_imag)*signed(b_imag),out_width));
	
	res_imag <= std_logic_vector(resize(signed(a_imag)*signed(b_real),out_width) + resize(signed(b_imag)*signed(a_real),out_width));



end complex_mult_arch;
