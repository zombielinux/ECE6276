--Engineer     : Abhijit Gadad
--Date         : 8/26/2017
--Name of file : mac.vhd
--Description  : implements a programmable mac unit
--              

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac is
--port list
    port(
          a_in,b_in,c_in : in std_logic_vector   ( 7  downto 0);
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          mac_unit_out   : out std_logic_vector  ( 16 downto 0)
        );
end mac ;

architecture mac_arch of mac is
begin

end mac_arch;
