--Engineer     : Abhijit Gadad
--Date         : 8/25/2017
--Name of file : tb_barrel_shifter.vhd
--Description  : test bench for barrel shifter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_barrel_shifter is
--no ports needed for this since this 
--is the top most module and no interaction
--with outside modules needed
end tb_barrel_shifter;

architecture tb_behav_barrel of tb_barrel_shifter is
--the component instructs the compiler that the 
--following module(ip) is going to be used in the design
    component barrel_shifter
        port (         a   : in  std_logic_vector(7 downto 0);
                       ctrl: in  std_logic_vector(2 downto 0);
                       y   : out std_logic_vector(7 downto 0));
    end component;
--signals local only to the present ip
    signal input_data : std_logic_vector (7 downto 0);
    signal  ctrl_data : std_logic_vector (2 downto 0);
    signal     y_data : std_logic_vector (7 downto 0);
begin
    DUT : barrel_shifter port map (a   => input_data,
                                   ctrl=>ctrl_data,
                                   y   => y_data);
    process
    begin
--initialize all the values
        input_data <= (others=>'0');
        ctrl_data  <= (others=>'0');
        wait for  10 ns;
--stimulate the design  

-- Add your test cases here , use a granularity of 10ns 
-- you're going to be defining the input to the barrel shifter and how much to shift,
-- then waiting 10ns between each case.
-- TEST CASE 1

--if there is no semicolon, the command continues to the next line. 
    input_data <= X"12";
    ctrl_data  <= "011";
    
--    for i in 0 to 7 loop
--       wait for 10 ns;
--       input_data <= std_logic_vector(unsigned(input_data) + 1);
--       ctrl_data  <= std_logic_vector(unsigned(ctrl_data)  + 1);
--    end loop;
--    assert false
--    report "Test Case 1 completed"
--    severity failure;
--    wait for 10 ns;

---- TEST CASE 2

    input_data <= X"45";
    ctrl_data  <= "110";

--    assert false
--    report "Test Case 2 completed"
--    severity failure;
--    wait for 10 ns;
--
--
---- TEST CASE 3

    input_data <= X"78";
    ctrl_data  <= "001";

--    assert false
--    report "Test Case 3 completed"
--    severity failure;
--    wait for 10 ns;
-- between test cases

      
        for i in 0 to 7 loop
            wait for 10 ns;
            input_data <= std_logic_vector(unsigned(input_data) + 1);
            ctrl_data  <= std_logic_vector(unsigned(ctrl_data)  + 1);
        end loop;
        assert false
        report "Test completed"
--end the test
        severity failure;
    end process;
end tb_behav_barrel;    
