--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complex_addsub is
    generic(
    	n: integer := 16;
	i: integer := 8;
	op: std_logic
    );
    port(
       
         a_real : in signed ( i-1 downto 0 );
         a_imag : in signed ( i-1 downto 0 );

         b_real : in signed ( n downto 0 );
         b_imag : in signed ( n downto 0 );
         
         res_real : out signed ( n+1 downto 0 );
         res_imag : out signed ( n+1 downto 0 )
         
        );
end complex_addsub ;

architecture complex_addsub_arch of complex_addsub is

begin

--	process begin

--in the case of adding	
		with op select
			res_real <= resize(a_real,n+1)+resize(b_real,n+1) when '1',
				    resize(a_real,n+1)-resize(b_real,n+1) when others;
		
		with op select
			res_imag <= resize(a_imag,n+1)+resize(b_imag,n+1) when '1',
				    resize(a_imag,n+1)-resize(b_imag,n+1) when others;
--		end if;
--	end process;


end complex_addsub_arch;
