ECE281_Lab5
===========


#Initial PRISM Simulation: 

These files were given initially and were used and modified throughout the lab: 

[Controller_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Controller_Original.vhd)

[Datapath_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Datapath_Original.vhd)

[I/O_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/I_O_Original.vhd)

[Lab5_Testbench_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Lab5_testbench_Original.vhd)

[Lab5_Waveform_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Lab5_waveform_Original.wcfg)

[Memory_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Memory_Original.vhd)

[PRISM_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/PRISM_Original.vhd)

[RAM_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/RAM_16x4_Original.vhd)

[ROM_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/ROM_176x4_Original.vhd)

[Nexys2_top_shell_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Nexys2_top_shell_Original.vhd)

[Clock_Divider_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Clock_Divider_Original.vhd)

[nexys2_sseg_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/nexys2_sseg_Original.vhd)

[nibble_to_sseg_original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/nibble_to_sseg_Original.vhd)

[Pinout_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/pinout_Original.ucf)


Also, the ALU file from lab4 was also used in this project.  This file is shown here: 

[ALU_Lab4](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab4/master/ALU_shell.vhd)


All of the above files were then added to a project together in ISE Project Editor. Once this was done, the Lab5_testbench file was simulated using the Lab5_waveform.wcfg file.  This was supposed to run the following program, shown below: 

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramPic.PNG "Initial Program Description")

The following paragraphs explain in words what the above program is supposed to do.  

This program was supposed to put the value 8 in the accumulator, add one to the accumulator, and output the value in the accumulator, after one was added, with every iteration to output port three.  This continued until the value in the accumulator became positive. 

This is because after the LDAI, which loads the value 8 into the accumulator, command happens, an add 1 to the accumulator happens, and then the OUT command is executed. The ADDI command means that the program adds the immediate value,in this case 1, to whatever is in the accumulator and stores it in the accumulator.  Therefore, the accumulator becomes 9 and the first number to go to the output is 9. 

After this, a JN command is initiated to return to right before the add one command, but only if the accumulator is negative.  Therefore, this program will jump back to step 02 when the accumulator is either 9,A,B,C,D,E, or F.  Negative numbers are numers that are above 8 in binary, because this means that the left most bit will be a '1'.  So the program will count from 9 to F.  When the final repitition is added, the value in the accumulator will roll over to be zero, which is not negative.  F plus 1 is equal to 0.  Because the accumulator is no longer negative, it will skip the command at line 06, and will instead move onto line 09.  The JMP commanded, an unconditional jump, at 09 is an infinite loop on itself, meaning that the output value will not change unless the program is reset.  Then, once the program is reset, the program will start counting again as stated above, starting with outputting 9.  

#Initial Simulation

Screenshots of the simulation can be seen below.  Multiple screenshots were taken so that the entire running of the program could be seen and analyzed. 

##0-35ns
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation01.png "Ititial Program Simulation01")



*Fetch1:* The reset button low, making it active, and IRld and PCld are high, meaning IR and PC can change, making PC and IR zero.  This sets up the zero command in the program, which is just making the PC go onto the next command.  This means at the next rising clock, the PC will change to 01 and the IR will change to whatever command is located on line 01 of the instruction in the decode section.  Moving PC to line 01 is just getting the value that is supposed to go into the accumulator.  

*Decode1:* The command at line 00 is 07, which is LDAI, meaning an immediate value is loaded into the accumulator.  This is considered an Immediate Execute instruction.  An immediate execute means that the program will perform execute at the next clock cycle.  This means that the value 8 should be in the accumulator at 35ns, or the end of the execute time, which it is.  This can happen because the opsel goes to 7, meaning that the ALU is performing a load function from the databus.   

*Execute1:* The value 8 is put into the accumulator.  Accumulator load was high right before this happened, which allowed the accumulator value to change.  Also, the PCld has gone high at 25ns so that it can prepare to move onto the next instruction.  



##35-65ns
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation02.PNG "Inital Program Simulation02")

*Fetch2:*  IRld and PCld are high. This means that the IR is ready to accept a new command and that the Program counter is about to move to the next line in the code.  The PC moves to line 02 at Fetch2.    The opsel changes to 0 but this doesn't matter because the accumulator load is off. 

*Decode2:* Program is now at line 02, meaning that the instruction 06 is put on the databus, preparing to go into the IR on the next rising edge of the clock. This happens at 45ns. Instruction 06 is a ADAI, or an immediate execute.  The program here will add one to whatever is in the accumulator on the next clock cycle.  Also, the PCld is still on and the PC moves to line 03, because that's where the value 1 being added to the accumulator is being temporarily stored.  

*Execute2:* The accumLd is turned on right at 55ns, or the execute. The value of the accumulator can now be changed.  This means at the next clock cycle, 65ns, the value 1 will be added to the accumulator and stored in the accumulator.  This saved value should then be saved as 9, which it is.  





##65-105ns
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation03.PNG "Inital Program Simulation03")

*Fetch3:*  IRld and PCld are high. This means that the IR is ready to accept a new command and that the Program counter is about to move to the next line in the code.  The PC moves to line 04 at Fetch2.    The opsel changes to 0 but this doesn't matter because the accumulator load is off. It prepares to put the command 04 into the IR. 

*Decode3:* 04 is put into the IR.  This instruction is OUT, meaning that the value in the accumulator will be output to a specific port. The PC moves to the 05, since it's load is still active.  

*Decode LoAddr3:* MarLo_ld is turned on, meaning the value on the databus can be stored in MarLo.  This will later serve as the output for the program.  03 is not put into MarLo until 95ns.  

*Execute3:*   The address is changed to 03, where the output will put the accumulator value.  At 105ns, the execute command is finally finished with the value in the accumulator, 9, being sent to output 03.  


##105 - 145ns


![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation04.PNG "Inital Program Simulation04")

*Fetch4:* IRld and PCld are high, meaning that the program is ready to move onto and receive the next instruction.  The program is now on line 06. 

*Decode4:*  The next instruction B, is loaded into the IR at 115ns.  B represents the command JN.  JN means that the program will execute a jump if the accumulator is negative.  The accumulator value is 9 at this point, which is negative.   Therefore the program will execute a jump, so it moves onto the state decode loaddr. The PC moves onto the next line once it figures out just what instruction to put into the IR.  

*Decode LoAddr4:*  Reading from the line 07, this is where the lower loctaion address is stored in the code.  Here the LoAddrLd is active, which prepares to put the value 02, which is on the databus, into MarLo.  On the next rising edge the value 02 will be put into MarLo.  

*Decode HiAddr4:*  Moves to the next line in the PC, to line 08.  This is where the higher location address is stored in the code.  Here the HiAddrLd is active, which prepares to put the value 0, which is on the databus, into MarHi.  On the next rising edge the value 02 will be put into MarLo.  

*Jump Execute4:* At this line, the jmpSel signal goes high.  This means that instead of just counting up one for the PC, the program will jump to the instruction stored in MarHi and MarLo and start working from there.  At this point, the PC does just move up to be 09.  However, at the next rising edge, 155ns, the jump will be executed.  This can be seen in the next screen shot.  



##145 - 175ns

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation05.PNG "Inital Program Simulation05")


*JumpExecute4:*  This is explained in the snapshot above.  It is included for convenience.  

*Fetch1:*  The PCld is high, and the JmpSel just finished being a high value.  Because of this, instead of going to the next instruction, A, the program will jump to whatever value was in the MarLo and MarHi flip-flops.  Therefore, when the Fetch1 command happens at 155ns, the PC jumps to 02!!!!  This means that the program is starting to run from the line 02 all over again, just like before.  That's why this was labeled Fetch1.  This is when the next command for the IR is preparing to go into the IR.  

*Decode1:* Here the PC increments 1, and the IR is filled with the command stored at line 02, which is the 06 value, or the ADDI command.  From here, the program repeats back to the top in the first snapshot of the simulation.  


Going out of chronological order, here are some commands that are also involved in this program that happen later on.  

##945 - 985ns

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation06.PNG "Inital Program Simulation05")

This screenshot is almost the same as the one at 105-145ns.  The only difference is that a jump does not occur here.  

*Fetch6:* IRld and PCld are high, meaning that the program is ready to move onto and receive the next instruction.  The program is now on line 06. 

*Decode6:*  The next instruction B, is loaded into the IR at 115ns.  B represents the command JN.  JN means that the program will execute a jump if the accumulator is negative.  The accumulator value is 0 at this point, because the add one command has already happened.   Zero is a positive number.  Therefore the program will not execute a jump.  However, it just moves onto the state decode loaddr. The PC moves onto the next line once it figures out just what instruction to put into the IR.  

*Decode LoAddr6:*  Reading from the line 07, this is where the lower loctaion address is stored in the code.  Here the LoAddrLd is active, which prepares to put the value 02, which is on the databus, into MarLo.  On the next rising edge the value 02 will be put into MarLo.  

*Decode HiAddr6:*  Moves to the next line in the PC, to line 08.  This is where the higher location address is stored in the code.  Here the HiAddrLd is active, which prepares to put the value 0, which is on the databus, into MarHi.  On the next rising edge the value 02 will be put into MarLo.  

*Jump Execute6:* At this line, the jmpSel signal remains low.  This means that the program will not jump to the location stored in MarHi and MarLo, but instead will just increment the PC by 1, as with the other instructions. It will now move onto the instruction at line 09.   



##985 - 1000ns

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation07.PNG "Inital Program Simulation05")


*Jump Execute6:* At this line, the jmpSel signal remains low.  This means that the program will not jump to the location stored in MarHi and MarLo, but instead will just increment the PC by 1, as with the other instructions. It will now move onto the instruction at line 09.   This is just shown again for convenience.  

*Fetch7:* This is when then next line in the code is begun.  Unfortunately, the simulation ends at this point.  However, if it were to continue, the command at 09 is a jump command, which jumps to line 9 unconditionally.  This would occur indefinietlly, or until the reset button is hit.  If the reset button is hit, then the program will jump to the beginning again.  The reset button was never hit in this simulation.  






#PRISM Program 1 Implementation

The following files were then added to the ISE Project so that the program could be run on the FPGA.  Below are the original files given. 

[Nexys2_top_shell_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Nexys2_top_shell_Original.vhd)

[Clock_Divider_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Clock_Divider_Original.vhd)

[nexys2_sseg_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/nexys2_sseg_Original.vhd)

[nibble_to_sseg_original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/nibble_to_sseg_Original.vhd)

[Pinout_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/pinout_Original.ucf)


To make these files work, the following corrections were made: 

1. A declaration and an instantiation of the PRISM module was created inside the Nexys2_top_shell.vhd file.  
2. Clockbus_Sig(23) as the PRISM clock for the instantiation.  
3. btn(3) was the reset.  Not btn(3) was used instead of just btn(3), because the reset is an active low!!
4. the control bus was commented out in the instantiation. 
5. switch(3 downto 0) was used for Input_0, and switch(7 downto 4) was used as Input_1 in the instantiation.  
6. input ports 2 and 3 set to “0000” (ex. Input_2 => "0000",) in the instantiation.  
7. the following were also set in the instantiation:  Output_0 => nibble3, Output_1 => nibble2, Output_2 => nibble1, Output_3 => nibble0


The final forms of the files used for this implementation is shown below.  The only file shown below is the Nexys2_top_shell, because that was the only file altered from the originals.  


[Nexys2_top_shell_Program1](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Nexys2_top_shell_Program1.vhd)



The implementation for the PRISM Program 1 Simulation can be seen below in video.  This is the program described above being run on an FPGA.  
[Program_1](https://www.youtube.com/watch?v=1jAqDPLEqxA&feature=youtu.be)


This functionality was checked by Dr. Neebel on the lesson that it was due.  



#PRISM Program 2

This next program was created using the PRISM assembly code simulator.  Then the assembly code was altered to VHDL format and used to program a FPGA.  The functionality for both the simulator and the implementation were done on time.  


The purpose of the second program was to write something that would count up or down by one, depending on the input, through the numbers 1 through 100, in decimal.  If the four bit number is negative, then the output would be going down.  In order to write the code for such a program, a flow chart was made and a detailed description of the flow chart was also made.  

The flow chart can be seen below:

The detailed description of the flow chart can be seen below: 

```
	1) Initiate counter and save it in location.  
		a. Load 0 into accumulator 
		b. Sta accumulator value in counter.high 
		c. Sta accumulator value in counter.low location
		
	2) Check direction to go: 
		a. Put input port to accum
		b. Add -8 to the accumulator
		c. If positive, continue in code, to count down
		d. If negative, jump to counting up code and continue. 
		
	3) Counting down(check for decimal values and roll over)
		a. Put counter.low value in accumulator. 
		b. Subtract 1 from the accumulator.  
		c. If negative,(means the counter.low value is 0) (need to change counter.high value and set counter low value to 9) jump to subtract 10 code.
		d. If positive, continue on (just subtract 1).  
		
	4) Subtract 1
		a. STA accumulator in counter.low (the minus one value is already in the accumulator!!!!!)
		b. Unconditionally jump to output.  
		
		
	5) Subtract 10 (need to check for roll over
		a. Put counter.high value in accumulator
		b. Subtract 1 from the accumulator.  (means counter.high and counter.low are both 0)
		c. If negative, jump to rollover low
		d. If positive: (change counter.high -1 and counter.low to zero)(the value of counter.high-1 is already in the accumulator though!!!!)
		e. STA accumulator to counter.high
		f. Load value 9 to accumulator
		g. STA accumulator to counter.low
		h. Unconditionally Jump to output
		
			
	6) Rollover low: 
		a. Put 9 in accumulator
		b. STA accumulator in counter.high
		c. STA accumulator in counter,low
		d. Unconditionally jump to output.  
	
		
	7) Counting up (need to make sure that we stay with decimal values) : 
 
		a. Put stored counter.low  in accumulator
		b. Subtract 9 from the accumulator.  
		c. If negative (least sig digit of counter.low is 8 or less), jump to add one code: 
		d. If not, continue on (make sure to watch for roll over)(the least significant digit must be 9 or more, but it should never get to be more)(make least sig digit 0, and change counter.high.
		e. (check for high digit now:)
		
	8) Check rollover high:
		a. Put 9 in accumulator
		b. Negate accumulator
		c. put stored counter.high in accumulator
		d. If negative, jump to add 10 code (counter.high is 8 or less)
		e. If positive, continue on to roll over high(both digits must be 9 or more): 
		
	9) Rollover high
		a. Load the value 0 into the accumulator
		b. STA accumulator in counter.low and counter.high.  
		c. Unconditionally jump to output.  
		
		
	10) Add 10 code:
		a. Put stored counter.high in accumulator
		b. Add one to accumulator
		c. Save accumulator to counter.high
		d. Store value 0 in counter.low.
		e. Unconditionally Jump to output.  
		
		
		  
		
	11) Add one code (can't roll over in this situation, and high digit won't change)  : 
		a. Put counter.low in accumulator
		b. Add one to the accumulator
		c. Save counter.low value in storage with (STA) command. 
		d. Jump to output code
		
		
		
	12) Output: 
		a. Load counter.low into accumulator
		b.  Output accumulator to output port 2. 
		c. Put counter.high in accumulator
		d. Output accumulator to output port 1.  
		e. Jump unconditionally to step 2 (check direction).  

```

Following the above guidlines, the code for the program was then written in assembly in the PRISM simulator.  This code can be seen below: 


```vhdl
		   00	   7	LDAI	0	Initiate Counter	N	1	N
		   01	   0				Y	0	N
		   02	   D	STA	Counter.low		N	2	N
		   03	   0				Y	0	N
		   04	   B				Y	0	N
		   05	   D	STA	Counter.high		N	2	N
		   06	   1				Y	0	N
		   07	   B				Y	0	N
	Check Direction	   08	   5	IN	0	Check Direction	N	1	N
		   09	   0				Y	0	N
		   0A	   6	ADDI	8	same as adding -8	N	1	N
		   0B	   8				Y	0	N
		   0C	   B	JN	Counting Up	jump to counting up	N	2	N
		   0D	   0				Y	0	N
		   0E	   4				Y	0	N
		   0F	   F	LDAD	Counter.low		N	2	Y
		   10	   0				Y	0	N
		   11	   B				Y	0	N
		   12	   A	JZ	Subtract 10	jump to subract 10	N	2	Y
		   13	   2				Y	0	N
		   14	   2				Y	0	N
		   15	   6	ADDI	F		N	1	N
		   16	   F				Y	0	N
		   17	   D	STA	Counter.low	Start Subtract 1	N	2	Y
		   18	   0				Y	0	N
		   19	   B				Y	0	N
		   1A	   9	JMP	OUTPUT	Jump To OUTPUT	N	2	Y
		   1B	   0				Y	0	N
		   1C	   8				Y	0	N
		   1D	   6	ADDI	9		N	1	N
		   1E	   9				Y	0	N
		   1F	   D	STA	Counter.low		N	2	N
		   20	   0				Y	0	N
		   21	   B				Y	0	N
	Subtract 10	   22	   F	LDAD	Counter.high	Start Subtract 10	N	2	Y
		   23	   1				Y	0	N
		   24	   B				Y	0	N
		   25	   A	JZ	Rollover Low	Jump to Rollover Low	N	2	Y
		   26	   5				Y	0	N
		   27	   3				Y	0	N
		   28	   6	ADDI	F		N	1	N
		   29	   F				Y	0	N
		   2A	   D	STA	Counter.high		N	2	Y
		   2B	   1				Y	0	N
		   2C	   B				Y	0	N
		   2D	   7	LDAI	9		N	1	Y
		   2E	   9				Y	0	N
		   2F	   D	STA	Counter.low		N	2	Y
		   30	   0				Y	0	N
		   31	   B				Y	0	N
		   32	   9	JMP	OUTPUT	Jmp to OUTPUT	N	2	Y
		   33	   0				Y	0	N
		   34	   8				Y	0	N
	Rollover Low	   35	   7	LDAI	9	Start Rollover low	N	1	Y
		   36	   9				Y	0	N
		   37	   D	STA	Counter.high		N	2	Y
		   38	   1				Y	0	N
		   39	   B				Y	0	N
		   3A	   D	STA	Counter.low		N	2	Y
		   3B	   0				Y	0	N
		   3C	   B				Y	0	N
		   3D	   9	JMP	OUTPUT	Jmp to OUTPUT	N	2	Y
		   3E	   0				Y	0	N
		   3F	   8				Y	0	N
	Counting Up	   40	   F	LDAD	Counter.low	Start Counting up	N	2	Y
		   41	   0				Y	0	N
		   42	   B				Y	0	N
		   43	   6	ADDI	8		N	1	Y
		   44	   8				Y	0	N
		   45	   A	JZ	Add 1		N	2	Y
		   46	   8				Y	0	N
		   47	   7				Y	0	N
		   48	   B	JN	Add 1	Jump to Add 1	N	2	Y
		   49	   8				Y	0	N
		   4A	   7				Y	0	N
		   4B	   0	NOP			N	0	N
		   4C	   0	NOP			N	0	N
		   4D	   F	LDAD	Counter.high	Start check rollover high	N	2	Y
		   4E	   1				Y	0	N
		   4F	   B				Y	0	N
		   50	   6	ADDI	8		N	1	Y
		   51	   8				Y	0	N
		   52	   A	JZ	Add 10		N	2	Y
		   53	   8				Y	0	N
		   54	   6				Y	0	N
		   55	   B	JN	Add 10	Jmp to Add 10 code	N	2	Y
		   56	   8				Y	0	N
		   57	   6				Y	0	N
		   58	   7	LDAI	0	Start rollover high	N	1	Y
		   59	   0				Y	0	N
		   5A	   D	STA	Counter.high		N	2	Y
		   5B	   1				Y	0	N
		   5C	   B				Y	0	N
		   5D	   D	STA	Counter.low		N	2	Y
		   5E	   0				Y	0	N
		   5F	   B				Y	0	N
		   60	   9	JMP	OUTPUT	Jmp To OUTPUT	N	2	Y
		   61	   0				Y	0	N
		   62	   8				Y	0	N
		   63	   6	ADDI	0		N	1	N
		   64	   0				Y	0	N
		   65	   D	STA	Counter.low		N	2	N
		   66	   0				Y	0	N
		   67	   B				Y	0	N
	Add 10	   68	   F	LDAD	Counter.high	Start add 10	N	2	Y
		   69	   1				Y	0	N
		   6A	   B				Y	0	N
		   6B	   6	ADDI	1		N	1	Y
		   6C	   1				Y	0	N
		   6D	   D	STA	Counter.high		N	2	Y
		   6E	   1				Y	0	N
		   6F	   B				Y	0	N
		   70	   7	LDAI	0		N	1	Y
		   71	   0				Y	0	N
		   72	   D	STA	Counter.low		N	2	Y
		   73	   0				Y	0	N
		   74	   B				Y	0	N
		   75	   9	JMP	OUTPUT	Jmp to OUTPUT	N	2	Y
		   76	   0				Y	0	N
		   77	   8				Y	0	N
	Add 1	   78	   F	LDAD	Counter.low	Start Add 1	N	2	Y
		   79	   0				Y	0	N
		   7A	   B				Y	0	N
		   7B	   6	ADDI	1		N	1	Y
		   7C	   1				Y	0	N
		   7D	   D	STA	Counter.low		N	2	Y
		   7E	   0				Y	0	N
		   7F	   B				Y	0	N
	OUTPUT	   80	   F	LDAD	Counter.low	Start OUTPUT	N	2	Y
		   81	   0				Y	0	N
		   82	   B				Y	0	N
		   83	   4	OUT	3		N	1	Y
		   84	   3				Y	0	N
		   85	   F	LDAD	Counter.high		N	2	Y
		   86	   1				Y	0	N
		   87	   B				Y	0	N
		   88	   4	OUT	2		N	1	Y
		   89	   2				Y	0	N
		   8A	   9	JMP	Check Direction	JMP to check direction	N	2	Y
		   8B	   8				Y	0	N
		   8C	   0				Y	0	N
		   8D	   0	NOP			N	0	Y
		   8E	   0	NOP			N	0	Y
		   8F	   0	NOP			N	0	Y
		   90	   0	NOP			N	0	Y
		   91	   0	NOP			N	0	Y
		   92	   0	NOP			N	0	Y
		   93	   0	NOP			N	0	Y
		   94	   0	NOP			N	0	Y
		   95	   0	NOP			N	0	Y
		   96	   0	NOP			N	0	Y
		   97	   0	NOP			N	0	Y
		   98	   0	NOP			N	0	Y
		   99	   0	NOP			N	0	Y
		   9A	   0	NOP			N	0	Y
		   9B	   0	NOP			N	0	Y
		   9C	   0	NOP			N	0	Y
		   9D	   0	NOP			N	0	Y
		   9E	   0	NOP			N	0	Y
		   9F	   0	NOP			N	0	Y
		   A0	   0	NOP			N	0	Y
		   A1	   0	NOP			N	0	Y
		   A2	   0	NOP			N	0	Y
		   A3	   0	NOP			N	0	Y
		   A4	   0	NOP			N	0	Y
		   A5	   0	NOP			N	0	Y
		   A6	   0	NOP			N	0	Y
		   A7	   0	NOP			N	0	Y
		   A8	   0	NOP			N	0	Y
		   A9	   0	NOP			N	0	Y
		   AA	   0	NOP			N	0	Y
		   AB	   0	NOP			N	0	Y
		   AC	   0	NOP			N	0	Y
		   AD	   0	NOP			N	0	Y
		   AE	   0	NOP			N	0	Y
		   AF	   0	NOP			N	0	N
	Counter.low	   B0	   5	
	Counter.high	   B1	   1	
```

