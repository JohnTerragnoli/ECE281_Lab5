-------------------------------------------------------------------------------
--
-- Title       : Datapath
-- Design      : Datapath
-- Author      : usafa
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : Datapath.vhd
-- Generated   : Fri Mar 30 11:12:38 2007
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
--{entity {Datapath} architecture {Datapath}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.Std_Logic_Arith.all;

entity Datapath is
	port(	 
		 Control_Bus : out std_logic_vector(25 downto 0);
		 IRLd : in STD_LOGIC;
		 MARLoLd : in STD_LOGIC;
		 MARHiLd : in STD_LOGIC;
		 JmpSel : in STD_LOGIC;
		 PCLd : in STD_LOGIC;
		 AddrSel : in STD_LOGIC;
		 AccLd : in STD_LOGIC;
		 EnAccBuffer : in STD_LOGIC;
		 OpSel : in STD_LOGIC_VECTOR(2 downto 0);
		 Addr : out STD_LOGIC_VECTOR(7 downto 0);
		 AeqZero : out STD_LOGIC;
		 AlessZero : out STD_LOGIC;
		 IR : out STD_LOGIC_VECTOR(3 downto 0);
		 Reset_L : in STD_LOGIC;
		 Clock : in STD_LOGIC;
		 Data : inout STD_LOGIC_VECTOR(3 downto 0); 
		 IOSEL_L : in STD_LOGIC;
		 MEMSEL_L : in STD_LOGIC;
		 R_W : in STD_LOGIC
		 );
end Datapath;

--}} End of automatically maintained section

architecture Datapath of Datapath is
	-- Component declaration of the "alu(alu)" unit defined in
	-- file: "./src/ALU.vhd"
	component alu
	port(
		OpSel : in std_logic_vector(2 downto 0);
		Data : in std_logic_vector(3 downto 0);
		Accumulator : in std_logic_vector(3 downto 0);
		Result : out std_logic_vector(3 downto 0));
	end component;
	for all: alu use entity work.alu(alu);

	signal IR_Register, MARHi, MARLo, Accumulator, ALU_Result : std_logic_vector(3 downto 0);
	signal PC : std_logic_vector(7 downto 0);
	signal AeqZero_int, AlessZero_int : std_logic;
		
begin  
	-- Control_Bus saves various program status signals such as PC, IR, MAR, and Acc and makes them externally available --
	Control_Bus(25 downto 18) <= PC;
	Control_Bus(17 downto 14) <= IR_Register;
	Control_Bus(13 downto 10) <= MARHi;
	Control_Bus(9 downto 6) <= MARLo;
	Control_Bus(5 downto 2) <= Accumulator;
	Control_Bus (1) <= AeqZero_int;
	Control_Bus(0) <= AlessZero_int;
	
	-- Instruction Register --
	process(Clock,Reset_L)
  	begin				 
	  if(Reset_L = '0') then
		  	IR_Register <= "0000";
	  elsif (Clock'event and Clock='1') then 
		  if (IRLd = '1') then
		    IR_Register <= Data;   
		  end if;
		end if;		
  	end process;   
	
	-- Set the IR output to the IR_Register signal --
	IR <= IR_Register;
	  	
	-- Memory Address Register (Hi) --
	process(Clock,Reset_L)
  	begin				 
	  if(Reset_L = '0') then
		  	MARHi <= "0000";
	  elsif (Clock'event and Clock='1') then 
		  if (MARHiLd = '1') then
		    MARHi <= Data;   
		  end if;
		end if;		
  	end process;   

	-- Memory Address Register (Lo) --
	process(Clock,Reset_L)
  	begin				 
	  if(Reset_L = '0') then
		  	MARLo <= "0000";
	  elsif (Clock'event and Clock='1') then 
		  if (MARLoLd = '1') then
		    MARLo <= Data;   
		  end if;
		end if;		
  	end process;   
	  	
	-- Program Counter --
	process(Clock,Reset_L)
  	begin				 
	  if(Reset_L = '0') then
		  	PC <= "00000000";
	  elsif (Clock'event and Clock='1') then 
		  if (PCLd = '1' and JmpSel = '1') then
		    PC(7 downto 4) <= MARHi;   
			PC(3 downto 0) <= MARLo;
		  elsif (PCLd = '1' and JmpSel = '0') then
			  PC <= unsigned(PC) + 1;
		  end if;
		end if;		
  	end process;  
	  
	-- Address Bus Multiplexer 
	process(AddrSel,MARHi,MARLo,PC)
	begin
		if AddrSel = '1' then 
			Addr(7 downto 4) <= MARHi;   
			Addr(3 downto 0) <= MARLo; 
		else
			Addr <= PC;
		end if;
	end process;
		
	
	  		
	-- ALU --
	 PRISM_ALU : alu
	port map(
		OpSel => OpSel,
		Data => Data,
		Accumulator => Accumulator,
		Result => ALU_Result
	);
	
	-- Accumulator Register --
	process(Clock,Reset_L)
  	begin				 
	  if(Reset_L = '0') then
		  	Accumulator <= "0000";
	  elsif (Clock'event and Clock='1') then 
		  if (AccLd = '1') then
		    Accumulator <= ALU_Result;   
		  end if;
		end if;		
  	end process;   
	  
	-- Accumulator Buffer - Tri-state Functionality to prevent data bus conflicts --
   	Data <= Accumulator when (EnAccBuffer = '1') else "ZZZZ"; 	 
	  
  	-- Flag Logic --
  	AlessZero_int <= Accumulator(3);   --Uses MSB as a sign bit
  	AeqZero_int <= '1' when(Accumulator = "0000") else
		       '0'; 

	AlessZero <= AlessZero_int;		   
	AeqZero <= AeqZero_int;
	
end Datapath;
