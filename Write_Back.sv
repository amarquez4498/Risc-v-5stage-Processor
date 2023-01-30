
module Write_Back(
  // input  logic        clk, reset, why? --Dr.M
   input logic        RegWriteW, 
   input logic [1:0]  ResultSrcW,
   input logic [31:0] ALUResultW,
   input logic [31:0] ReadDataW,
   input logic [4:0] RdW,  // fix to be 4:0 --Dr.M
   input logic [31:0] PCPlus4W,
   
   output logic [31:0]  ResultW  //should be 32 bits 
    
    );
    
mux3 #(32)  pcmux3(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);

//      initial begin
//        $display("Time\t ResultW\t ");
//        $monitor("%h\t\t", $time, ResultW);
//        #220 $finish;
//     end

endmodule
