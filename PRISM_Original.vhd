-------------------------------------------------------------------------------
--
-- Title       : PRISM
-- Design      : PRISM
-- Author      : usafa
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : PRISM.vhd
-- Generated   : Fri Mar 30 13:10:35 2007
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
--{entity {PRISM} architecture {PRISM}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PRISM is
	 port(
		 Clock : in STD_LOGIC;
		 Reset_L : in STD_LOGIC; 
		 Control_Bus : out std_logic_vector(25 downto 0);
		 Input_0 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_1 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_2 : in STD_LOGIC_VECTOR(3 downto 0);
		 Input_3 : in STD_LOGIC_VECTOR(3 downto 0);
		 Output_0 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_1 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_2 : out STD_LOGIC_VECTOR(3 downto 0);
		 Output_3 : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end PRISM;

--}} End of automatically maintained section

architecture PRISM of PRISM is

signal AeqZero, AlessZero, IRLd, MARLoLd, MARHiLd, JmpSel, PCLd, AddrSel, AccLd, EnAccBuffer, R_W, MemSel_L, IOSel_L  : std_logic;
signal IR : std_logic_vector(3 downto 0);
signal OpSel : std_logic_vector(2 downto 0);
signal Data : std_logic_vector(3 downto 0);
signal Addr : std_logic_vector(7 downto 0);

	-- Component declaration of the "controller(controller)" unit defined in
	-- file: "./src/controller.vhd"
	component controller
	port(
		Clock : in std_logic;
		Reset_L : in std_logic;
		AeqZero : in std_logic;
		AlessZero : in std_logic;
		IR : in std_logic_vector(3 downto 0);
		IRLd : out std_logic;
		MARLoLd : out std_logic;
		MARHiLd : out std_logic;
		JmpSel : out std_logic;
		PCLd : out std_logic;
		AddrSel : out std_logic;
		AccLd : out std_logic;
		EnAccBuffer : out std_logic;
		R_W : out std_logic;
		MemSel_L : out std_logic;
		IOSel_L : out std_logic;
		OpSel : out std_logic_vector(2 downto 0));
	end component;
	for all: controller use entity work.controller(controller);

	-- Component declaration of the "datapath(datapath)" unit defined in
	-- file: "./src/datapath.vhd"
	component datapath
	port(
		Control_Bus : out std_logic_vector(25 downto 0);
		IRLd : in std_logic;
		MARLoLd : in std_logic;
		MARHiLd : in std_logic;
		JmpSel : in std_logic;
		PCLd : in std_logic;
		AddrSel : in std_logic;
		AccLd : in std_logic;
		EnAccBuffer : in std_logic;
		OpSel : in std_logic_vector(2 downto 0);
		Addr : out std_logic_vector(7 downto 0);
		AeqZero : out std_logic;
		AlessZero : out std_logic;
		IR : out std_logic_vector(3 downto 0);
		Reset_L : in std_logic;
		Clock : in std_logic;
		Data : inout std_logic_vector(3 downto 0);
		IOSEL_L : in std_logic;
		MEMSEL_L : in std_logic;
		R_W : in std_logic);
	end component;
	for all: datapath use entity work.datapath(datapath);


	-- Component declaration of the "memory(memory)" unit defined in
	-- file: "./src/Memory.vhd"
	component memory
	port(  Clock : in std_logic;
		MemSEL_L : in std_logic;
		R_W : in std_logic;
		Addr : in std_logic_vector(7 downto 0);
		Data : inout std_logic_vector(3 downto 0));
	end component;
	for all: memory use entity work.memory(memory);
		
	-- Component declaration of the "io(io)" unit defined in
	-- file: "./src/I_O.vhd"
	component io
	port(
		Clock : in std_logic;
		IOSEL_L : in std_logic;
		R_W : in std_logic;
		Addr : in std_logic_vector(3 downto 0);
		Data : inout std_logic_vector(3 downto 0);
		Input_0 : in std_logic_vector(3 downto 0);
		Input_1 : in std_logic_vector(3 downto 0);
		Input_2 : in std_logic_vector(3 downto 0);
		Input_3 : in std_logic_vector(3 downto 0);
		Output_0 : out std_logic_vector(3 downto 0);
		Output_1 : out std_logic_vector(3 downto 0);
		Output_2 : out std_logic_vector(3 downto 0);
		Output_3 : out std_logic_vector(3 downto 0));
	end component;
	for all: io use entity work.io(io);

begin	 
	PRISM_Ctlr : controller
	port map(
		Clock => Clock,
		Reset_L => Reset_L,
		AeqZero => AeqZero,
		AlessZero => AlessZero,
		IR => IR,
		IRLd => IRLd,
		MARLoLd => MARLoLd,
		MARHiLd => MARHiLd,
		JmpSel => JmpSel,
		PCLd => PCLd,
		AddrSel => AddrSel,
		AccLd => AccLd,
		EnAccBuffer => EnAccBuffer,
		R_W => R_W,
		MemSel_L => MemSel_L,
		IOSel_L => IOSel_L,
		OpSel => OpSel
	);
	
 PRISM_Datapath : datapath
 port map( 	   
 		Control_Bus => Control_Bus,
		IRLd => IRLd,
		MARLoLd => MARLoLd,
		MARHiLd => MARHiLd,
		JmpSel => JmpSel,
		PCLd => PCLd,
		AddrSel => AddrSel,
		AccLd => AccLd,
		EnAccBuffer => EnAccBuffer,
		OpSel => OpSel,
		Addr => Addr,
		AeqZero => AeqZero,
		AlessZero => AlessZero,
		IR => IR,
		Reset_L => Reset_L,
		Clock => Clock,
		Data => Data,
		IOSEL_L => IOSEL_L,
		MEMSEL_L => MEMSEL_L,
		R_W => R_W
	);  
	
	PRISM_Memory : memory
	port map(	Clock => Clock,
		MemSEL_L => MemSEL_L,
		R_W => R_W,
		Addr => Addr,
		Data => Data
	);

	PRISM_IO: io
	port map(
		Clock => Clock,
		IOSEL_L => IOSEL_L,
		R_W => R_W,
		Addr => Addr(3 downto 0),
		Data => Data,
		Input_0 => Input_0,
		Input_1 => Input_1,
		Input_2 => Input_2,
		Input_3 => Input_3,
		Output_0 => Output_0,
		Output_1 => Output_1,
		Output_2 => Output_2,
		Output_3 => Output_3
	);
end PRISM;
