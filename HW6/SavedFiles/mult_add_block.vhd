--Engineer     : Abhijit Gadad
--Date         : 8/2/2017
--Name of file : filter_8.vhd
--Description  : implements an 8 tap fir filter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_add_block is
    generic(
    	n: integer := 7;
	s: integer := 2
    );
    port(
         a_real : in signed ( n downto 0 );
         a_imag : in signed ( n downto 0 ) := (others => '0');

         b_real : in signed ( n downto 0 );
         b_imag : in signed ( n downto 0 ) := (others => '0');
         
   	 w_real : in signed ( 8 downto 0 );
	 w_imag : in signed ( 8 downto 0 );

	 x_real : out signed ( n+s+1 downto 0 );
	 x_imag : out signed ( n+s+1 downto 0 );

	 y_real : out signed ( n+s+1 downto 0 );
	 y_imag : out signed ( n+s+1 downto 0 )

         
        );
end mult_add_block ;

architecture mult_add_block_arch of mult_add_block is
--multiplier component
	component complex_mult
		generic (w,n,s : integer);
		port (
			w_real, w_imag : in signed ( w downto 0 );
			b_real,	b_imag : in signed ( n downto 0 );
			res_real, res_imag : out signed (w+n+s downto 0)
		);
	end component;

	component complex_addsub
		generic (n,i : integer;
			op : std_logic);
		port (
			a_real,a_imag : in signed (n downto 0);
			b_real,b_imag : in signed (8+s+n downto 0);
			res_real,res_imag : out signed (9+s+n downto 0)
		);
	end component;
	
	component eight_right_shift
		generic (iw : integer);
		port (
			a_real,a_imag : in signed (iw downto 0);
			res_real,res_imag : out signed (n+s+1 downto 0)
		);
	end component;

	--internal signals to this stage
	signal mult_real : signed ( 8+n+s downto 0 );
	signal mult_imag : signed ( 8+n+s downto 0 );

	signal add_preshift_real : signed ( 9+n+s downto 0 );
	signal add_preshift_imag : signed ( 9+n+s downto 0 );

	signal sub_preshift_real : signed ( 9+n+s downto 0 );
	signal sub_preshift_imag : signed ( 9+n+s downto 0 );

begin

Mult_stage : complex_mult 
		generic map (
			w => 8,
			n => n,
			s => s
		)
		port map (
			w_real,
			w_imag,
			b_real,
			b_imag,
			mult_real,
			mult_imag);


--Complex Adder
Add_stage :  complex_addsub
	generic map (
		n => n,
		i => 8+s+n,
		op => '1'
	)
	port map(
		a_real,
		a_imag,
		mult_real,
		mult_imag,
		add_preshift_real,
		add_preshift_imag
	);


--Subtraction Stage
-- A-mult_result confirmed. 
Sub_stage :  complex_addsub
	generic map (
		n => n,
		i => 8+s+n,
		op => '0'
	)
	port map(
		a_real,
		a_imag,
		mult_real,
		mult_imag,
		sub_preshift_real,
		sub_preshift_imag
	);


--X_right_Shift
Add_right_shift : eight_right_shift
	generic map (
		iw => 9+n+s)
	port map (
		add_preshift_real,
		add_preshift_imag,
		x_real,
		x_imag
	);

--Y_right_Shift
Sub_right_shift : eight_right_shift
	generic map (
		iw => 9+n+s)
	port map (
		sub_preshift_real,
		sub_preshift_imag,
		y_real,
		y_imag
	);


end mult_add_block_arch;
