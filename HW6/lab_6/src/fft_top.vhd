--Engineer     : Abhijit Gadad
--Date         : 8/3/2017
--Name of file : fft_top.vhd
--Description  : the top level fft design

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.fft_pkg.all;

entity fft_top is

 port(
       clk             : in std_logic;
       rst_n           : in std_logic;
       en_in           : in std_logic;
       data_input      : in input_data_array;

       data_valid_out  : out std_logic;
       data_output_real: out output_data_array;
       data_output_imag: out output_data_array
     );
end fft_top;

architecture fft_top_arch of fft_top is



	component butterfly_st1
		port(
			input : in input_data_array;
			w_0_real,w_0_imag : in signed ( 8 downto 0 );
			output_r, output_i : out stage1_data_array;
		);
	end component;

	component butterfly_st1
		port(
			input_r,input_i : in stage1_data_array;
			w_0_real,w_0_imag : in signed ( 8 downto 0 );
			output_r, output_i : out stage2_data_array;
		);
	end component;

	component butterfly_st1
		port(
			input_r,input_i : in stage2_data_array;
			w_0_real,w_0_imag : in signed ( 8 downto 0 );
			output_r, output_i : out output_data_array;
		);
	end component;

begin

--Buffer data in



end fft_top_arch;
