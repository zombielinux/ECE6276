--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_mult is
    generic(
	iw: integer;
    )
    port(
       
         a_real : in signed ( iw downto 0 );
         a_imag : in signed ( iw downto 0 );
         
         res_real : out signed ( iw-8 downto 0 );
         res_imag : out signed ( iw-8 downto 0 )
         
        );
end complex_mult ;

architecture complex_mult_arch of complex_mult is

begin

	res_real <= a_real(iw downto iw-8);
	res_imag <= a_imag(iw downto iw-8);


end complex_mult_arch;
