----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: C3C John Terragnoli
-- 
-- Create Date:    12:12 23 Apr 2014 
-- Module Name:    Nexys2_Lab3top - Behavioral 
-- Target Devices: Nexys2 Project Board
-- Tool versions: 1.0
-- Description: This file is a shell for implementing designs on a NEXYS 2 board
--
----------------------------------------------------------------------------------
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

ROM(0) <= X"7";
ROM(1) <= X"0";
ROM(2) <= X"D";
ROM(3) <= X"0";
ROM(4) <= X"B";
ROM(5) <= X"D";
ROM(6) <= X"1";
ROM(7) <= X"B";
ROM(8) <= X"5";
ROM(9) <= X"0";
ROM(10) <= X"6";
ROM(11) <= X"8";
ROM(12) <= X"B";
ROM(13) <= X"0";
ROM(14) <= X"4";
ROM(15) <= X"F";
ROM(16) <= X"0";
ROM(17) <= X"B";
ROM(18) <= X"A";
ROM(19) <= X"2";
ROM(20) <= X"2";
ROM(21) <= X"6";
ROM(22) <= X"F";
ROM(23) <= X"D";
ROM(24) <= X"0";
ROM(25) <= X"B";
ROM(26) <= X"9";
ROM(27) <= X"0";
ROM(28) <= X"8";
ROM(29) <= X"6";
ROM(30) <= X"9";
ROM(31) <= X"D";
ROM(32) <= X"0";
ROM(33) <= X"B";
ROM(34) <= X"F";
ROM(35) <= X"1";
ROM(36) <= X"B";
ROM(37) <= X"A";
ROM(38) <= X"5";
ROM(39) <= X"3";
ROM(40) <= X"6";
ROM(41) <= X"F";
ROM(42) <= X"D";
ROM(43) <= X"1";
ROM(44) <= X"B";
ROM(45) <= X"7";
ROM(46) <= X"9";
ROM(47) <= X"D";
ROM(48) <= X"0";
ROM(49) <= X"B";
ROM(50) <= X"9";
ROM(51) <= X"0";
ROM(52) <= X"8";
ROM(53) <= X"7";
ROM(54) <= X"9";
ROM(55) <= X"D";
ROM(56) <= X"1";
ROM(57) <= X"B";
ROM(58) <= X"D";
ROM(59) <= X"0";
ROM(60) <= X"B";
ROM(61) <= X"9";
ROM(62) <= X"0";
ROM(63) <= X"8";
ROM(64) <= X"F";
ROM(65) <= X"0";
ROM(66) <= X"B";
ROM(67) <= X"6";
ROM(68) <= X"8";
ROM(69) <= X"A";
ROM(70) <= X"8";
ROM(71) <= X"7";
ROM(72) <= X"B";
ROM(73) <= X"8";
ROM(74) <= X"7";
ROM(75) <= X"0";
ROM(76) <= X"0";
ROM(77) <= X"F";
ROM(78) <= X"1";
ROM(79) <= X"B";
ROM(80) <= X"6";
ROM(81) <= X"8";
ROM(82) <= X"A";
ROM(83) <= X"8";
ROM(84) <= X"6";
ROM(85) <= X"B";
ROM(86) <= X"8";
ROM(87) <= X"6";
ROM(88) <= X"7";
ROM(89) <= X"0";
ROM(90) <= X"D";
ROM(91) <= X"1";
ROM(92) <= X"B";
ROM(93) <= X"D";
ROM(94) <= X"0";
ROM(95) <= X"B";
ROM(96) <= X"9";
ROM(97) <= X"0";
ROM(98) <= X"8";
ROM(99) <= X"6";
ROM(100) <= X"0";
ROM(101) <= X"D";
ROM(102) <= X"0";
ROM(103) <= X"B";
ROM(104) <= X"F";
ROM(105) <= X"1";
ROM(106) <= X"B";
ROM(107) <= X"6";
ROM(108) <= X"1";
ROM(109) <= X"D";
ROM(110) <= X"1";
ROM(111) <= X"B";
ROM(112) <= X"7";
ROM(113) <= X"0";
ROM(114) <= X"D";
ROM(115) <= X"0";
ROM(116) <= X"B";
ROM(117) <= X"9";
ROM(118) <= X"0";
ROM(119) <= X"8";
ROM(120) <= X"F";
ROM(121) <= X"0";
ROM(122) <= X"B";
ROM(123) <= X"6";
ROM(124) <= X"1";
ROM(125) <= X"D";
ROM(126) <= X"0";
ROM(127) <= X"B";
ROM(128) <= X"F";
ROM(129) <= X"0";
ROM(130) <= X"B";
ROM(131) <= X"4";
ROM(132) <= X"2";
ROM(133) <= X"F";
ROM(134) <= X"1";
ROM(135) <= X"B";
ROM(136) <= X"4";
ROM(137) <= X"1";
ROM(138) <= X"9";
ROM(139) <= X"8";
ROM(140) <= X"0";
ROM(141) <= X"0";
ROM(142) <= X"0";
ROM(143) <= X"0";
ROM(144) <= X"0";
ROM(145) <= X"0";
ROM(146) <= X"0";
ROM(147) <= X"0";
ROM(148) <= X"0";
ROM(149) <= X"0";
ROM(150) <= X"0";
ROM(151) <= X"0";
ROM(152) <= X"0";
ROM(153) <= X"0";
ROM(154) <= X"0";
ROM(155) <= X"0";
ROM(156) <= X"0";
ROM(157) <= X"0";
ROM(158) <= X"0";
ROM(159) <= X"0";
ROM(160) <= X"0";
ROM(161) <= X"0";
ROM(162) <= X"0";
ROM(163) <= X"0";
ROM(164) <= X"0";
ROM(165) <= X"0";
ROM(166) <= X"0";
ROM(167) <= X"0";
ROM(168) <= X"0";
ROM(169) <= X"0";
ROM(170) <= X"0";
ROM(171) <= X"0";
ROM(172) <= X"0";
ROM(173) <= X"0";
ROM(174) <= X"0";
ROM(175) <= X"0";
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
