-------------------------------------------------------------------------------
--
-- Title       : Memory
-- Design      : Memory
-- Author      : usafa
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : Memory.vhd
-- Generated   : Wed Mar 28 12:10:37 2007
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Memory} architecture {Memory}}

library ieee;  
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity IO is
	port( Clock : in std_logic;
		 IOSEL_L : in STD_LOGIC;
		 R_W : in STD_LOGIC;
		 Addr : in STD_LOGIC_VECTOR(3 downto 0);
		 Data : inout STD_LOGIC_VECTOR(3 downto 0);
		 Input_0 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_1 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_2 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_3 : in STD_LOGIC_VECTOR(3 downto 0);
		 Output_0 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_1 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_2 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_3 : out STD_LOGIC_VECTOR(3 downto 0)		 
	     );
end IO;

--}} End of automatically maintained section

architecture IO of IO is
  type IO_type is array (0 to 3)  
        of std_logic_vector (3 downto 0);  
  signal Input, Output : IO_type; 
  signal Read_Enable, Write_Enable : std_logic;
  
begin
  Read_Enable <=  '0' when(IOSEL_L='0' and R_W = '1') else '1';
  Write_Enable <=  '0' when(IOSEL_L='0' and R_W = '0') else '1';

  Input(0) <= Input_0;
  Input(1) <= Input_1;
  Input(2) <= Input_2;
  Input(3) <= Input_3;

  Output_0 <= Output(0);
  Output_1 <= Output(1);
  Output_2 <= Output(2);
  Output_3 <= Output(3);
 
  process (Clock)  
  begin  		
	if(Falling_Edge(Clock)) then
		if(Read_Enable = '0') then
			Data <= Input(conv_integer(Addr));
		else
			Data <= "ZZZZ";
		end if;
	end if;	
		
	if(Rising_Edge(Clock)) then
		if(Write_Enable = '0') then
			Output(conv_integer(Addr)) <= Data;
		end if;
	end if;  
  end process;  
	
	
end IO;