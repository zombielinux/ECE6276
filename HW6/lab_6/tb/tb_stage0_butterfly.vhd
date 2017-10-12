S--Engineer     : Philip Wolfe
--Date         : 10/5/17
--Name of file : tb_stage0_butterfly.vhd
--Description  : test bench for stage0_butterfly

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_stage0_butterfly is 
end tb_stage0_butterfly;

architecture tb_behav_stage0_butterfly of tb_stage0_butterfly is
    -- component definitions
    component stage0_butterfly
        generic (N,W : integer);
        port(
            -- incoming data1 and data2's real and imag parts
            a_r, b_r        : in  signed(N-1   downto 0);
            -- roots of unity real and imag coordinates from fft
            w_r, w_i        : in  signed(W-1   downto 0);
            -- output real and imag parts
            out1_r,out1_i   : out signed(N+W-7-1 downto 0);
            out2_r,out2_i   : out signed(N+W-7-1 downto 0)
        );
    end component;
    
    -- constant declarations
    constant N          : integer := 8;    -- input 1,2 width
    constant W          : integer := 9;     -- weight width
    constant N_o        : integer := N+W-7; -- output width
    
    -- internal signals
    signal a_r, b_r             : signed(N-1   downto 0);
    signal w_r, w_i             : signed(W-1   downto 0);
    signal o1_r,o1_i, o2_r,o2_i : signed(N_o-1 downto 0);

begin
    DUT : stage0_butterfly 
        generic map ( N, W )
        port map (
            a_r, b_r,
            w_r, w_i,
            o1_r, o1_i,
            o2_r, o2_i
        );
    
    process begin
        --initialize all the values
        a_r <= (others=>'0');
        b_r <= (others=>'0');
        w_r <= (others=>'0');
        w_i <= (others=>'0');
        wait for  10 ns;

        -- TEST CASE 1
        -- a = (-131,0), b = (-82,0), w = (111,-40)
        -- expected out: (-27,20) and (25,-21)
        
        a_r <= to_signed(-1,   N);
        b_r <= to_signed(-82,    N);
        w_r <= to_signed(11,    W);
        w_i <= to_signed(-40,    W);
        wait for  10 ns;
        assert( 
            (o1_r=to_signed(-4,N_o)) and (o1_i=to_signed( 12,N_o)) and
            (o2_r=to_signed( 3,N_o)) and (o2_i=to_signed(-13,N_o))
        )
        report "================test case 1 failed! look at the waveform!================"
        severity error;
        
        -- report "test complete. check above for any failed test cases";
        wait; --end the test
    end process;
end tb_behav_stage0_butterfly;    
