--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : tb_filter.vhd
--Description  : implements the test bench for fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity tb_filter is
end tb_filter;

architecture tb_filter_arch of tb_filter is
    component filter_8 is
    port(
          clk,rst_n      : in std_logic  ;
          data_en_in          : in std_logic  ;
          coeff_en_in         : in std_logic;
          coeff_real_0,coeff_real_1,coeff_real_2,
          coeff_real_3,coeff_real_4,coeff_real_5,
          coeff_real_6,coeff_real_7 : in std_logic_vector (7 downto 0);
          coeff_imag_0,coeff_imag_1,coeff_imag_2,
          coeff_imag_3,coeff_imag_4,coeff_imag_5,
          coeff_imag_6,coeff_imag_7 : in std_logic_vector (7 downto 0);
          data_in              : in std_logic_vector (7 downto 0);
          real_data_out        : out std_logic_vector (9 downto 0);
          imag_data_out        : out std_logic_vector (9 downto 0);
          out_valid            : out std_logic
        );
    end component;
     type factor_real is array (0 to 7) of std_logic_vector(7 downto 0);
     type factor_imag is array (0 to 7) of std_logic_vector(7 downto 0);

     signal   clk          : std_logic;
     signal   rst_n        : std_logic := '1';
     signal   data_en      : std_logic := '0';
     signal   coeff_en     : std_logic := '0';
     signal   coeff_real   : factor_real;
     signal   coeff_imag   : factor_imag;
     signal   input_data   : std_logic_vector( 7 downto 0);
     signal   output_data_real : std_logic_vector(9 downto 0);
     signal   output_data_imag : std_logic_vector(9 downto 0);
     signal   output_data_valid : std_logic;

     constant T: time := 20 ns;
     signal rand_num : integer := 0;
     signal output_test_case : integer := 0;
     file input_file_info : text;
     file output_file_info : text;
     file output_file_cycle_info : text;
     signal mac_out_file : std_logic_vector(16 downto 0) ;
     signal cycle_count  : integer := 0;
     signal coeff_read   : integer := 0;


begin
--DUT instantiation
    DUT : filter_8 port map(
          clk            => clk,     
          rst_n          =>rst_n    ,
          data_en_in     =>data_en  ,
          coeff_en_in    =>coeff_en ,   
           --real part of the co-efficients
          coeff_real_0   => coeff_real(0),
          coeff_real_1   => coeff_real(1),
          coeff_real_2   => coeff_real(2),
          coeff_real_3   => coeff_real(3),
          coeff_real_4   => coeff_real(4),
          coeff_real_5   => coeff_real(5),
          coeff_real_6   => coeff_real(6),
          coeff_real_7   => coeff_real(7),
           --imaginary part of the co-efficients
          coeff_imag_0   => coeff_imag(0),
          coeff_imag_1   => coeff_imag(1),
          coeff_imag_2   => coeff_imag(2),
          coeff_imag_3   => coeff_imag(3),
          coeff_imag_4   => coeff_imag(4),
          coeff_imag_5   => coeff_imag(5),
          coeff_imag_6   => coeff_imag(6),
          coeff_imag_7   => coeff_imag(7),

          --input data stream
          data_in        => input_data,
          --output data stream
          real_data_out  => output_data_real,
          imag_data_out  => output_data_imag,
          out_valid      => output_data_valid 

                           );


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
--reset the system and open the input file
        rst_n <= '0';
        file_open(input_file_info,"sample_input_filter.txt",read_mode);
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;
        rst_n <= '1';
--end of reset
--        cycle_count <= cycle_count + 1;
        wait until falling_edge(clk);
--        cycle_count <= cycle_count + 1;
--read all the inputs from the sample input file
        while not endfile(input_file_info) loop
            if(coeff_read = 0)then
                readline(input_file_info,input_line);
                coeff_en <= '1';
                for k in 0 to 7 loop
                    read(input_line,real_coefficient);
                    read(input_line,space_char);
                    read(input_line,imag_coefficient);
                    coeff_real(k) <= (real_coefficient);
                    coeff_imag(k) <= (imag_coefficient);
                    
                    if (k /= 7) then
                      read(input_line,space_char);
                    end if;
                end loop;
                wait until(falling_edge(clk));
--                cycle_count <= cycle_count + 1;
                coeff_en <= '0';
                coeff_read <= coeff_read +1;
                wait until(falling_edge(clk));
--                cycle_count <= cycle_count + 1;
            else 
                wait until(falling_edge(clk));
--                cycle_count <= cycle_count + 1;
                data_en <= '1';
                readline(input_file_info,input_line);
                read(input_line,data_term);
                input_data <= (data_term);
            end if;
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
--in conjunction to driving the design, we open the output file,monitor the output file and
--dump the output onto the output file
    process(clk,output_data_valid) is
        variable output_line : line;
    begin
        if(rising_edge(clk))then
            if(cycle_count = 3) then
              file_open(output_file_info,"sample_output_filter.txt",write_mode);
              write(output_line,string'("Real                           "));
              write(output_line,string'("Imaginary          "));
              writeline(output_file_info,output_line);
              file_open(output_file_cycle_info,"sample_output_filter_cycle.txt",write_mode);
              write(output_line,string'("Cycle number       "));
              writeline(output_file_cycle_info,output_line);
            elsif(output_data_valid = '1')then
               output_test_case <= output_test_case + 1;
               write(output_line,output_data_real);
               write(output_line,string'("                     "));
               write(output_line,output_data_imag);
               writeline(output_file_info,output_line);
--               write(output_line,string'("         "));
               write(output_line,cycle_count);
               writeline(output_file_cycle_info,output_line);
            end if;
            if(output_test_case >= 63)then
              file_close(output_file_info);
              file_close(output_file_cycle_info);
              report "Test completed";
              stop(0);
            end if;
        end if;
    end process;

end tb_filter_arch;
