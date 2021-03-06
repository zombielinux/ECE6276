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
    );
    port(
         
         w_real : in signed ( w downto 0 );
         w_imag : in signed ( w downto 0 );

         b_real : in signed ( n downto 0 );
         b_imag : in signed ( n downto 0 ) := (others=>'0');
         
         res_real : out signed ( n+w+s downto 0 );
         res_imag : out signed ( n+w+s downto 0 )
         
        );
end complex_mult ;

architecture complex_mult_arch of complex_mult is

	constant out_width: integer  := n+w+s;

begin

	res_real <= resize(w_real*b_real,out_width+1) - resize(w_imag*b_imag,out_width+1);
	res_imag <= resize(w_imag*b_real,out_width+1) + resize(w_real*b_imag,out_width+1);




end complex_mult_arch;
