--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fft_pkg.all;

entity butterfly_st1 is

    port(
	 input : in input_data_array;

	 w_0_real,w_0_imag : in signed ( 8 downto 0);

	output_r,output_i : out stage1_data_array

        );
end butterfly_st1 ;

architecture butterfly_st1_arch of butterfly_st1 is
	component mult_add_block 
		generic(
			n : integer;
			s : integer
		);
		port (
  		      a_real,a_imag,b_real,b_imag : in signed ( n downto 0 );
		      w_real,w_imag : in signed ( 8 downto 0 );
		      x_real,x_imag,y_real,y_imag : out signed ( n+2 downto 0 )
		);
	end component;


begin

mult_add_block_04 : mult_add_block
	generic map(
		n => 7,
		s => 1
	)
	port map(
	 input(0),(others => '0'),input(4),(others => '0'),
	 w_0_real,w_0_imag,
	 output_r(0),output_i(0),output_r(1),output_i(1)
	);

mult_add_block_26 : mult_add_block
	generic map(
		n => 7,
		s => 1
	)
	port map(
	 input(2),(others => '0'),input(6),(others => '0'),
	 w_0_real,w_0_imag,
	 output_r(2),output_i(2),output_r(3),output_i(3)
	);

mult_add_block_15 : mult_add_block
	generic map(
		n => 7,
		s => 1
	)
	port map(
	 input(1),(others => '0'),input(5),(others => '0'),
	 w_0_real,w_0_imag,
         output_r(4),output_i(4),output_r(5),output_i(5)
	);

mult_add_block_37 : mult_add_block
	generic map(
		n => 7,
		s => 1
	)
	port map(
	 input(3),(others => '0'),input(7),(others => '0'),
	 w_0_real,w_0_imag,
	 output_r(6),output_i(6),output_r(7),output_i(7)
	);

end butterfly_st1_arch;
