--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_addsub is
    generic(
    	i: integer := 16;
	n: integer := 8;
	op: std_logic
    );
    port(
       
         a_real : in signed ( n downto 0 );
         a_imag : in signed ( n downto 0 );

         b_real : in signed ( i downto 0 );
         b_imag : in signed ( i downto 0 );
         
         res_real : out signed ( i+1 downto 0 );
         res_imag : out signed ( i+1 downto 0 )
         
        );
end complex_addsub ;

architecture complex_addsub_arch of complex_addsub is

begin

--	process begin

--in the case of adding	
		with op select
			res_real <= resize(a_real,i+2)-resize(b_real,i+2) when '0',
				    resize(a_real,i+2)+resize(b_real,i+2) when others;
		
		with op select
			res_imag <=  resize(a_imag,i+2)-resize(b_imag,i+2) when '0',
				     resize(a_imag,i+2)+resize(b_imag,i+2) when others;
--		end if;
--	end process;


end complex_addsub_arch;
