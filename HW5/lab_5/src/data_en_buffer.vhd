--Engineer     : Abhijit Gadad
--Date         : 9/2/2017
--Name of file : processor_top.vhd
--Description  : top level entity of the processor which instantiates components

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_en_buffer is
    port(
	  clk,rst_n      : in std_logic  ;
	  data_in_en	: in std_logic;	    	
          data_in_en_buff: out std_logic
          
          );
end data_en_buffer ;

architecture data_en_buffer_arch of data_en_buffer is

--	signal data_en_buffer : std_logic_vector ( 3 downto 0);

begin

--out_valid d-flipflop
	process (clk, rst_n) begin
		if (rst_n = '0') then 

			
		elsif (rising_edge(clk)) then


	        end if;

	end process;      	        

	        
end data_en_buffer_arch;
