ECE281_Lab5
===========


#Initial PRISM Simulation: 

These files were given initially and were used and modified throughout the lab: 

[Controller_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Controller_Original.vhd)

[Datapath_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Datapath_Original.vhd)

[I/O_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/I_O_Original.vhd)

[Lab5_Testbench_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Lab5_testbench_Original.vhd)

[Clock_Divider_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Clock_Divider_Original.vhd)

[Lab5_Waveform_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Lab5_waveform_Original.wcfg)

[Memory_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Memory_Original.vhd)

[Nexys2_top_shell_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/Nexys2_top_shell_Original.vhd)

[PRISM_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/PRISM_Original.vhd)

[RAM_Original](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/RAM_16x4_Original.vhd)


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



Fetch1: The reset button is hit, and IRld and PCld are high, making PC and IR zero.  This sets up the zero command in the program, which is just making the PC go onto the next command.  This means at the next rising clock, the PC will change to 01 and the IR will change to whatever command is located on line 01 of the instruction in the decode section.  Moving PC to line 01 is just getting the value that is supposed to go into the accumulator.  

Decode1: The command at line 00 is 07, which is LDAI, meaning an immediate value is loaded into the accumulator.  This is considered an Immediate Execute instruction.  An immediate execute means that the program will perform execute at the next clock cycle.  This means that the value 8 should be in the accumulator at 35ns, or the end of the execute time, which it is.  This can happen because the opsel goes to 7, meaning that the ALU is performing a load function from the databus.   

Execute1: The value 8 is put into the accumulator.  Accumulator load was high right before this happened, which allowed the accumulator value to change.  Also, the PCld has gone high at 25ns so that it can prepare to move onto the next instruction.  


##35-65ns
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation02.PNG "Inital Program Simulation02")

Fetch2:  IRld and PCld are high. This means that the IR is ready to accept a new command and that the Program counter is about to move to the next line in the code.  The PC moves to line 02 at Fetch2.    The opsel changes to 0 but this doesn't matter because the accumulator load is off. 

Decode2: Program is now at line 02, meaning that the instruction 06 is put on the databus, preparing to go into the IR on the next rising edge of the clock. This happens at 45ns. Instruction 06 is a ADAI, or an immediate execute.  The program here will add one to whatever is in the accumulator on the next clock cycle.  Also, the PCld is still on and the PC moves to line 03, because that's where the value 1 being added to the accumulator is being temporarily stored.  

Execute2: The accumLd is turned on right at 55ns, or the execute. The value of the accumulator can now be changed.  This means at the next clock cycle, 65ns, the value 1 will be added to the accumulator and stored in the accumulator.  This saved value should then be saved as 9, which it is.  





##65-105ns
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation03.PNG "Inital Program Simulation03")

Fetch3:  IRld and PCld are high. This means that the IR is ready to accept a new command and that the Program counter is about to move to the next line in the code.  The PC moves to line 04 at Fetch2.    The opsel changes to 0 but this doesn't matter because the accumulator load is off. It prepares to put the command 04 into the IR. 

Decode3: 04 is put into the IR.  This instruction is OUT, meaning that the value in the accumulator will be output to a specific port. The PC moves to the 05, since it's load is still active.  

Decode LoAddr3: MarLo_ld is turned on, meaning the value on the databus can be stored in MarLo.  This will later serve as the output for the program.  03 is not put into MarLo until 95ns.  

Execute3:   The address is changed to 03, where the output will put the accumulator value.  At 105ns, the execute command is finally finished with the value in the accumulator, 9, being sent to output 03.  


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









A picture of the simulation can be seen here: 
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation.PNG "Ititial Program Simulation")



#PRISM Program 1 Implementation

The simulation for the PRISM Program 1 Simulation can be seen here:[Program_1](https://www.youtube.com/watch?v=1jAqDPLEqxA&feature=youtu.be)

