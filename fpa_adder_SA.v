module fpa_adder(input clk,
input [15:0]num1,num2,
output reg[15:0]fpaSum,
output reg ovf,unf);



initial begin

end
//Stage 1 fetching the data into registers & alligning the data
always @(posedge clk) begin

end

always@(posedge clk) begin

  
end


always@(posedge clk) begin

  
 //$display("Exp: %h, Frac[24:2]: %h, fpaSum: %h",Exp,Frac[11:2],fpaSum);
end

endmodule
