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
    )
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
	 y_imag : out signed ( n+2 downto 0 );

         
        );
end butterfly_st1 ;

architecture butterfly_st1_arch of butterfly_st1 is

	signal mult_real : signed ( 16 downto 0 );
	signal mult_imag : signed ( 16 downto 0 );

	signal add_preshift_real : signed ( 17 downto 0 );
	signal add_preshift_imag : signed ( 17 downto 0 );

	signal sub_preshift_real : signed ( 17 downto 0 );
	signal sub_preshift_imag : signed ( 17 downto 0 );


Mult_stage : entity work.complex_mult 
		generic map (
			w => 8;
			n => 7;
			s => 1
		)
		port map (
			w_real,
			w_imag,
			b_real,
			mult_real,
			mult_imag);

Add_stage : entity work.complex_addsub 
		generic map (
			n => 16;
			i => 7;
			op => 0
		)		
		port map (
			a_real,
			a_imag,
			mult_real,
			mult_imag,
			add_preshift_real,
			add_preshift,imag);

Sub_stage : entity work.complex_addsub 
		generic map (
			n => 16;
			i => 7;
			op => 1
		)		
		port map (
--If the result is not what is expected, exchanging mult_$var with a_$var
			mult_real,
			mult_imag,
			a_real,
			a_imag,
			sub_preshift_real,
			sub_preshift,imag);

Add_shift_stage : entity work.eight_right_shift 
		generic map (
			iw => 17
		)		
		port map (
			add_preshift_real,
			add_preshift_imag,
			x_real,
			x_imag);

Sub_shift_stage : entity work.eight_right_shift 
		generic map (
			iw => 17
		)		
		port map (
			sub_preshift_real,
			sub_preshift_imag,
			y_real,
			y_imag);

begin





end butterfly_st1_arch;
