--Engineer     : Abhijit Gadad
--Date         : 9/2/2017
--Name of file : tb_processor.vhd
--Description  : test bench for the processor design

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity tb_processor is
end tb_processor;

architecture tb_processor_arch of tb_processor is
    component processor_top is
    port(
          clk,rst_n      : in std_logic  ;
          en_in          : in std_logic  ;
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          operand_a_in,operand_b_in,operand_c_in : in std_logic_vector   ( 7  downto 0);
          out_valid    : out std_logic   ;
          result_out   : out std_logic_vector  ( 16 downto 0)
        );
    end component;
     signal   clk          : std_logic;
     signal   rst_n        : std_logic := '1';
     signal   en           : std_logic := '0';
     signal   a,b,c        : std_logic_vector   ( 7  downto 0);
     signal   ctrl         : std_logic_vector ( 1  downto 0);
     signal   mac_out_valid: std_logic;
     signal   mac_out      : std_logic_vector   ( 16 downto 0);
     constant T: time := 20 ns;
     signal rand_num : integer := 0;
     file input_file_info : text;
     file output_file_info : text;
     signal cycle_count  : integer := 0;


begin
--Instantiate the design under test
    DUT : processor_top port map (
                                  clk   => clk,
                                  rst_n => rst_n,
                                  en_in => en,
                                  ctrl_in => ctrl,
                                  operand_a_in => a,
                                  operand_b_in => b,
                                  operand_c_in => c,
                                  out_valid    => mac_out_valid,
                                  result_out   => mac_out
                       );
    process 
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process;

    process
        variable input_line : line;
        variable output_line : line;
        variable en_term     : std_logic; 
        variable ctrl_term   : std_logic_vector(1 downto 0);
        variable m_term1     : std_logic_vector(7 downto 0);
        variable m_term2     : std_logic_vector(7 downto 0);
        variable a_term      : std_logic_vector(7 downto 0);
        variable space_char  : character;
      begin
--open the input and output files
        file_open(input_file_info,"sample_input_processor.txt",read_mode);
        file_open(output_file_info,"sample_output_processor.txt",write_mode);
        write(output_line  ,string'("Cycle number     "));
        write(output_line  ,string'("output_valid     "));
        write(output_line  ,string'("output_value     "));      
        writeline(output_file_info,output_line);
--initialize the driving variables
        ctrl <= "00";      
        a    <= "00000000";
        b    <= "00000000";
        c    <= "00000000";
--reset the system
        rst_n <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);
        cycle_count <= cycle_count + 1;
        write(output_line,cycle_count);
        write(output_line,string'("                     "));
        write(output_line,mac_out_valid);
        write(output_line,string'("           "));
        if(mac_out_valid = '0')then
          write(output_line,string'("dont care"));
        else
          write(output_line,mac_out);
        end if;
        writeline(output_file_info,output_line);
        wait until falling_edge(clk);
        cycle_count <= cycle_count + 1;
        write(output_line,cycle_count);
        write(output_line,string'("                     "));
        write(output_line,mac_out_valid);
        write(output_line,string'("           "));
        if(mac_out_valid = '0')then
          write(output_line,string'("dont care"));
        else
          write(output_line,mac_out);
        end if;
        writeline(output_file_info,output_line);
        rst_n <= '1';
--end of reset

--write the first line of the output
        wait until falling_edge(clk);
        cycle_count <= cycle_count + 1;
        write(output_line,cycle_count);
        write(output_line,string'("                     "));
        write(output_line,mac_out_valid);
        write(output_line,string'("           "));
        if(mac_out_valid = '0')then
          write(output_line,string'("dont care"));
        else
          write(output_line,mac_out);
        end if;
        writeline(output_file_info,output_line);

--loop over the lines and for each line of input, write output into the file
        while not endfile(input_file_info) loop
        readline(input_file_info,input_line);
        read(input_line,en_term);
        read(input_line,space_char);
        read(input_line,ctrl_term);
        read(input_line,space_char);
        read(input_line,m_term1);
        read(input_line,space_char);
        read(input_line,m_term2);
        read(input_line,space_char);
        read(input_line,a_term);
        en  <=en_term;
        ctrl<=(ctrl_term);
        a<=(m_term1);
        b<=(m_term2);
        c<=(a_term);
        
        wait until falling_edge(clk);
        cycle_count <= cycle_count + 1;
        write(output_line,cycle_count);
        write(output_line,string'("                     "));
        write(output_line,mac_out_valid);
        write(output_line,string'("           "));
        if(mac_out_valid = '0')then
          write(output_line,string'("dont care"));
        else
          write(output_line,mac_out);
        end if;
        writeline(output_file_info,output_line);

        end loop;
--close the files
        file_close(input_file_info);
        file_close(output_file_info);
        report "Test completed";
        stop(0);

    end process;
end tb_processor_arch;
