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

*Execute3:*   (Direction IO Execute) The address is changed to 03, where the output will put the accumulator value.  At 105ns, the execute command is finally finished with the value in the accumulator, 9, being sent to output 03.  


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


This functionality was checked by Dr. Neebel on the lesson that it was due.  The bit file for Program 1 can be seen on the home page of this repository labeled as nexys2_top_shell_Program_1.bit




#PRISM Program 2

This next program was created using the PRISM assembly code simulator.  Then the assembly code was altered to VHDL format and used to program a FPGA.  The functionality for both the simulator and the implementation were done on time.  


The purpose of the second program was to write something that would count up or down by one, depending on the input, through the numbers 1 through 100, in decimal.  If the four bit number is negative, then the output would be going down.  In order to write the code for such a program, a flow chart was made and a detailed description of the flow chart was also made.  

The flow chart can be seen below:

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Program_2_Flowchart.jpg "Inital Program Simulation05")

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

Following the above guidlines, the code for the program was then written in assembly in the PRISM simulator.  This code can be seen here: [PRISM_Program2](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/PRISM_Program_2.psm)

The code for this program is simply too long to copy and paste.  

This program was then simulated in the PRISM simulator, and it worked perfect.  Captain Silva checked the simulation functionality before the end of class on the day that it was due.  



#Program 2 on FPGA

The assembly code was then translated into VHDL code and implemented on the FPGA.  This was done using a simple export button on the PRISM simulator.  This button saved all of the assembly code as a ROM file.  

So then, to implement this design on the FPGA board, this newly created ROM file needed to replace the ROM file used previously in Program 1.  Once this was done, the file Nexys2_top_shell.vhd was then used to create a programing file, and this file was then uploaded to the FPGA.  The program also worked on the FPGA, just like the simulation.  Captain Silva checked this implementation before it was due, and it did in fact work correctly.  

The only file that was changed in ISE editor was the ROM file and the clockbus_sig.  The ROM file originally given was replaced with the ROM file created by the PRISM simulator.  This file can be seen here:  [Program_2_ROM](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Program_2_ROM.vhd).  Also, for somereason, the clockbus_sig used in Program 1 made Program 2 run really slowly, so clockbus_sig(19) was used instead for Program 2.  

The bit file for this program can be seen on the main page of this repository labeled as nexys2_top_shell_Program_2.bit.  


#Extra Program

For A functionality, another program had to be created.  The designs were not specified. 

The extra program ended up being a nested for loop.  The inside and outside loop could be as big as one hex digit. The flowchart for the design can be seen below:

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Program_3_Flowchart.jpg "Program 3 Flowchart")

NOTE: THERE SHOULD BE AN UNCONDITIONAL ARROW GOING FROM THE OUTPUT TO THE "CHECK OUTSIDE FIRST" BOX.  

The following text was written while this flowchart and program were being written.  It goes into deep detail of how this program actually runs in assembly.  This text can be seen below: 

```
A nested for loop: 
	1) Make a space for inside and outside loop counter.  
		a. Inside and outside loops can only be 1 hex digit.  
		b. Make places for value of each counter.  
	2) Then Check Inside Counter
		a. Input(1) into accumulator
		b. Negate accumulator
		c. Add inside counter into accumulator
		d. If accumulator  = 0, then the inside counter has reached limit. Jump to Check Outside counter.  
		e. If not, add one to the inside counter (just continue on)
	3) Add 1 Inside.    
		a. Load inside into accum. 
		b. Add 1 to the accumulator.  
		c. STA accum to inside counter.  
		d. Unconditionally Jump to OUTPUT.  
	
	4) Check Outside Counter. 
		a. Input(0) into the accumulator
		b. Negate accumulator
		c. Add outside counter into accumulator
		d. If accumulator = 0, then outside counter has reached it's limit.  Jump to reset display
		e. If not, keep going to add one to outside counter. 
	5) Add 1 Outside
		a. Need to reset the inside counter: 
		b. Load 0 into accum
		c. STA accum to inside counter. 
		d. Load outside into accum
		e. Add 1 to accum
		f. STA accum to outside counter. 
		g. Unconditionally jump to OUTPUT 
	
	6) Reset display: (THOUGH ABOUT USING THIS, THEN IT WAS REMOVED FROM THE PROGRAM AND REPLACED WITH THE END) (wanted to keep the last counting on the screen) 
		a. 0 into the accumulator
		b. STA accum into inside counter.
		c. STA accum into outside counter.  
		d. Unconditionally jump to output.  
	7) END: 
		a. Unconditionally jumps to itself until program is reset.  
		
	8) Output: 
		a. Add 1 to the outside counter.  Outside counter will only be up to 7.  do this after the values are output to the screen.  
		b. 

```

Then, after both the flowchart and the text were written, the program was put into the PRISM simulator.  The .psm file for the simulator is shown here:  [PRISM_Program_3](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/PRISM_Program_3.psm)

Video's of the testcases can be seen here: 

1. [Testcase_1](https://www.youtube.com/watch?v=8gfJIKIzX_8&feature=youtu.be)

2. [Testcase_2](https://www.youtube.com/watch?v=Jqy8OjA9FGI&feature=youtu.be)
 
3. [Testcase_3](https://www.youtube.com/watch?v=RO-Kuq7-32Q&feature=youtu.be)

4. [Testcase_4](https://www.youtube.com/watch?v=HtVqmm0KloI&feature=youtu.be)


NOTE: In order to watch these videos, the resolution must be set to HD, otherwise the numbers on the screen cannot be seen.  


After this was done, the same program was implemented on an FPGA.  To do this, the PRISM simulator was used to convert the ROM file from .psm to .vhd.  Then, this code was used to replace the ROM code used by the Nexys2_top_shell file.  Once this was done, a .bit file for the program was created and uploaded to the FPGA.  

The altered ROM file can be seen here: [Program3_ROM](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Program%203%20ROM.vhd)

The implementation tests for Program 3 on the Nexys2 can be seen in these videos: 


1. [Testcase_1](https://www.youtube.com/watch?v=TIvtJ72H1oQ&feature=youtu.be)

2. [Testcase_2](https://www.youtube.com/watch?v=o8MJEw4mgHU&feature=youtu.be)
 
3. [Testcase_3](https://www.youtube.com/watch?v=pe7gIO0H5CQ&feature=youtu.be)

4. [Testcase_4](https://www.youtube.com/watch?v=B8DHs8cY-Dk&feature=youtu.be)


Again, for the best viewing experience, please turn on HD mode when watching the video :) 

The bit file for this program can be seen on the main repository page, labeled nexys2_top_shell_program_3.bit.  






#**Questions:**


*1. When the controller's current state is “FETCH,” what is the status of the following control lines:*

PCLd - HIGH

IRLd - HIGH

ACCLd - LOW

*2. The current state is Decode LoAddr and the IR contains “OUT.”  What are the control signals are asserted, and* what will the next state be?
 
Control signals asserted: MarLoLd, PCLd, r_w (write), memSel_l(active low), and alesszero_int.  
Next state = Direct IO Execute



*3. What are the three status signals sent from the PRISM datapath to the PRISM controller?*

IR, aeqzero_int, and alesszero_int.  

*4. Why is it important that ACCLd signal be active during the execute state for the ADDI instruction?*

So that the accumulator can actually be altered.  If the accumulator cannot be altered, then the ADDI command cannot add a value into the accumulator.  


*5. What changes are necessary to the PRISM datapath to add another instruction (SUBI, which would subtract an immediate value from the accumulator) to the instruction set?*

The ALU would have to be altered first to contain a SUBI command.  This would actually be pretty easy.  Just take the two's compliment of whatever is coming off of the data bus and make it the 8th command on the multiplexer on the ALU, since there are only seven commands there anyway.  There are only 7 commands because command 5, IN, and 7, LOAD, actually do the exact same thing.  They just take what is one the databus and put in into the accumulator.  One of those can just be removed and replaced with the SUBI.  Or, if the user would like to keep both of these functions, another bit could be added to the number of options in the multiplexer and to the opSel.  Then opSel, and what controls it would have to be changed to be able to choose the SUBI command when desired.

Also, another bit would have to be added to the IR, so that the SUBI function could be used directly in the assembly code.   Otherwise, there would be no way to choose this instuction from assembly code, since there is a specific command for each of the numbers in the list of the 4 bit long assembly commands.  Then, the IR registar would have to have 5 flip-flops so that 5 bits of instruction memory could be stored there.  



#**Documentation**

NONE



