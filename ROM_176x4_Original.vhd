library ieee;  
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;


entity ROM_176x4 is
  port (Clock : in std_logic;
  		CS_L : in std_logic;
        R_W  : in std_logic;  
        Addr   : in std_logic_vector(7 downto 0);  
        Data  : out std_logic_vector(3 downto 0));  
end ROM_176x4;  

architecture ROM_176x4_Arch of ROM_176x4 is  
  type rom_type is array (0 to 175)  
        of std_logic_vector (3 downto 0);  
  signal ROM : rom_type; 
  signal Read_Enable : std_logic;
begin  
	-- Place program here.  Use 'X' to designate Hex format
	ROM(0) <= X"7";
	ROM(1) <= X"8";
	ROM(2) <= X"6";
	ROM(3) <= X"1";	
	ROM(4) <= X"4";
	ROM(5) <= X"3";
	ROM(6) <= X"b";
	ROM(7) <= X"2";
	ROM(8) <= X"0";
	ROM(9) <= X"9";
	ROM(10) <= X"9";
	ROM(11) <= X"0";
	--ROM(0) <= X"";
--	ROM(1) <= X"";
--	ROM(2) <= X"";
--	ROM(3) <= X"";	
--	ROM(4) <= X"";
--	ROM(5) <= X"";
--	ROM(6) <= X"";
--	ROM(7) <= X"";
--	ROM(8) <= X"";
--	ROM(9) <= X"";
--	ROM(10) <= X"";
--	ROM(11) <= X"";
--	ROM(12) <= X"";
--	ROM(13) <= X"";
--	ROM(14) <= X"";
--	ROM(15) <= X"";
--	ROM(16) <= X"";
--	ROM(17) <= X"";
--	ROM(18) <= X"";
--	ROM(19) <= X"";
--	ROM(20) <= X"";
--	ROM(21) <= X"";
--	ROM(22) <= X"";
--	ROM(23) <= X"";
--	ROM(24) <= X"";
--	ROM(25) <= X"";
--	ROM(26) <= X"";
--	ROM(27) <= X"";
--	ROM(28) <= X"";
--	ROM(29) <= X"";
--	ROM(30) <= X"";
--	ROM(31) <= X"";
--	ROM(32) <= X"";
--	ROM(33) <= X"";	
--	ROM(34) <= X"";   
--	ROM(35) <= X"";
--	ROM(36) <= X"";
--	ROM(37) <= X"";
--	ROM(38) <= X"";	
--	ROM(39) <= X"";
--	ROM(40) <= X"";
--	ROM(41) <= X"";
--	ROM(42) <= X"";
--	ROM(43) <= X"";
--	ROM(44) <= X"";
--	ROM(45) <= X"";
--	ROM(46) <= X"";
--	ROM(47) <= X"";
--	ROM(48) <= X"";
--	ROM(49) <= X"";
--	ROM(50) <= X"";
--	ROM(51) <= X"";
--	ROM(52) <= X"";
--	ROM(53) <= X"";
--	ROM(54) <= X"";
--	ROM(55) <= X"";
--	ROM(56) <= X"";
--	ROM(57) <= X"";
--	ROM(58) <= X"";
--	ROM(59) <= X"";
--	ROM(60) <= X"";
--	ROM(61) <= X"";
--	ROM(62) <= X"";
--	ROM(63) <= X"";
--	ROM(64) <= X"";
--	ROM(65) <= X"";
--	ROM(66) <= X"";
--	ROM(67) <= X"";
--	ROM(68) <= X"";	
--	ROM(69) <= X"";		 
--	ROM(70) <= X"";
--	ROM(71) <= X"";
--	ROM(72) <= X"";
--	ROM(73) <= X"";
--	ROM(74) <= X"";
--	ROM(75) <= X"";
--	ROM(76) <= X"";
--	ROM(77) <= X"";
--	ROM(78) <= X"";
--	ROM(79) <= X"";
--	ROM(80) <= X"";
--	ROM(81) <= X"";
--	ROM(82) <= X"";
--	ROM(83) <= X"";
--	ROM(84) <= X"";	
--	ROM(85) <= X""; 		 	 
--	ROM(86) <= X"";
--	ROM(87) <= X"";
--	ROM(88) <= X"";
--	ROM(89) <= X"";
--	ROM(90) <= X"";
--	ROM(91) <= X"";			  
--	ROM(92) <= X"";			--Best Address on here!!!
--	ROM(93) <= X"";
--	ROM(94) <= X"";
--	ROM(95) <= X"";
--	ROM(96) <= X"";
--	ROM(97) <= X"";
--	ROM(98) <= X"";	
--	ROM(99) <= X"";


	
	Read_Enable <=  '0' when(CS_L='0' and R_W = '1') else '1';

	
	process (Clock)  
	begin  	
		if(Clock='0') then
			if(Read_Enable = '0') then
			  Data  <= ROM(conv_integer(Addr)); 
		  	else
			  Data <= "ZZZZ";
	      	end if; 
		else Data <= "ZZZZ";
		end if;
	
	end process;

	end ROM_176x4_Arch;
