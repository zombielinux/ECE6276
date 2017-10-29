library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fft_pkg is

type enable_array is array (0 to 2) of std_logic;
type input_data_array is array (0 to 7) of signed(7 downto 0);
type w_data_array is array (0 to 3) of signed (8 downto 0);
type stage1_data_array is array (0 to 7) of signed(9 downto 0);
type stage2_data_array is array (0 to 7) of signed(12 downto 0);
type output_data_array is array (0 to 7) of signed(15 downto 0);
type output_data_array_file is array (0 to 7) of std_logic_vector(15 downto 0);
end fft_pkg;

