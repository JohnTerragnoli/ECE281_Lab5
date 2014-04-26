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

Fetch1: The reset button is hit, making IRld and PCld a high, making PC and IR zero.  This sets up the zero command in the program, which is just making the PC go onto the next command.  This means at the next rising clock, the PC will change to 01 and the IR will change to whatever command is located on line 0 of the instruction in the decode section.  

Decode1: The command at line 00 is 07, which is LDAI, meaning an immediate value is loaded into the accumulator.  This is considered an Immediate Execute instruction.  An immediate execute means that the program will perform execute at the next clock cycle.  This means that the value 8 should be in the accumulator at 35ns, or the end of the execute time, which it is.  

Execute1: The value 8 is put into the accumulator.  Accumulator load was high right before this happened, which allowed the accumulator value to change.  Also, the PCld has gone high at 25ns so that it can prepare to move onto the next instruction.  














A picture of the simulation can be seen here: 
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation.PNG "Ititial Program Simulation")



#PRISM Program 1 Implementation

The simulation for the PRISM Program 1 Simulation can be seen here:[Program_1](https://www.youtube.com/watch?v=1jAqDPLEqxA&feature=youtu.be)

