--Engineer     : Abhijit Gadad
--Date         : 8/25/2017
--Name of file : barrel_shifter_16.vhd
--Description  : implements a barrel shifter
--               of data width 8 bits

library ieee;
use ieee.std_logic_1164.all;
entity barrel_shifter is
--port list
    port(
         a   : in  std_logic_vector(15 downto 0); -- input data
         ctrl: in  std_logic_vector(3 downto 0); -- control word
         y   : out std_logic_vector(15 downto 0)  -- output data
        );
end barrel_shifter ;

architecture barrel_arch of barrel_shifter is
begin
--Comb logic which implements 
--the simple functionality
    with ctrl select
        y <= a                     when "0000",
             a(0) & a(15 downto 1) when "0001",
             a(1 downto 0) & a(15 downto 2) when "0010",
             a(2 downto 0) & a(15 downto 3) when "0011",
             a(3 downto 0) & a(15 downto 4) when "0100",
             a(4 downto 0) & a(15 downto 5) when "0101",
             a(5 downto 0) & a(15 downto 6) when "0110",
             a(6 downto 0) & a(15 downto 7) when "0111",
             a(7 downto 0) & a(15 downto 8) when "1000",
             a(8 downto 0) & a(15 downto 9) when "1001",
             a(9 downto 0) & a(15 downto 10) when "1010",
             a(10 downto 0) & a(15 downto 11) when "1011",
             a(11 downto 0) & a(15 downto 12) when "1100",
             a(12 downto 0) & a(15 downto 13) when "1101",
             a(13 downto 0) & a(15 downto 14) when "1110",
             a(14 downto 0) & a(15)          when others;

end barrel_arch; 
