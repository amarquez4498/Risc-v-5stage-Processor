
module pipeline ();


  logic        clk;
  logic        reset;

  //logic [31:0] WriteData, DataAdr;
 //logic        MemWrite;
  
  // initialize test
  initial
    begin
      reset <= 1; # 5; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end



//~~~~~~~~~~~~~~~~~iFetch Module~~~~~~~~~~~~~~~~~~~~~~

  logic [31:0] tb_InstrD,tb_PCD,tb_PCPlus4D;
  logic tb_PCSrcE;
  logic [31:0]tb_PCTargetE;


  ifetch ifetch1(clk, reset,tb_PCSrcE,tb_PCTargetE,tb_InstrD,tb_PCD,tb_PCPlus4D); 

   initial begin      
    tb_PCSrcE <= 0;    
    tb_PCTargetE <= 0;      
   end                    
//~~~~~~~~~~~~~~~~~idecode Module~~~~~~~~~~~~~~~~~~~~~~
//Inputs

logic [31:0]  tb_ResultW;
logic         tb_RegWriteW;
logic [4:0]  tb_RdW;//--Dr.M  

//Outputs
logic  [31:0]  tb_RD1E, tb_RD2E, tb_ImmExtE,tb_PCE, tb_PCPlus4E;
logic         tb_RegWriteE, tb_MemWriteE, tb_JumpE, tb_BranchE, tb_ALUSrcE;
logic  [1:0]  tb_ResultSrcE;
logic  [2:0]  tb_AluControlE;
logic  [4:0]  tb_RdE;

idecode stage2(clk, reset, tb_PCD, tb_InstrD, tb_PCPlus4D, tb_ResultW,tb_RegWriteW,tb_RdW,
                  tb_RD1E, tb_RD2E, tb_ImmExtE, tb_PCE, tb_PCPlus4E, tb_RdE,
                   tb_ResultSrcE, tb_MemWriteE, tb_ALUSrcE, tb_RegWriteE, tb_JumpE, tb_BranchE,  
                    tb_AluControlE);
  
  // why?                 
//    initial begin
//       tb_ResultW <= 0;
//       tb_RegWriteW <=0;
//       tb_RdW  <= 0;
//     end
                    
//~~~~~~~~~~~~~~~~~Execute Module~~~~~~~~~~~~~~~~~~~~~~
//logic        tb_RegWriteM; 
logic [1:0]  tb_ResultSrcM;
logic        tb_MemWriteM;    
logic [31:0] tb_ALUResultM;
logic [31:0] tb_WriteDataM;                     
logic [4:0] tb_RdM; //fix to 4:0
logic [31:0] tb_PCPlus4M;

Excode stage3(clk, reset, tb_RegWriteE,tb_ResultSrcE, tb_MemWriteE,tb_JumpE, tb_BranchE, tb_AluControlE,
              tb_ALUSrcE, tb_RD1E, tb_RD2E, tb_PCE, tb_RdE, tb_ImmExtE, tb_PCPlus4E, 
              tb_RegWriteM, tb_ResultSrcM, tb_MemWriteM, tb_ALUResultM, tb_WriteDataM, tb_RdM, tb_PCPlus4M,tb_PCSrcE,
        tb_PCTargetE); // nned to  generate tb_PCSrcE, tb_PCTargetE  ( check the diagram) -- Dr.M

//~~~~~~~~~~~~~~~~~Memory Module~~~~~~~~~~~~~~~~~~~~~~

logic        tb_RegWriteW; 
logic [1:0]  tb_ResultSrcW;    
logic [31:0] tb_ALUResultW;
logic [31:0] tb_ReadDataW;                     
logic [4:0] tb_RdW;//set 4:0
logic [31:0] tb_PCPlus4W;


imemorycode stage4(clk, reset, tb_RegWriteM, tb_ResultSrcM, tb_MemWriteM, tb_ALUResultM, tb_WriteDataM, tb_RdM, tb_PCPlus4M, 
                        tb_RegWriteW, tb_ResultSrcW, tb_ALUResultW, tb_ReadDataW, tb_RdW, tb_PCPlus4W);

//~~~~~~~~~~~~~~~~~Write Back Module~~~~~~~~~~~~~~~~~~~~~~

 

Write_Back  stage5( tb_RegWriteW, tb_ResultSrcW, tb_ALUResultW, tb_ReadDataW, tb_RdW, tb_PCPlus4W, tb_ResultW);

      initial begin
        $display("Time\t tb_ResultW\t ");
        $monitor("%0d\t %d", $time, tb_ResultW);
        #260 $finish;
     end

endmodule // pipeline
