-------------------------------------------------------------------------------
--
-- Title       : Controller
-- Design      : Controller
-- Author      : usafa
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : Controller.vhd
-- Generated   : Wed Mar 28 13:08:04 2007
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
--{entity {Controller} architecture {Controller}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Controller is
	 port(
	 	 Clock : in STD_LOGIC;	
	 	 Reset_L : in STD_LOGIC;
		 AeqZero : in STD_LOGIC;
		 AlessZero : in STD_LOGIC;
		 IR : in std_logic_vector(3 downto 0);
		 IRLd : out STD_LOGIC;	 
		 MARLoLd : out STD_LOGIC;
		 MARHiLd : out STD_LOGIC;
		 JmpSel : out STD_LOGIC;
		 PCLd : out STD_LOGIC;
		 AddrSel : out STD_LOGIC;
		 AccLd : out STD_LOGIC;
		 EnAccBuffer : out STD_LOGIC;
		 R_W : out STD_LOGIC;
		 MemSel_L : out STD_LOGIC;
		 IOSel_L : out STD_LOGIC;
		 OpSel : out STD_LOGIC_VECTOR(2 downto 0)
	     );
end Controller;

--}} End of automatically maintained section

architecture Controller of Controller is   
type Controller_State is (Fetch, Decode, DecodeLoAddr, DecodeHiAddr, Inherent_Execute, Immediate_Execute, 
						  Direct_IO_Execute, Direct_Memory_Execute, Jump_Execute); 
		  						   
signal S_Current, S_Next : Controller_State;						   

begin
process(CLOCK, Reset_L)
begin
	if(Reset_L = '0') then
		S_Current <= Fetch;
	elsif(Clock'event and Clock = '1') then
		S_Current <= S_Next;
	end if;
end process;		

process(IR,AeqZero,AlessZero,S_Current)
begin
	case S_Current is
		when Fetch => 	S_Next <= Decode;	 
						IRLd <= '1';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '1';
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '0';
						IOSel_L <= '1';
						OpSel <= "000";	

		when Decode => 	case IR is
							when "0000" => S_Next <= Fetch;										-- NOP
							when "0001" | "0010" | "0011"	=> S_Next <= Inherent_Execute;		-- NEG, NOT, RAR
							when "0110" | "0111"	=> S_Next <= Immediate_Execute;	 			-- ADDI, LDAI
							when others => S_Next <= DecodeLoAddr;
						end case;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '0';
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '1';
						IOSel_L <= '1';
						OpSel <= "000";	
						
		when DecodeLoAddr => case IR is
							when "0100" | "0101" => S_Next <= Direct_IO_Execute;						-- IN, Out
							when others => S_Next <= DecodeHiAddr;
						end case;	
						IRLd <= '0';
						MarLoLd <= '1';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '1';
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '0';
						IOSel_L <= '1';
						OpSel <= "000";	
						
		when DecodeHiAddr =>case IR is
								when "1000" | "1100" | "1101" | "1110" | "1111" => S_Next <= Direct_Memory_Execute;  -- AND, OR, ADDD, LDAD, STAA
								when "1001" | "1010" | "1011"	=> S_Next <= Jump_Execute;			 -- Jmp, JZ, JN
								when others => S_Next <= DecodeLoAddr;
							end case;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '1';
						JmpSel  <= '0';
						PCLd  <= '1';
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '0';
						IOSel_L <= '1';
						OpSel <= "000";		

		when Inherent_Execute => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '0';
						AddrSel <= '0';
						AccLd <= '1';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '1';
						IOSel_L <= '1';
						OpSel <= IR(2 downto 0);	
						
		when Immediate_Execute => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '1';
						AddrSel <= '0';
						AccLd <= '1';
						EnAccBuffer  <= '0';
						R_W  <= '1';  
						MemSel_L <= '0';
--						if(IR = "0101" or IR = "0111" or IR = "0110" or IR = "1100" or IR  = "1000") then  			-- IN
--							MemSel_L <= '0';
--						else							-- OUT
--							MemSel_L <= '1';
--						end if;
						
						IOSel_L <= '1';
						OpSel <= IR(2 downto 0);	
						
		when Direct_IO_Execute => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '0';
						AddrSel <= '1';
						if(IR = "0101") then  			-- IN
							AccLd <= '1';
							EnAccBuffer  <= '0';
							R_W  <= '1';
						else							-- OUT
							AccLd <= '0';
							EnAccBuffer  <= '1';
							R_W  <= '0';
						end if;
						MemSel_L <= '1';
						IOSel_L <= '0';
						OpSel <= IR(2 downto 0);	
						
		when Direct_Memory_Execute => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '0';
						if(IR = "1101") then  			-- STA
							AccLd <= '0';
							EnAccBuffer  <= '1';
							R_W  <= '0';
						else							
							AccLd <= '1';
							EnAccBuffer  <= '0';
							R_W  <= '1';
						end if;		  
						MemSel_L <= '0';
--						if(IR = "1101" or IR = "1111" or IR = "1000" or IR = "1100") then
--							MemSel_L <= '0';
--						else
--							MemSel_L <= '1';
--						end if;
						AddrSel <= '1';
						IOSel_L <= '1';
						OpSel <= IR(2 downto 0);	
						
		when Jump_Execute => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						if((IR = "1001") or (IR = "1010" and AeqZero = '1') or (IR = "1011" and AlessZero = '1')) then
							PCLd  <= '1'; JmpSel <= '1';
						else PCLd <= '0'; JmpSel <= '0'; end if;
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '1';
						IOSel_L <= '1';
						OpSel <= "000";	
						
		when others => 	S_Next <= Fetch;
						IRLd <= '0';
						MarLoLd <= '0';
						MarHiLd <= '0';
						JmpSel  <= '0';
						PCLd  <= '0';
						AddrSel <= '0';
						AccLd <= '0';
						EnAccBuffer  <= '0';
						R_W  <= '1';
						MemSel_L <= '1';
						IOSel_L <= '1';
						OpSel <= "000";							
						
																																				
	
	
	end case;
end process;
						
end Controller;
