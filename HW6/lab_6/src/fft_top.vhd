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

signal enable_buffer : std_logic;

signal w_real : w_data_array;
signal w_imag : w_data_array;

signal data_input_buffered : input_data_array;
signal st1_output_real : stage1_data_array;
signal st1_output_imag : stage1_data_array;
signal st2_output_real : stage2_data_array;
signal st2_output_imag : stage2_data_array;
signal output_data_array_real : output_data_array;
signal output_data_array_imag : output_data_array;

	component butterfly_st1
		port(
			input : in input_data_array;
			w_0_real,w_0_imag : in signed ( 8 downto 0 );
			output_r, output_i : out stage1_data_array
		);
	end component;

	component butterfly_st2
		port(
			input_r,input_i : in stage1_data_array;
			w_0_real,w_0_imag,w_2_real,w_2_imag : in signed ( 8 downto 0 );
			output_r, output_i : out stage2_data_array
		);
	end component;

	component butterfly_st3
		port(
			input_r,input_i : in stage2_data_array;
			w_0_real,w_0_imag,w_1_real,w_1_imag,w_2_real,w_2_imag,w_3_real,w_3_imag: in signed ( 8 downto 0 );
			output_r, output_i : out output_data_array
		);
	end component;

begin

    w_real <= (0=>"011111111", 1=>"010110100", 2=>"000000000", 3=>"101001100");
    w_imag <= (0=>"000000000", 1=>"101001100", 2=>"100000001", 3=>"101001100");

--Buffer data in
    -- pull in data and en_in each clock (extract out en_in if pipelining)
    process (clk, rst_n, en_in) begin
        if ( rst_n = '0' ) then
            enable_buffer <= '0';
        elsif ( rising_edge(clk) and en_in='1' ) then -- check this for when to clock in later
            data_input_buffered <= data_input;
            enable_buffer <= en_in;
        end if;
    end process;
    
    -- push out data to output
    process ( clk ) begin
        if (rising_edge(clk)) then
            data_output_real <= output_data_array_real;
            data_output_imag <= output_data_array_imag;
            data_valid_out <= enable_buffer;
        end if;
    end process;

Stage1 : butterfly_st1 port map(
	data_input_buffered,w_real(0),w_imag(0),st1_output_real,st1_output_imag
	);

Stage2 : butterfly_st2 port map(
	st1_output_real,st1_output_imag,w_real(0),w_imag(0),w_real(2),w_imag(2),st2_output_real,st2_output_imag
	);

Stage3 : butterfly_st3 port map(
	st2_output_real,st2_output_imag,
	w_real(0),w_imag(0),w_real(1),w_imag(1),
	w_real(2),w_imag(2),w_real(3),w_imag(3),
	output_data_array_real,output_data_array_imag
	);
end fft_top_arch;
