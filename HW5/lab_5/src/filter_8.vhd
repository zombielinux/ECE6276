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

begin

--Frequency Halver
--D flipflop with Qnot connected back to the D input Q is the output

--Frequency Eigther
--3 frequency halvers in series. 

--Multiplier
--	execute every clock cycle
--	real_out=(real_in*real_coeff)-(imag_in*imag_coeff)
--	imag_out=(real_in*imag_coeff)+(real_coeff*imag_in)

--Adder-sequence
-- execute add every OTHER clock cycle
-- every EIGHTH clock cycle, reset the storage flip flop to zero
-- flip flop stores output of adder and pipes it into one of the operands. 

--Output
--execute output every EIGHTH clock cycle

end filter_8_arch;
