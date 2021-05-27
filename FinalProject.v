/*
This project is designed to accept two 4 digit number in IEEE754 format (Half Presicion) (16 bits) via a 4x4 numeric keypad
And display its floating point addition output on SSD
It loops from state 0 (Reset) -> state 1 (Enter input 1) -> state 2 (Enter input 2) -> state 3 (FPA_Calc) -> state 0 (Reset) 
It also displays the state the Project currently is in on a 16x2 LCD via a Arduino UNO.

Github - https://github.com/ShervinAmbrose

-Shervin Ambrose
*/
module FinalProject(input  clock,
					input pb,	//PushButton
					input row1, row2, row3, row4,
					output reg column1, column2, column3, column4,
					output reg led1,led2,
					output reg [7:0]  seg1, seg2, seg3, seg4,	// Seven Segment Display
					output reg d1,d2,d3,d4	//Pins connected to Arduino to display the State
					);
	
	reg [7:0] keyCode;	//Stores the row and column corresponding to keypress
	reg [8:0] columnCounter = 0;	//Used for frequency division
	reg [1:0] columnState = 0;	//Change the columns from 0 to 3
	reg column = 0;
	reg [19:0] displayCounter = 0;	//Used for frequency division
	reg displayResult = 0;	//Clock to display result
	reg flag = 1'b0;	//If key is pressed, riase this flag
	reg checkflag = 1'b0;	//Check if key is pressed
	reg [7:0] segDisplay = 8'b01111111;
	reg [15:0] num1;
	reg [15:0] num2;	
	reg [7:0] segDisplay1 = 8'b01111111;	//keyCode 1-4 and num1Key are used as shift registers
	reg [7:0] segDisplay2 = 8'b01111111;
	reg [7:0] segDisplay3 = 8'b01111111;
	reg [7:0] segDisplay4 = 8'b01111111;
	reg [7:0] num1Key = 8'b01111111;
	reg [3:0] hex2bin;					//hex2bin and hex2bin1-4 are used as shift registers
	reg [3:0] hex2bin1 = 4'b0000;	
	reg [3:0] hex2bin2 = 4'b0000;
	reg [3:0] hex2bin3 = 4'b0000;
	reg [3:0] hex2bin4 = 4'b0000;
	reg num1Flag = 1'b1;		//raised when num1 is stored in num1
	reg num2Flag = 1'b0;		//flag for num2
	reg keyFlag = 1'b0;		//raised when num1 is entered compeletely
	wire [15:0] fpaSum;		//Final FPA output
	wire ovf;					//overflow condition	
	wire unf;					//underflow condition
	reg outputDone = 1'b0;	//raise this when both num1 and num2 are entered and stored	
	reg [2:0] pbPress = 0;	//change the state when Push Button is pressed
	reg rSwitch = 1'b0;		//saves the previous state of the Push Button

	//module instantiation
	fpa_adder adder1 (.clk(displayResult), .Finput1(num1), .Finput2(num2),.FPSUM(fpaSum), .ovf(ovf), .unf(unf));

	//begin with state 0 (Reset)
	initial begin
	d1 = 1'b1;
	d2 = 1'b0;
	d3 = 1'b0;
	d4 = 1'b0;
	led1 = 1'b0;
	led2 = 1'b0;
	end

	//Frequency Divider 
	always @(posedge clock) begin
		columnCounter <= columnCounter + 1;
		displayCounter <= displayCounter + 1;
		if (columnCounter == 500) begin			//Generates a pulse of 10usec. Used for keypad scanning.
			column <= ~column;
			columnCounter <= 0;
		end
		if (displayCounter == 1000000) begin	//Generates a pulse of 20msec. Used for displaying the outputs.
			displayResult <= ~displayResult;
			displayCounter <= 0;
		end
	end

	/*
	This always block Scans for the keypad input. It keeps the column constant and scans the Rows.
	If a key is pressed it raises the flag indicating key is pressed and generates a corresponding 
	keycode (of rows and columns). If the key is not pressed, then make the flag low.
	The function of checkFlag is to check for the first input only.
	*/ 
	always @(posedge column) begin 
		case(columnState)
			0: begin
				{column1, column2, column3, column4} <= 4'b0111;
				case ({row1, row2, row3, row4})
					4'b0111: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1011: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1101: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1110: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					default: begin
						flag <= 1'b0;
						columnState <= 1;
					end
				endcase
			end
			/////////
			1: begin
				{column1, column2, column3, column4} <= 4'b1011;
				case ({row1, row2, row3, row4})
					4'b0111: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1011: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1101: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
						end
					4'b1110: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					default: begin
						flag <= 1'b0;
						columnState <= 2;
					end
				endcase
			end
			/////////
			2: begin
				{column1, column2, column3, column4} <= 4'b1101;
				case ({row1, row2, row3, row4})
					4'b0111: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1011: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag = 1'b1;
						checkflag = 1'b1;
					end
					4'b1101: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1110: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					default: begin
						flag <= 1'b0;
						columnState <= 3;
					end
				endcase
			end
			/////////
			3: begin
				{column1, column2, column3, column4} <= 4'b1110;
				case ({row1, row2, row3, row4})
					4'b0111: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1011: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1101: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					4'b1110: begin
						keyCode <= ({row1, row2, row3, row4, column1, column2, column3, column4});	
						flag <= 1'b1;
						checkflag = 1'b1;
					end
					default: begin
						flag <= 1'b0;
						columnState <= 0;
					end
				endcase
			end
			/////////
			default: begin
				columnState <= 0;
			end
		endcase
	end

	/*
	If a key is pressed then its corresponding binary value and SSD value is stored in hex2bin and segDisplay 
	*/
	always @(posedge flag) begin
		case (keyCode)
			8'b01110111: begin //Row1 Column1
				segDisplay <= 8'b11111001; //1
				hex2bin <= 4'b0001; //1
			end
			8'b01111011: begin //Row1 Column2
				segDisplay <= 8'b10100100; //2
				hex2bin <= 4'b0010; //2
			end
			8'b01111101: begin //Row1 Column3
				segDisplay <= 8'b10110000; //3
				hex2bin <= 4'b0011; //3
			end
			8'b01111110: begin //Row1 Column4
				segDisplay <= 8'b10001000; //A
				hex2bin <= 4'b1010; //A
			end
			////////////
			8'b10110111: begin // Row2 Column1
				segDisplay <= 8'b10011001; //4
				hex2bin <= 4'b0100; //4
			end
			8'b10111011: begin //Row2 Column2
				segDisplay <= 8'b10010010; //5
				hex2bin <= 4'b0101; //5
			end
			8'b10111101: begin //Row2 Column3
				segDisplay <= 8'b10000010; //6
				hex2bin <= 4'b0110; //6
			end
			8'b10111110: begin //Row2 Column4
				segDisplay <= 8'b10000011; //b
				hex2bin <= 4'b1011; //b
			end
			////////////
			8'b11010111: begin // Row3 Column1
				segDisplay <= 8'b11111000; //7
				hex2bin <= 4'b0111; //7
			end
			8'b11011011: begin //Row3 Column2
				segDisplay <= 8'b10000000; //8
				hex2bin <= 4'b1000; //8
			end
			8'b11011101: begin //Row3 Column3
				segDisplay <= 8'b10011000; //9
				hex2bin <= 4'b1001; //9
			end
			8'b11011110: begin //Row3 Column4
				segDisplay <= 8'b11000110; //C
				hex2bin <= 4'b1100; //C
			end
			////////////
			8'b11100111: begin // Row4 Column1
				segDisplay <= 8'b10001110; //* = F
				hex2bin <= 4'b1111; //* = F
			end
			8'b11101011: begin //Row4 Column2
				segDisplay <= 8'b11000000; // 0
				hex2bin <= 4'b0000; // 0
			end
			8'b11101101: begin //Row4 Column3
				segDisplay <= 8'b10000110; //# = E
				hex2bin <= 4'b1110; //# = E
			end
			8'b11101110: begin //Row4 Column4
				segDisplay <= 8'b10100001; // d
				hex2bin <= 4'b1101; // d
			end
			////////////
			default: begin
				if (checkflag == 0) begin
					segDisplay <= 8'b01111111;
				end
				else begin
					segDisplay <= segDisplay;
				end
			end
		endcase
	end

	/*
	In this always block, the input is stored in num1 and num2, displayed on the SSD, the FP_calc is 
	calculated and displayed, and lastly the states are displayed on the LCD via Arduino
	*/
	always @(posedge displayResult) begin
		rSwitch <= pb;		//The previous value of Push Button is stored in rSwitch
		/*
		This condition checks if the Push Button was pressed and realeased, after it's realesed it increments the pbPress register
		This is done because, if only Push Button press is checked then the pbPress register increments indefinately
		*/
		if (pb == 0 && rSwitch == 1) begin	
				pbPress <= pbPress + 1;
		end
		
		if (pbPress == 0) begin // Reset State, resets all the registers to their initial value
			segDisplay1 <= 8'b01111111;
			segDisplay2 <= 8'b01111111;
			segDisplay3 <= 8'b01111111;
			segDisplay4 <= 8'b01111111;
			num1Key <= 8'b01111111;
			num1 <= 0;
			num1Flag <= 1'b1;
			num2Flag <= 1'b0;
			num1 <= 0;
			num2 <= 0;
			hex2bin1 <= 4'b0000;
			hex2bin2 <= 4'b0000;
			hex2bin3 <= 4'b0000;
			hex2bin4 <= 4'b0000;
			keyFlag <= 1'b0;
			seg1 <= 8'b01111111;
			seg2 <= 8'b01111111;
			seg3 <= 8'b01111111;
			seg4 <= 8'b01111111;
			outputDone <= 0;
			d1 <= 1'b1;
			d2 <= 1'b0;
			d3 <= 1'b0;
			d4 <= 1'b0;
		end
		
		else begin		
			if (outputDone == 1'b0) begin	//Checks if both num1 and num2 are done entering, storing and displaying
				if ( pbPress > 0 && pbPress < 3) begin		//State 1 (input 1) and State 2 (input 2), 
					if (pbPress == 1) begin		//send 0100 to Arduino so that it knows this is state 1
						d1 <= 1'b0;
						d2 <= 1'b1;
						d3 <= 1'b0;
						d4 <= 1'b0;
					end
					else if (pbPress == 2) begin	//send 0010 to Arduino so that it knows this is state 2
						d1 <= 1'b0;
						d2 <= 1'b0;
						d3 <= 1'b1;
						d4 <= 1'b0;
					end
					/*
					When the clock(displayResult) is high and when key is pressed(flag)
					Start shifting the SSD value into segDisplay1, segDisplay1 into segDisplay2, segDisplay2 into segDisplay3.....
					All of this happens at the same time because non-blocking assignment is used
					*/
					if (displayResult ==1'b1 && flag == 1'b1) begin
						segDisplay1 <= segDisplay;
						segDisplay2 <= segDisplay1;
						segDisplay3 <= segDisplay2;
						segDisplay4 <= segDisplay3;
						num1Key <= segDisplay4;
					end
					/*
					When the clock(displayResult) is high and when key is pressed(flag) and 
					when entering number1 (num1Flag) and when in state 1
					start storing the binary equivalent of the HEX key in hex2bin1,hex2bin2....
					*/
					if (displayResult ==1'b1 && flag == 1'b1 && num1Flag == 1'b1 && pbPress == 1) begin
						hex2bin1 <= hex2bin;
						hex2bin2 <= hex2bin1;
						hex2bin3 <= hex2bin2;
						hex2bin4 <= hex2bin3;
					end
					/*
					When hex2bin4 gets updated, it means that the fourth key was entered, displayed and stored in registers
					therefore, assign the first four keys to num1, thereby updating the value of num1 which is the input to fpa_adder
					*/
					if (hex2bin4 != 4'b0000 && num1Flag == 1'b1 && pbPress == 1) begin
						num1 <= {hex2bin4, hex2bin3, hex2bin2, hex2bin1};
						num1Flag <= 1'b0;		//make num1Flag low indicating num1 is done 
						num2Flag <= 1'b1;		//start the same process of num1 for num2
					end
					/*
					This checks if the 5th key is pressed, if so then display it on the first SSD and clear the remaining SSD
					also clear the other three hex to binary registers
					*/
					if (num1Key != 8'b01111111) begin
						segDisplay2 <= 8'b01111111;
						segDisplay3 <= 8'b01111111;
						segDisplay4 <= 8'b01111111;
						num1Key <= 8'b01111111;
						hex2bin2 <= 4'b0000;
						hex2bin3 <= 4'b0000;
						hex2bin4 <= 4'b0000;
						keyFlag <= 1'b1;
					end 
					/*
					Same process as num1 but for num2
					*/
					if (displayResult ==1'b1 && flag == 1'b1 && num2Flag == 1'b1 && pbPress == 2) begin
						hex2bin1 <= hex2bin;
						hex2bin2 <= hex2bin1;
						hex2bin3 <= hex2bin2;
						hex2bin4 <= hex2bin3;
					end
					/*
					Same process as num1 but for num2. Here the num2 value gets updated which acts as a second input to fpa_adder
					*/
					if (hex2bin4 != 4'b0000 && keyFlag == 1'b1 && pbPress == 2) begin
						num2 <= {hex2bin4, hex2bin3, hex2bin2, hex2bin1};
						num2Flag <= 0;
					end
					//Display the pressed keys on the SSD
					seg1 <= segDisplay1;
					seg2 <= segDisplay2;
					seg3 <= segDisplay3;
					seg4 <= segDisplay4;
				end
				//Once num1(4digits) and num2(4digits) are entered and updated. This else block gets executed.
				else begin	
					if (pbPress == 3) begin		//Send 0001 to arduino so that it knows this is state3 (FPA_calc)
						d1 <= 1'b0;
						d2 <= 1'b0;
						d3 <= 1'b0;
						d4 <= 1'b1;
						seg4 <= numdisp(fpaSum [15:12]);
						seg3 <= numdisp(fpaSum [11:8]);
						seg2 <= numdisp(fpaSum [7:4]);
						seg1 <= numdisp(fpaSum [3:0]);
						/*
						outputDone indicates that the code has been through state0, state1 and state2
						and now it waits for the Push Button press so that it loop back to state0 (reset state)
						and repeate the same process again
						*/
						outputDone <= 1'b1;		
						if (ovf) begin
							led1 <= ovf;
						end
						else begin
							led1 <= 1'b0;
						end
						if (unf) begin
							led2 <= unf;
						end
						else begin
							led2 <= 1'b0;
						end
					end
				end
			end
		end
		if (pbPress == 4) begin		//if the Push Button is pressed the fourth time, go back to state0 (reset)
			pbPress <= 0;
		end
	end
	/*
	This function takes the binary value and returns back its equivalent SSD value
	*/
	function [7:0] numdisp;
		input [3:0] num;
		case (num)
			0: begin
				numdisp= 8'b11000000;
			end
			1: begin
				numdisp= 8'b11111001;
			end
			2: begin
				numdisp= 8'b10100100;
			end
			3: begin
				numdisp= 8'b10110000;
			end	
			4: begin
				numdisp= 8'b10011001;
			end
			5: begin
				numdisp= 8'b10010010;
			end
			6: begin
				numdisp= 8'b10000010;
			end
			7: begin
				numdisp= 8'b11111000;
			end
			8: begin
				numdisp= 8'b10000000;
			end
			9: begin
				numdisp= 8'b10011000;
			end
			10: begin
				numdisp= 8'b10001000;
			end
			11: begin
				numdisp= 8'b10000011;
				end
			12: begin
				numdisp= 8'b11000110;
				end
			13: begin
				numdisp= 8'b10100001;
				end
			14: begin
				numdisp= 8'b10000110;
				end
			15: begin
				numdisp= 8'b10001110;
				end
		endcase
	endfunction
endmodule
