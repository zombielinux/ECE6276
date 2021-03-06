--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_right_shift is
    generic(
	iw: integer := 8
    );
    port(
       
         a_real : in signed ( iw downto 0 );
         a_imag : in signed ( iw downto 0 );
         
         res_real : out signed ( iw-8 downto 0 );
         res_imag : out signed ( iw-8 downto 0 )
         
        );
end eight_right_shift ;

architecture eight_right_shift_arch of eight_right_shift is

begin

	res_real <= a_real(iw downto 8);
	res_imag <= a_imag(iw downto 8);


end eight_right_shift_arch;
