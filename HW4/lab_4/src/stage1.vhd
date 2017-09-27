--Engineer     : Abhijit Gadad
--Date         : 9/2/2017
--Name of file : processor_top.vhd
--Description  : top level entity of the processor which instantiates components

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stage1 is
    port(
          clk,rst_n      : in std_logic  ;
          en_in          : in std_logic  ; --when en_in = 1, all the inputs are latched
          ctrl_in        : in std_logic_vector ( 1  downto 0);
          operand_a_in,operand_b_in,operand_c_in : in std_logic_vector   ( 7  downto 0);
	  out_valid_stage1 : out std_logic;
	  ctrl_in_stage1 : out std_logic_vector ( 1 downto 0);
	  operand_a_out_stage1,operand_b_out_stage1,operand_c_out_stage1 : out std_logic_vector ( 7 downto 0)
        );
end stage1 ;

architecture stage1_arch of stage1 is

begin

--out_valid d-flipflop
	process (clk, rst_n) begin
		if (rst_n = '0') then 
			out_valid_stage1 <= '0';
			ctrl_in_stage1 <= (others => '1');
			operand_a_out_stage1 <= (others => '1');
			operand_b_out_stage1 <= (others => '1');
			operand_c_out_stage1 <= (others => '1');
		elsif (rising_edge(clk)) then
		        out_valid_stage1 <= en_in;
		        ctrl_in_stage1 <= ctrl_in;
		        operand_a_out_stage1 <= operand_a_in;
		        operand_b_out_stage1 <= operand_b_in;
		        operand_c_out_stage1 <= operand_c_in;
	        end if;

	end process;      	        

	        
end stage1_arch;
