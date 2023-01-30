
module Excode(
   input  logic      clk, reset,
   input logic       RegWriteE, 
   input logic [1:0] ResultSrcE,
   input logic       MemWriteE,
   input logic       JumpE,
   input logic       BranchE,
   input logic [2:0] ALUControlE,
   input logic       ALUSrcE,    
   input logic [31:0] RD1E, RD2E,
   input logic [31:0] PCE,                         
   input logic [4:0] RdE, //change  to 4:0 --Dr.M
   input logic [31:0] ImmExtE,
   input logic [31:0] PCPlus4E,
   
   output logic       RegWriteM, 
   output logic [1:0] ResultSrcM,
   output logic       MemWriteM,    
   
   output logic [31:0] ALUResultM,
   output logic [31:0] WriteDataM,                     
   output logic [4:0] RdM,//change  to 4:0 --Dr.M
   output logic [31:0] PCPlus4M,
   output logic PCSrcE, // Dr.M
   output logic [31:0]PCTargetE  // Dr.M
   
   );
   //wires
   logic [31:0] ALUResultE;
   logic [31:0] SrcBE;
   logic [31:0] WriteDataE;
   //logic [31:0] PCTargetE;
   logic        ZeroE;
   logic        andout;
   //logic        PCSrcE;


   //assign RD2E = WriteDataE;
    
 
   //MUX
   mux2 #(32)  pcmux_2(RD2E, ImmExtE, ALUSrcE, SrcBE);
   //Adder
   adder       pcadd4_2(PCE, ImmExtE, PCTargetE);
   // ALU 
   alu ALU_1(RD1E, SrcBE, ALUControlE, ALUResultE, ZeroE);
   
   //Logic
   
   assign andout = ZeroE & BranchE; 
   assign PCSrcE = andout | JumpE;

   //ex_mem 
   ex_mem     EX_M(clk, reset, RegWriteE, ResultSrcE, MemWriteE, ALUResultE, RD2E,RdE,PCPlus4E,
                   RegWriteM,ResultSrcM,MemWriteM,ALUResultM, WriteDataM,RdM,PCPlus4M);
//initial begin
//        $display("Time\t RegWriteM\t ResultSrcM\t\t MemWriteM\t ALUResultM\t WriteDataM\t  RdM\t PCPlus4M");
//        $monitor("%0d\t\t %h\t\t %h\t\t   %h\t\t\t %h\t\t\t %h\t\t %h\t\t  %h\t\t ", $time,
//                  RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM,PCPlus4M);
//        #260 $finish;
//     end
   
endmodule
