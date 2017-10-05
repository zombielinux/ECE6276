--Engineer     : Abhijit Gadad
--Date         : 9/2/2017
--Name of file : processor_top.vhd
--Description  : top level entity of the processor which instantiates components

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_buffer is
    port(
	  clk,rst_n      : in std_logic  ;	    	
	  data_in        : in std_logic_vector  (7 downto 0) ;    
          data_0_in	: in std_logic_vector ( 7 downto 0);
          data_1_in	: in std_logic_vector ( 7 downto 0);
          data_2_in	: in std_logic_vector ( 7 downto 0);
          data_3_in	: in std_logic_vector ( 7 downto 0);
          data_4_in	: in std_logic_vector ( 7 downto 0);
          data_5_in	: in std_logic_vector ( 7 downto 0);
          data_6_in	: in std_logic_vector ( 7 downto 0); 
          data_7_in	: in std_logic_vector ( 7 downto 0); 
          
          data_0_out	: out std_logic_vector ( 7 downto 0 );
          data_1_out	: out std_logic_vector ( 7 downto 0 );
          data_2_out	: out std_logic_vector ( 7 downto 0 );
          data_3_out	: out std_logic_vector ( 7 downto 0 );
          data_4_out	: out std_logic_vector ( 7 downto 0 );
          data_5_out	: out std_logic_vector ( 7 downto 0 );
          data_6_out	: out std_logic_vector ( 7 downto 0 );                    
          data_7_out	: out std_logic_vector ( 7 downto 0 )
          
          );
end input_buffer ;

architecture input_buffer_arch of input_buffer is

begin

--out_valid d-flipflop
	process (clk, rst_n) begin
		if (rst_n = '0') then 
			data_0_out <= (others => '0');
			data_1_out <= (others => '0');
			data_2_out <= (others => '0');
			data_3_out <= (others => '0');
			data_4_out <= (others => '0');
			data_5_out <= (others => '0');
			data_6_out <= (others => '0');
			data_7_out <= (others => '0');
		elsif (rising_edge(clk)) & (data_in) then
			data_0_out <= data_in;
			data_1_out <= data_0_in;
			data_2_out <= data_1_in;
			data_3_out <= data_2_in;
			data_4_out <= data_3_in;
			data_5_out <= data_4_in;
			data_6_out <= data_5_in;
			data_7_out <= data_6_in;
		else
			data_0_out <= data_0_in;
			data_1_out <= data_1_in;
			data_2_out <= data_2_in;
			data_3_out <= data_3_in;
			data_4_out <= data_4_in;
			data_5_out <= data_5_in;
			data_6_out <= data_6_in;
			data_7_out <= data_7_in;		
	        end if;

	end process;      	        

	        
end input_buffer_arch;
