--Engineer     : Abhijit Gadad
--Date         : 9/2/2017
--Name of file : processor_top.vhd
--Description  : top level entity of the processor which instantiates components

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_top is
    port(
          clk,rst_n      : in std_logic  ;
          en_in          : in std_logic  ; --when en_in = 1, all the inputs are latched
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          operand_a_in,operand_b_in,operand_c_in : in std_logic_vector   ( 7  downto 0);
          out_valid    : out std_logic   ; --when out_valid =1, all the outputs are valid,in all the other cycles, output is invalid
          result_out   : out std_logic_vector  ( 16 downto 0)
        );
end processor_top ;

architecture processor_top_arch of processor_top is
 
	signal out_valid_stage1 : std_logic;
	signal ctrl_out_stage1: std_logic_vector ( 1 downto 0);
	signal out_a_stage1 : std_logic_vector ( 7 downto 0);
	signal out_b_stage1 : std_logic_vector ( 7 downto 0);
	signal out_c_stage1 : std_logic_vector ( 7 downto 0);
	signal mac_result : std_logic_vector ( 16 downto 0 );
begin

--stage1
ST1 : entity work.stage1 port map (clk,rst_n,en_in,ctrl_in,operand_a_in,operand_b_in,operand_c_in,out_valid_stage1,ctrl_out_stage1,out_a_stage1,out_c_stage1,out_c_stage1);
--mac
MAC : entity work.mac port map (out_a_stage1,out_b_stage1,out_c_stage1,ctrl_out_stage1,mac_result);
--stage2
ST2 : entity work.stage2 port map (clk,rst_n,out_valid_stage1,mac_result,out_valid_stage2,stage2_result);
--stage3
--ST2 : entity work.stage3 port map (out_valid_stage1);

	result_out <= (others => '1');

end processor_top_arch;
