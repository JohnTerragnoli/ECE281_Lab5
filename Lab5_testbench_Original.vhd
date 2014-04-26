--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:40:03 07/11/2012
-- Design Name:   
-- Module Name:   C:/My_Designs/ECE281_Xilinx14/Lab5_test/Lab5_testbench.vhd
-- Project Name:  Lab5_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PRISM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Lab5_testbench IS
END Lab5_testbench;
 
ARCHITECTURE behavior OF Lab5_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PRISM
    PORT(
         Clock : IN  std_logic;
         Reset_L : IN  std_logic;
         Control_Bus : OUT  std_logic_vector(25 downto 0);
         Input_0 : IN  std_logic_vector(3 downto 0);
         Input_1 : IN  std_logic_vector(3 downto 0);
         Input_2 : IN  std_logic_vector(3 downto 0);
         Input_3 : IN  std_logic_vector(3 downto 0);
         Output_0 : OUT  std_logic_vector(3 downto 0);
         Output_1 : OUT  std_logic_vector(3 downto 0);
         Output_2 : OUT  std_logic_vector(3 downto 0);
         Output_3 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Reset_L : std_logic := '0';
   signal Input_0 : std_logic_vector(3 downto 0) := (others => '0');
   signal Input_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Input_2 : std_logic_vector(3 downto 0) := (others => '0');
   signal Input_3 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Control_Bus : std_logic_vector(25 downto 0);
   signal Output_0 : std_logic_vector(3 downto 0);
   signal Output_1 : std_logic_vector(3 downto 0);
   signal Output_2 : std_logic_vector(3 downto 0);
   signal Output_3 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PRISM PORT MAP (
          Clock => Clock,
          Reset_L => Reset_L,
          Control_Bus => Control_Bus,
          Input_0 => Input_0,
          Input_1 => Input_1,
          Input_2 => Input_2,
          Input_3 => Input_3,
          Output_0 => Output_0,
          Output_1 => Output_1,
          Output_2 => Output_2,
          Output_3 => Output_3
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

		Input_0 <= "0001";
      Input_1 <= "1001";
      Input_2 <= "1001";
      Input_3 <= "0001";
		wait for Clock_period;
		reset_l <= '1';
		wait;

   end process;

END;
