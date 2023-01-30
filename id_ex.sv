
module id_ex(
   input  logic          clk, reset,
   
// Control Unit Inputs

   input logic       RegWriteD, 
   input logic [1:0] ResultSrcD,
   input logic       MemWriteD,
   input logic       JumpD,
   input logic       BranchD,
   input logic [2:0] ALUControlD,
   input logic       ALUSrcD,       
   
//Register File outputs going into pipelie as inputs
   input logic [31:0] RD1D, RD2D,
   
//Wire inputs   
   input logic [31:0] PCD,                         
   input logic [11:7] RdD,
   input logic [31:0] ImmExtD,
   input logic [31:0] PCPlus4D,

// Control Unit pipeline outputs

   output logic       RegWriteE, 
   output logic [1:0] ResultSrcE,
   output logic       MemWriteE,
   output logic       JumpE,
   output logic       BranchE,
   output logic [2:0] ALUControlE,
   output logic       ALUSrcE,     
   
//Register File outputs going into pipelie as inputs
   output logic [31:0] RD1E, RD2E,
   
//Wire inputs   
   output logic [31:0] PCE,                         
   output logic [11:7] RdE,
    output logic [31:0] ImmExtE,
   output logic [31:0] PCPlus4E
                       
);

always_ff @(posedge clk, posedge reset)
 if (reset) begin
     PCE <= 0;
     ImmExtE <=0;
     PCPlus4E <=0;
     RD1E <= 0;
     RD2E <= 0;
     RdE <= 0;
     ResultSrcE <= 0;
     MemWriteE <= 0;
     ALUSrcE <= 0;
     RegWriteE <= 0;
     JumpE <= 0;
     BranchE <= 0;
     ALUControlE <= 0;
     
 end
 else begin
     PCE <= PCD;
     ImmExtE <= ImmExtD;
     PCPlus4E <= PCPlus4D;
     RD1E <= RD1D;
     RD2E <= RD2D;
     RdE <= RdD;
     ResultSrcE <= ResultSrcD;
     MemWriteE <= MemWriteD;
     ALUSrcE <= ALUSrcD;
     RegWriteE <= RegWriteD;
     JumpE <= JumpD;
     BranchE <= BranchD;
     ALUControlE <= ALUControlD;     
 
 end
 
endmodule 

