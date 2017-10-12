--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_mult is
    port(
       
         a_real : in std_logic_vector ( 17 downto 0 );
         a_imag : in std_logic_vector ( 17 downto 0 );
         
         res_real : out std_logic_vector ( 9 downto 0 );
         res_imag : out std_logic_vector ( 9 downto 0 )
         
        );
end complex_mult ;

architecture complex_mult_arch of complex_mult is

begin

	res_real <= a_real(17 downto 8);
	res_imag <= a_imag(17 downto 8);


end complex_mult_arch;
