
`timescale 1ns / 1ns
module FinalProject_tb  ; 
 
  wire  [7:0]  seg1   ; 
  wire  reg  column2   ; 
  wire  [7:0]  seg2   ; 
  reg    row1   ; 
  wire  reg  column3   ; 
  wire  [7:0]  seg3   ; 
  reg    row2   ; 
  wire  reg  column4   ; 
  wire  [7:0]  seg4   ; 
  reg    reset   ; 
  reg    row3   ; 
  wire  [7:0]  seg5   ; 
  reg    clock   ; 
  reg    row4   ; 
  wire  [7:0]  keyCode   ; 
  wire  reg  segFlag   ; 
  wire  [7:0]  seg0   ; 
  wire  reg  column1   ; 
  FinalProject  
   DUT  ( 
       .seg1 (seg1 ) ,
      .column2 (column2 ) ,
      .seg2 (seg2 ) ,
      .row1 (row1 ) ,
      .column3 (column3 ) ,
      .seg3 (seg3 ) ,
      .row2 (row2 ) ,
      .column4 (column4 ) ,
      .seg4 (seg4 ) ,
      .reset (reset ) ,
      .row3 (row3 ) ,
      .seg5 (seg5 ) ,
      .clock (clock ) ,
      .row4 (row4 ) ,
      .keyCode (keyCode ) ,
      .segFlag (segFlag ) ,
      .seg0 (seg0 ) ,
      .column1 (column1 ) ); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  initial
  begin
	  clock  = 1'b0  ;
	 # 50 ;
// 50 ns, single loop till start period.
   repeat(9)
   begin
	   clock  = 1'b1  ;
	  #50  clock  = 1'b0  ;
	  #50 ;
// 950 ns, repeat pattern in loop.
   end
	  clock  = 1'b1  ;
	 # 50 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  reset  = 1'b0  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  row1  = 1'b0  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  row2  = 1'b1  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  row3  = 1'b1  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  row4  = 1'b1  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  if (column1  != (1'b0  )) $display($time, " test case failed");
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  if (column2  != (1'b1  )) $display($time, " test case failed");
	 # 1000 ;
// dumped values till 1 us
  end


// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  initial
  begin
   repeat(10)
   begin
	   if (column3  != (1'b1  )) $display($time, " test case failed");
	  #50  if (column3  != (1'b0  )) $display($time, " test case failed");
	  #50 ;
// 1 us, repeat pattern in loop.
   end
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  if (column4  != (1'b1  )) $display($time, " test case failed");
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  if (keyCode  != (8'b01110111  )) $display($time, " test case failed");
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  if (segFlag  != (1'b1  )) $display($time, " test case failed");
	 # 1000 ;
// dumped values till 1 us
  end

  initial
	#2000 $stop;
endmodule
