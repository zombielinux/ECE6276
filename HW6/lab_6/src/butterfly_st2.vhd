--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fft_pkg.all;

entity butterfly_st2 is

    port(

         clk   : in std_logic;
         rst_n : in std_logic;
	 en_in : in std_logic;

	 input_r,input_i : in stage1_data_array;

         
	 w_0_real,w_0_imag,w_2_real,w_2_imag : in signed ( 8 downto 0);

	output_r : out stage2_data_array;
	output_i : out stage2_data_array

        );
end butterfly_st2 ;

architecture butterfly_st2_arch of butterfly_st2 is
	component mult_add_block 
		generic(
			n : integer
		);
		port (
  		      a_real,a_imag,b_real,b_imag : in signed ( n downto 0 );
		      w_real,w_imag : in signed ( 8 downto 0 );
		      x_real,x_imag,y_real,y_imag : out signed ( n+2 downto 0 )
		);
	end component;


begin

mult_add_block_02 : mult_add_block
	generic map(
		n => 9
	)
	port map(
	 input_r(0),input_i(0),input_r(2),input_i(2),
	 w_0_real,w_0_imag,
	 output_r(0),output_i(0),output_r(2),output_i(2)
	);

mult_add_block_13 : mult_add_block
	generic map(
		n => 9
	)
	port map(
	 input_r(1),input_i(1),input_r(3),input_i(3),
	 w_2_real,w_2_imag,
	 output_r(1),output_i(1),output_r(3),output_i(3)
	);

mult_add_block_46 : mult_add_block
	generic map(
		n => 9
	)
	port map(
	 input_r(4),input_i(4),input_r(6),input_i(6),
	 w_0_real,w_0_imag,
	 output_r(4),output_i(4),output_r(6),output_i(6)
	);

mult_add_block_57 : mult_add_block
	generic map(
		n => 9
	)
	port map(
	 input_r(5),input_i(5),input_r(7),input_i(7),
	 w_2_real,w_2_imag,
	 output_r(5),output_i(5),output_r(7),output_i(7)
	);




end butterfly_st2_arch;