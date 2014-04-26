library ieee;  
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;


entity RAM_16x4 is
  port (Clock : in std_logic;
  		CS_L : in std_logic;
        R_W  : in std_logic;  
        Addr   : in std_logic_vector(3 downto 0);  
        Data  : inout std_logic_vector(3 downto 0));  
end RAM_16x4;  

architecture RAM_16x4_Arch of RAM_16x4 is  
  type ram_type is array (0 to 31)  
        of std_logic_vector (3 downto 0);  
  signal RAM : ram_type; 
  signal Read_Enable, Write_Enable : std_logic;
begin
	Read_Enable <=  '0' when(CS_L='0' and R_W = '1') else '1';
	Write_Enable <=  '0' when(CS_L='0' and R_W = '0') else '1';
	
  process (Clock)  
  begin  		
	if(Clock = '0') then
		if(Read_Enable = '0') then
		  Data  <= RAM(conv_integer(Addr));  
		else
			Data <= "ZZZZ";
		end if;
		
		if(Write_Enable = '0') then
		  RAM(conv_integer(Addr))  <= Data; 
		end if;
		
	--else Data <= "ZZZZ";  
		
		
		
	end if;
		
--	if(Clock = '1') then
--		if(Write_Enable = '0') then
--		  RAM(conv_integer(Addr))  <= Data; 
--		end if;  

		
	--end if;
  end process;  
end RAM_16x4_Arch;
