module controller(input  logic [6:0] op,
                  input  logic [2:0] funct3,
                  input  logic       funct7b5,
                 // input  logic       Zero, // not needed --Dr.M
                  output logic [1:0] ResultSrc,
                  output logic       MemWrite,
                  output logic       Branch,
                  output logic       ALUSrc,
                  output logic       RegWrite, Jump,
                  output logic [2:0] ALUControl,
                  output logic [1:0] ImmSrc
                 // output logic       PCSrc  // not needed --Dr.M
                  );

  logic [1:0] ALUOp;
  //initialization --Dr.M 
  initial begin 
   ResultSrc <=0; 
   MemWrite<=0; 
   Branch <=0;
   ALUSrc<=0;
   RegWrite <=0;
   Jump<=0; 
   ImmSrc<=0;
   ALUControl <=0;
   end

  maindec md(op, ResultSrc, MemWrite, Branch,
             ALUSrc, RegWrite, Jump, ImmSrc, ALUOp);
  aludec  ad(op[5], funct3, funct7b5, ALUOp, ALUControl);

  //assign PCSrc = Branch & Zero | Jump;
endmodule
