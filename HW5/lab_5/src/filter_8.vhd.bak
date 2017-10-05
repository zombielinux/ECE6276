--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter_8 is
    port(
          clk,rst_n      : in std_logic  ;
          
          data_en_in     : in std_logic  ;
          coeff_en_in    : in std_logic  ;   
           --real part of the co-efficients
          coeff_real_0   : in std_logic_vector (7 downto 0) ;
          coeff_real_1   : in std_logic_vector (7 downto 0) ;
          coeff_real_2   : in std_logic_vector (7 downto 0) ;
          coeff_real_3   : in std_logic_vector (7 downto 0) ;
          coeff_real_4   : in std_logic_vector (7 downto 0) ;
          coeff_real_5   : in std_logic_vector (7 downto 0) ;
          coeff_real_6   : in std_logic_vector (7 downto 0) ;
          coeff_real_7   : in std_logic_vector (7 downto 0) ;
           --imaginary part of the co-efficients
          coeff_imag_0   : in std_logic_vector (7 downto 0) ;
          coeff_imag_1   : in std_logic_vector (7 downto 0) ;
          coeff_imag_2   : in std_logic_vector (7 downto 0) ;
          coeff_imag_3   : in std_logic_vector (7 downto 0) ;
          coeff_imag_4   : in std_logic_vector (7 downto 0) ;
          coeff_imag_5   : in std_logic_vector (7 downto 0) ;
          coeff_imag_6   : in std_logic_vector (7 downto 0) ;
          coeff_imag_7   : in std_logic_vector (7 downto 0) ;

          --input data stream
          data_in        : in std_logic_vector  (7 downto 0) ;
          --output data stream
          real_data_out  : out std_logic_vector (9 downto 0) ;
          imag_data_out  : out std_logic_vector (9 downto 0) ;
          out_valid      : out std_logic 

        );
end filter_8 ;

architecture filter_8_arch of filter_8 is

	signal data_real_0 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_1 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_2 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_3 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_4 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_5 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_6 : std_logic_vector ( 7 downto 0 ); 
	signal data_real_7 : std_logic_vector ( 7 downto 0 ); 
	
	signal data_imag_0 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_1 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_2 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_3 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_4 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_5 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_6 : std_logic_vector ( 7 downto 0 ); 
	signal data_imag_7 : std_logic_vector ( 7 downto 0 ); 	

	signal res_real_0 : std_logic_vector ( 16 downto 0 );
	signal res_real_1 : std_logic_vector ( 16 downto 0 );
	signal res_real_2 : std_logic_vector ( 16 downto 0 );
	signal res_real_3 : std_logic_vector ( 16 downto 0 );
	signal res_real_4 : std_logic_vector ( 16 downto 0 );
	signal res_real_5 : std_logic_vector ( 16 downto 0 );
	signal res_real_6 : std_logic_vector ( 16 downto 0 );
	signal res_real_7 : std_logic_vector ( 16 downto 0 );
	
	signal res_imag_0 : std_logic_vector ( 16 downto 0 );
	signal res_imag_1 : std_logic_vector ( 16 downto 0 );
	signal res_imag_2 : std_logic_vector ( 16 downto 0 );
	signal res_imag_3 : std_logic_vector ( 16 downto 0 );
	signal res_imag_4 : std_logic_vector ( 16 downto 0 );
	signal res_imag_5 : std_logic_vector ( 16 downto 0 );
	signal res_imag_6 : std_logic_vector ( 16 downto 0 );
	signal res_imag_7 : std_logic_vector ( 16 downto 0 );
	
	signal real_data_out_temp : std_logic_vector ( 18 downto 0 );
	signal imag_data_out_temp : std_logic_vector ( 18 downto 0 );	
	
	signal data_out_valid_buff : std_logic;
begin

Data_valid_buffer : entity work.data_en_buffer port map (clk,
			rst_n,
			data_en_in,
			data_out_valid_buff);


Data_Buf_In : entity work.input_buffer port map (clk,
			rst_n,
			data_en_in,
			data_in,
			data_real_0,
			data_real_1,
			data_real_2,
			data_real_3,
			data_real_4,
			data_real_5,
			data_real_6,
			data_real_7,
			data_real_0,
			data_real_1,
			data_real_2,
			data_real_3,
			data_real_4,
			data_real_5,
			data_real_6,
			data_real_7);

		--perform all 8 multiplications
Mult0 : entity work.complex_mult port map (coeff_real_0,coeff_imag_0,data_real_0,(others => '0'),res_real_0,res_imag_0);
Mult1 : entity work.complex_mult port map (coeff_real_1,coeff_imag_1,data_real_1,(others => '0'),res_real_1,res_imag_1);
Mult2 : entity work.complex_mult port map (coeff_real_2,coeff_imag_2,data_real_2,(others => '0'),res_real_2,res_imag_2);
Mult3 : entity work.complex_mult port map (coeff_real_3,coeff_imag_3,data_real_3,(others => '0'),res_real_3,res_imag_3);
Mult4 : entity work.complex_mult port map (coeff_real_4,coeff_imag_4,data_real_4,(others => '0'),res_real_4,res_imag_4);
Mult5 : entity work.complex_mult port map (coeff_real_5,coeff_imag_5,data_real_5,(others => '0'),res_real_5,res_imag_5);
Mult6 : entity work.complex_mult port map (coeff_real_6,coeff_imag_6,data_real_6,(others => '0'),res_real_6,res_imag_6);
Mult7 : entity work.complex_mult port map (coeff_real_7,coeff_imag_7,data_real_7,(others => '0'),res_real_7,res_imag_7);


	process (clk, rst_n) begin
		if (coeff_en_in = '1') then
			out_valid <= '0';
		else
			if (rst_n = '0') then 
				out_valid <= '0';
				imag_data_out <= "1111000010";
				real_data_out <= "0000111101";
			
			elsif (rising_edge(clk) and (data_en_in = '1')) then 	
--add all the multiplcation results together. 
				real_data_out_temp <= std_logic_vector(resize(signed(res_real_0)+signed(res_real_1)+signed(res_real_2)+signed(res_real_3)+signed(res_real_4)+signed(res_real_5)+signed(res_real_6)+signed(res_real_7),19));
				imag_data_out_temp <= std_logic_vector(resize(signed(res_imag_0)+signed(res_imag_1)+signed(res_imag_2)+signed(res_imag_3)+signed(res_imag_4)+signed(res_imag_5)+signed(res_imag_6)+signed(res_imag_7),19));
		
				real_data_out <= real_data_out_temp(18 downto 9);
				imag_data_out <= imag_data_out_temp(18 downto 9);	

--needs to be delayed 9 clock cycles. 	
				out_valid <= data_out_valid_buff;

		--else
			end if;
		end if;
	end process;

end filter_8_arch;
