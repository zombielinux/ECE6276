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

signal a_in,b_in,c_in : signed ( 7 downto 0 );
signal mac_out : signed (16 downto 0);
signal round_out : signed (13 downto 0);
signal overunder_stat : std_logic_vector (1 downto 0);
signal overunder_out : signed (13 downto 0);
signal saturation_out : signed (8 downto 0);

begin

	macblock : entity work.mac port map (a_in,b_in,c_in,std_logic_vector(ctrl_in),mac_out);
	roundblock : entity work.round port map (mac_out, round_out);
	overunderblock : entity work.overunder port map (round_out, overunder_stat, overunder_out);
	satblock : entity work.saturation port map (overunder_out, overunder_stat, saturation_out, out_valid);

	--Pull in valid data
	process (clk, rst_n, en_in) begin
		if (rst_n = '0') then
			out_valid <= '0';
		elsif (rising_edge(clk)) then
			a_in <= operand_a_in;
			b_in <= operand_b_in;
			c_in <= operand_c_in;
			result_out <= saturation_out;
		end if;	
	--Clock data out of MAC
	--Clock data out of rounding block
	end process;
	

end processor_v2_top_arch;
