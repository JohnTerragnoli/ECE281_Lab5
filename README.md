ECE281_Lab5
===========


#Initial PRISM Simulation: 

The files that were given initially were supposed to run the following program when PRISM_Simulation file was run. 

![alt text](https://raw.githubusercontent.com/JohnTerragnoli/ECE281_Lab5/master/InitialProgramPic.PNG "Initial Program Description")

This program was supposed to put the value 8 in the accumulator, add one to the accumulator, and output this value with every iteration to output port three.  This continued until the value in the accumulator became negative. This is because after the LDAI command happens, an add 1 to the accumulator happens, and then the OUT command is executed. Therefore, the first number to go to the output is 9. After this, a jmp command is initiated to return to right before the add one command.  This jump command is secifically the JN command, which is activated as long as the accumulator value is negative.  Negative numbers are numers that are above 8 in binary, because this means that the left most bit will be a '1'.  So the program will count from 9 to F, and then output the value 0, because the program is run one more time once the value in the accumulator is F.  Then, once the program is reset, the program will start counting again as stated above.  


