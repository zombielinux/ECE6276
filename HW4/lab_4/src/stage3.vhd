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
	  result_stage2_in : in std_logic_vector ( 16 downto 0);
          out_valid_stage3    : out std_logic   ; --when out_valid =1, all the outputs are valid,in all the other cycles, output is invalid
          result_out_stage3   : out std_logic_vector  ( 16 downto 0)
        );
end processor_top ;

architecture processor_top_arch of processor_top is

begin

--out_valid d-flipflop
	process (clk, rst_n) begin
		if (rst_n = '0') then 
			out_valid_stage3 <= '0';
			result_out_stage3 <= (others => '1');
		elsif (rising_edge(clk)) then
		        out_valid_stage3 <= en_in;
			result_out_stage3 <= result_stage2_in;
	        end if;

	end process;      	        

	        
end processor_top_arch;
