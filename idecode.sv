
module idecode( 
   input  logic             clk, reset,
   input  logic [31:0]  PCD, InstrD, PCPlus4D, ResultW,
   input  logic         RegWriteW,
   input logic [4:0] RdW,  // RdW is input to keep track of the destination --Dr.M
   
   output logic  [31:0]  RD1E,RD2E,ImmExtE,PCE,PCPlus4E,
   output logic  [4:0]  RdE,
   
   output logic  [1:0]  ResultSrcE,
   output logic         MemWriteE, ALUSrcE, RegWriteE,  JumpE, BranchE, 
   output logic  [2:0]  ALUControlE
    );

//Wires 
logic [1:0]  ResultSrcD;
logic        MemWriteD;
logic        ALUSrcD;
logic        RegWriteD;
logic        JumpD;
logic        BranchD;
logic [2:0]  ALUControlD;  
logic [31:0] ImmExtD;
logic [4:0]       RdD; // 5 bit register number --Dr.M
logic [31:0] RD1D;
logic [31:0] RD2D;
logic [1:0]ImmSrcD; // incorrect  signal size, should be 2 bits  --Dr.M
//logic        zero;   

//assign zero = 0; //not needed it should be generated in Execution stage --Dr.M

//assign  RdD = InstrD[11:7]; 
    
//    initial begin
//       ImmSrcD <= 0;
//     end 
   
// Control Unit 
controller control_Unit(InstrD[6:0], InstrD[14:12], InstrD[30], 
                         ResultSrcD, MemWriteD, BranchD, ALUSrcD, RegWriteD, JumpD, ALUControlD, ImmSrcD);
                         
// RegFile

regfile register_file(clk, RegWriteW, InstrD[19:15], InstrD[24:20], RdW , ResultW, RD1D, RD2D); // should include RdW to protect the destination --Dr.M

// Extender
extend Extender(InstrD [31:7], ImmSrcD, ImmExtD);

//ID_Ex pipeline register

id_ex ID_IEpipeline(clk, reset, RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD, RD1D, RD2D, PCD, InstrD[11:7], ImmExtD, PCPlus4D,
                    RegWriteE,ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, RdE, ImmExtE, PCPlus4E );


//replace RdD  with InstrD[11:7] for troublsooting --Dr.M
   // simulation                             
//      initial begin
//        $display("Time\t PCD\t InstrD\t\t InstrD [19:15]\t InstrD [24:20]\t InstrD [17:7]\t  MemWriteE\t JumpE\t BranchE\t ALUSrcE\t ResultSrcE\t ALUControlE\t RD1E\t RD2E\t PCE\t PCPlus4E\t ImmExtE\t RdE");
//        $monitor("%0d\t\t %0d\t\t %h\t\t   %0d\t\t\t %0d\t\t\t %0d\t\t %0d\t\t  %b\t\t  %b\t\t\t  %b\t\t\t %b\t\t\t  %d\t\t\t  %0d\t\t\t  %0d\t\t  %0d\t\t  %0d\t\t  %0d\t\t  %0d\t\t %0d\t\t", $time,  PCD, InstrD,
//                       PCD,
//                       InstrD,
//                       InstrD [19:15],InstrD [24:20], InstrD [11:7],
//                       RegWriteE,
//                       MemWriteE,
//                       JumpE,
//                       BranchE,
//                       ALUSrcE,
//                       ResultSrcE,
//                       ALUControlE,
//                       RD1E, 
//                       RD2E,
//                       PCE, 
//                       PCPlus4E, 
//                       ImmExtE,
//                       RdE);
//         #220 $finish;
//      end

endmodule  //Decode stage 

