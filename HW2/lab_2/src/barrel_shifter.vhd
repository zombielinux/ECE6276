--Engineer     : Abhijit Gadad
--Date         : 8/25/2017
--Name of file : barrel_shifter.vhd
--Description  : implements a barrel shifter
--               of data width 8 bits

library ieee;
use ieee.std_logic_1164.all;
entity barrel_shifter is
--port list
    port(
         a   : in  std_logic_vector(7 downto 0); -- input data
         ctrl: in  std_logic_vector(2 downto 0); -- control word
         y   : out std_logic_vector(7 downto 0)  -- output data
        );
end barrel_shifter ;

architecture barrel_arch of barrel_shifter is
begin
--Comb logic which implements 
--the simple functionality
    with ctrl select
        y <= a                     when "000",
             a(0) & a(7 downto 1) when "001",
             a(1 downto 0) & a(7 downto 2) when "010",
             a(2 downto 0) & a(7 downto 3) when "011",
             a(3 downto 0) & a(7 downto 4) when "100",
             a(4 downto 0) & a(7 downto 5) when "101",
             a(5 downto 0) & a(7 downto 6) when "110",
             a(6 downto 0) & a(7)          when others;

end barrel_arch; 
