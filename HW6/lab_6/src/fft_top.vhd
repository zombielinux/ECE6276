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

begin


end fft_top_arch;
