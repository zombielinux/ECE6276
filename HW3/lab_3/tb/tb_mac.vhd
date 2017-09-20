--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : tb_mac.vhd
--Description  : testbench for the mac unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use std.env.all;
use std.textio.all;
use ieee.std_logic_textio.all;
entity tb_mac is
end tb_mac;

architecture tb_mac_arch of tb_mac is
    component mac
    port(
          a_in,b_in,c_in : in std_logic_vector   ( 7  downto 0);--data inputs
          ctrl_in        : in std_logic_vector ( 1  downto 0);--ctrl inputs
          mac_unit_out   : out std_logic_vector  ( 16 downto 0)--output
        );
    end component;
     signal   a,b,c       : std_logic_vector   ( 7  downto 0);
     signal   ctrl        : std_logic_vector ( 1  downto 0);
     signal   mac_out     : std_logic_vector   ( 16 downto 0);
     signal   clk         : std_logic;
     constant T: time := 20 ns;
     signal rand_num : integer := 0;
     file input_file_info : text;
     file output_file_info : text;
begin
--instantiation of the design under test
    DUT : mac port map (
                        a_in => a,
                        b_in => b,
                        c_in => c,
                        ctrl_in => ctrl,
                        mac_unit_out => mac_out
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
        variable ctrl_term   : std_logic_vector(1 downto 0);
        variable m_term1     : std_logic_vector(7 downto 0);
        variable m_term2     : std_logic_vector(7 downto 0);
        variable a_term      : std_logic_vector(7 downto 0);
        variable space_char  : character;
      begin
--open the files
        file_open(input_file_info,"sample_input.txt",read_mode);
        file_open(output_file_info,"sample_output.txt",write_mode);
--initialize all the variables        
        ctrl <= "00";
        a    <= "00000000";
        b    <= "00000000";
        c    <= "00000000";
--in the file read each line and write the output for each line
        while not endfile(input_file_info) loop
        readline(input_file_info,input_line);
        read(input_line,ctrl_term);
        read(input_line,space_char);
        read(input_line,m_term1);
        read(input_line,space_char);
        read(input_line,m_term2);
        read(input_line,space_char);
        read(input_line,a_term);
        ctrl<=ctrl_term;
        a<=m_term1;
        b<=m_term2;
        c<=a_term;
        wait until falling_edge(clk);
        write(output_line,mac_out,right,17);
        writeline(output_file_info,output_line);
        end loop;
--close the files
        file_close(input_file_info);
        file_close(output_file_info);
        report "Test completed";
        stop(0);

    end process;
end tb_mac_arch;
