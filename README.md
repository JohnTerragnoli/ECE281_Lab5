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



The files that were given initially were supposed to run the following program when PRISM_Simulation file was run. 

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramPic.PNG "Initial Program Description")

This program was supposed to put the value 8 in the accumulator, add one to the accumulator, and output this value with every iteration to output port three.  This continued until the value in the accumulator became negative. This is because after the LDAI command happens, an add 1 to the accumulator happens, and then the OUT command is executed. Therefore, the first number to go to the output is 9. After this, a jmp command is initiated to return to right before the add one command.  This jump command is secifically the JN command, which is activated as long as the accumulator value is negative.  Negative numbers are numers that are above 8 in binary, because this means that the left most bit will be a '1'.  So the program will count from 9 to F, and then output the value 0, because the program is run one more time once the value in the accumulator is F.  Then, once the program is reset, the program will start counting again as stated above.  

A picture of the simulation can be seen here: 
![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramSimulation.PNG "Ititial Program Simulation")



#PRISM Program 1 Simulation

The simulation for the PRISM Program 1 Simulation can be seen here:[Program_1](https://www.youtube.com/watch?v=1jAqDPLEqxA&feature=youtu.be)

