
module imemorycode(
   input  logic      clk, reset,

   input logic       RegWriteM, 
   input logic [1:0] ResultSrcM,
   input logic       MemWriteM,    

   input logic [31:0] ALUResultM,
   input logic [31:0] WriteDataM,                     
   input logic [4:0] RdM,
   input logic [31:0] PCPlus4M,
   
   output logic        RegWriteW, 
   output logic [1:0]  ResultSrcW,
   output logic [31:0] ALUResultW,
   output logic [31:0] ReadDataW,
   output logic [4:0] RdW,
   output logic [31:0] PCPlus4W
    );
logic [31:0] ReadDataM;

// Data Memory
dmem  Data_Memory(clk, MemWriteM, ALUResultM, WriteDataM, ReadDataM);

// Memory_WriteBack pipeline 
mem_wb Memory_WB(clk, reset, RegWriteM, ResultSrcM, ALUResultM,ReadDataM, RdM, PCPlus4M, RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW,PCPlus4W);

//      initial begin
//        $display("Time\t RegWriteW\t ResultSrcW\t ALUResultW\t ReadDataW\t  RdW\t PCPlus4W");
//        $monitor("%h\t\t %h\t\t %h\t\t   %h\t\t\t %h\t\t\t %h\t\t %h\t\t   ", $time,
//                  RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW,PCPlus4W);
//        #220 $finish;
//     end
   
endmodule
