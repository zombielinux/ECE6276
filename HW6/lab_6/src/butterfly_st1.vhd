--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity butterfly_st1 is
    generic(
    	n: integer := 7
    );
    port(

         a_real : in signed ( n downto 0 );
         a_imag : in signed ( n downto 0 );

         b_real : in signed ( n downto 0 );
         b_imag : in signed ( n downto 0 );
         
   	 w_real : in signed ( 8 downto 0 );
	 w_imag : in signed ( 8 downto 0 );

	 x_real : out signed ( n+2 downto 0 );
	 x_imag : out signed ( n+2 downto 0 );

	 y_real : out signed ( n+2 downto 0 );
	 y_imag : out signed ( n+2 downto 0 )

         
        );
end butterfly_st1 ;

architecture butterfly_st1_arch of butterfly_st1 is
--multiplier component
	component complex_mult
		generic (w,n,s : integer);
		port (
			w_real, w_imag : in signed ( 8 downto 0 );
			b_real,	b_imag : in signed ( n downto 0 );
			mult_real, mult_imag : out signed (16 downto 0)
		);
	end component;
	--internal signals to this stage
	signal mult_real : signed ( 16 downto 0 );
	signal mult_imag : signed ( 16 downto 0 );

	signal add_preshift_real : signed ( 17 downto 0 );
	signal add_preshift_imag : signed ( 17 downto 0 );

	signal sub_preshift_real : signed ( 17 downto 0 );
	signal sub_preshift_imag : signed ( 17 downto 0 );

begin

Mult_stage : complex_mult 
		generic map (
			w => 8,
			n => 7,
			s => 1
		)
		port map (
			w_real,
			w_imag,
			b_real,
			b_imag,
			mult_real,
			mult_imag);

x_real <= (others => '0');
x_imag <= (others => '0');
y_real <= (others => '0');
y_imag <= (others => '0');


end butterfly_st1_arch;
