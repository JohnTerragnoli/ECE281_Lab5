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

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Memory is
	port( Clock : in std_logic;
		 MemSEL_L : in STD_LOGIC;
		 R_W : in STD_LOGIC;
		 Addr : in STD_LOGIC_VECTOR(7 downto 0);
		 Data : inout STD_LOGIC_VECTOR(3 downto 0)
	     );
end Memory;

--}} End of automatically maintained section

architecture Memory of Memory is

	 	-- Component declaration of the "rom_176x4(rom_176x4_arch)" unit defined in
	-- file: "./src/ROM_176x4.vhd"
	component rom_176x4
	port(Clock : in std_logic;
		CS_L : in std_logic;
		R_W : in std_logic;
		Addr : in std_logic_vector(7 downto 0);
		Data : out std_logic_vector(3 downto 0));
	end component;
	for all: rom_176x4 use entity work.rom_176x4(rom_176x4_arch);
	
	-- Component declaration of the "ram_16x4(ram_16x4_arch)" unit defined in
	-- file: "./src/RAM_16x4.vhd"
	component ram_16x4
	port(Clock : in std_logic;
		CS_L : in std_logic;
		R_W : in std_logic;
		Addr : in std_logic_vector(3 downto 0);
		Data : inout std_logic_vector(3 downto 0));
	end component;
	for all: ram_16x4 use entity work.ram_16x4(ram_16x4_arch);

signal ROM_SEL, RAM1_SEL, RAM2_SEL, RAM3_SEL, RAM4_SEL, RAM5_SEL : std_logic;

begin
	
	-- Decode Addresses --
	
	ROM_SEL <= '0' when ((Addr <= "10101111") and (MemSel_l = '0')) else '1';
	RAM1_SEL <= '0' when ((Addr(7 downto 4) = X"B") and (MemSel_l = '0')) else '1';
	RAM2_SEL <= '0' when ((Addr(7 downto 4) = X"C") and (MemSel_l = '0')) else '1';
	RAM3_SEL <= '0' when ((Addr(7 downto 4) = X"D") and (MemSel_l = '0')) else '1';
	RAM4_SEL <= '0' when ((Addr(7 downto 4) = X"E") and (MemSel_l = '0')) else '1';
	RAM5_SEL <= '0' when ((Addr(7 downto 4) = X"F") and (MemSel_l = '0')) else '1';
	
	
	Program_ROM : rom_176x4
	port map(Clock => Clock,
		CS_L => ROM_SEL,
		R_W => R_W,
		Addr => Addr,
		Data => Data
	);		
	
	RAM1 : ram_16x4
	port map(  Clock => Clock,
		CS_L => RAM1_SEL,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data
	);	
	
	RAM2 : ram_16x4
	port map(Clock => Clock,
		CS_L => RAM2_SEL,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data
	);	
	
	RAM3 : ram_16x4
	port map(Clock => Clock,
		CS_L => RAM3_SEL,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data
	);	
	
	RAM4 : ram_16x4
	port map(Clock => Clock,
		CS_L => RAM4_SEL,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data
	);	
	
	RAM5 : ram_16x4
	port map(Clock => Clock,
		CS_L => RAM5_SEL,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data
	);
	

	
end Memory;