--Engineer     : Abhijit Gadad
--Date         : 9/8/2017
--Name of file : processor_v2_top.vhd
--Description  : top level entity of the processor which instantiates components

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_v2_top is
    port(
          clk,rst_n      : in std_logic  ;
          en_in          : in std_logic  ;
          ctrl_in        : in unsigned ( 1  downto 0);
          operand_a_in,operand_b_in,operand_c_in : in signed   ( 7  downto 0);
          out_valid    : out std_logic   ;
          result_out   : out signed  ( 8 downto 0)
        );
end processor_v2_top ;

architecture processor_v2_top_arch of processor_v2_top is
begin

	--Pull in valid data
	process (clk, rst_n, en_in) begin
		if (rst_n = '0') then
			out_valid <= '0';
		elsif (rising_edge(clk)) then
			

	--Clock data out of MAC
	--Clock data out of rounding block

end processor_v2_top_arch;
