--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_addsub is
    generic(
    	n: integer := 16
    )
    port(
         add_sub : in std_logic;
         
         a_real : in std_logic_vector ( n downto 0 );
         a_imag : in std_logic_vector ( n downto 0 );

         b_real : in std_logic_vector ( n downto 0 );
         b_imag : in std_logic_vector ( n downto 0 );
         
         res_real : out std_logic_vector ( n+1 downto 0 );
         res_imag : out std_logic_vector ( n+1 downto 0 )
         
        );
end complex_addsub ;

architecture complex_addsub_arch of complex_addsub is

begin

	if (add_sub = '0') then
--in the case of adding	
		res_real <= a_real+b_real;
		res_imag <= a_imag+b_imag;
	else then
		res_real <= a_real-b_real;
		res_imag <= a_imag-b_imag;



end complex_addsub_arch;
