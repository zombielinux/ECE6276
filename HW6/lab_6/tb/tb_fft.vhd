--Engineer     : Abhijit Gadad
--Date         : 8/4/2017
--Name of file : tb_fft.vhd
--Description  : implements the test bench for fft

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.fft_pkg.all;

entity tb_fft is
end tb_fft;

architecture tb_fft_arch of tb_fft is
    component fft_top is
    port(
       clk             : in std_logic;
       rst_n           : in std_logic;
       en_in           : in std_logic;
       data_input      : in input_data_array;

       data_valid_out  : out std_logic;
       data_output_real: out output_data_array;
       data_output_imag: out output_data_array

        );
    end component;
     type factor_real is array (0 to 7) of signed(7 downto 0);
     type factor_imag is array (0 to 7) of signed(7 downto 0);

     signal   clk          : std_logic;
     signal   rst_n        : std_logic := '1';
     signal   data_en      : std_logic := '0';
     signal   coeff_en     : std_logic := '0';
     signal   coeff_real   : factor_real;
     signal   coeff_imag   : factor_imag;
     signal   input_data   : input_data_array;
     signal   output_data_real : output_data_array;
     signal   output_data_imag : output_data_array;
     signal   output_data_valid : std_logic;

     constant T: time := 20 ns;
     signal rand_num : integer := 0;
     signal output_test_case : integer := 0;
     file input_file_info : text;
     file output_file_info : text;
     file output_file_cycle_info : text;
     signal mac_out_file : std_logic_vector(16 downto 0) ;
     signal real_data_out_file : output_data_array_file;
     signal imag_data_out_file : output_data_array_file;
     signal cycle_count  : integer := 0;
     signal coeff_read   : integer := 0;


begin
--instantiation of design under test
    DUT : fft_top port map(
          clk            => clk,     
          rst_n          =>rst_n    ,
          en_in          =>data_en  ,

          --input data stream
          data_input     => input_data,
          --output data stream
          data_valid_out      => output_data_valid, 
          data_output_real    => output_data_real,
          data_output_imag    => output_data_imag

                           );
   real_data_out_file(0) <= std_logic_vector(output_data_real(0)); 
   imag_data_out_file(0) <= std_logic_vector(output_data_imag(0)); 
   real_data_out_file(1) <= std_logic_vector(output_data_real(1)); 
   imag_data_out_file(1) <= std_logic_vector(output_data_imag(1)); 
   real_data_out_file(2) <= std_logic_vector(output_data_real(2)); 
   imag_data_out_file(2) <= std_logic_vector(output_data_imag(2)); 
   real_data_out_file(3) <= std_logic_vector(output_data_real(3)); 
   imag_data_out_file(3) <= std_logic_vector(output_data_imag(3)); 
   real_data_out_file(4) <= std_logic_vector(output_data_real(4)); 
   imag_data_out_file(4) <= std_logic_vector(output_data_imag(4)); 
   real_data_out_file(5) <= std_logic_vector(output_data_real(5)); 
   imag_data_out_file(5) <= std_logic_vector(output_data_imag(5)); 
   real_data_out_file(6) <= std_logic_vector(output_data_real(6)); 
   imag_data_out_file(6) <= std_logic_vector(output_data_imag(6)); 
   real_data_out_file(7) <= std_logic_vector(output_data_real(7)); 
   imag_data_out_file(7) <= std_logic_vector(output_data_imag(7)); 

    process 
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        cycle_count <= cycle_count +1;
        wait for T/2;
    end process;


    process
        variable input_line : line;
        variable coeff_en_term : std_logic;
        variable en_term     : std_logic; 
        variable real_coefficient : std_logic_vector ( 7 downto 0);
        variable imag_coefficient : std_logic_vector ( 7 downto 0);
        variable data_term        : std_logic_vector ( 7 downto 0);
        variable space_char  : character;
      begin
--reset the system   and open input file
        rst_n <= '0';
        file_open(input_file_info,"sample_input_fft.txt",read_mode);
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;
        rst_n <= '1';
--finish reset
--        cycle_count <= cycle_count + 1;
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;

        while not endfile(input_file_info) loop
          wait until falling_edge(clk);
--          cycle_count <= cycle_count + 1;
          data_en <= '1'; 
            readline(input_file_info,input_line);
            for k in 0 to 7 loop
              read(input_line,data_term);
              input_data(k) <= signed(data_term);
              if(k /= 7) then
                read(input_line,space_char);
              end if;
            end loop;
        end loop;
        wait until(falling_edge(clk));
        data_en <= '0';
--        cycle_count <= cycle_count + 1;
        wait until(falling_edge(clk));
--        cycle_count <= cycle_count + 1;
        wait until(falling_edge(clk));
--        cycle_count <= cycle_count + 1;
        file_close(input_file_info);
        wait;
    end process;
--in conjunction with opening the input file,open the output
--file,monitor the output and dump it  into output file
    process(clk,output_data_valid) is
        variable output_line : line;
    begin
        if(rising_edge(clk))then
            if(cycle_count = 3) then
              file_open(output_file_info,"sample_output_fft.txt",write_mode);
              file_open(output_file_cycle_info,"sample_output_fft_cycle.txt",write_mode);
            elsif(output_data_valid = '1')then
               write(output_line,string'("Real                           "));
               write(output_line,string'("Imaginary                           "));
               writeline(output_file_info,output_line);
               write(output_line,string'("Cycle number  :    "));
               write(output_line,cycle_count);
               writeline(output_file_cycle_info,output_line);
               output_test_case <= output_test_case + 1;
               for k in 0 to 7 loop
                 write(output_line,real_data_out_file(k));
                 write(output_line,string'("                     "));
                 write(output_line,imag_data_out_file(k));
--                 write(output_line,string'("         "));
                 writeline(output_file_info,output_line);
               end loop;
            end if;
            if(output_test_case >= 63)then
              file_close(output_file_info);
              file_close(output_file_cycle_info);
              report "Test completed";
              stop(0);
            end if;
        end if;
    end process;

end tb_fft_arch;
