module aludec(input  logic       opb5,
              input  logic [2:0] funct3,
              input  logic       funct7b5, 
              input  logic [1:0] ALUOp,
              output logic [2:0] ALUControl);

  logic  RtypeSub;
  assign RtypeSub = funct7b5 & opb5;  // TRUE for R-type subtract instruction

  always_comb
    case(ALUOp)
     // add the logic here 
       2'b00:   ALUControl = 3'b000;   //Add operation 
       2'b01:   ALUControl = 3'b001;   //Sub operation
       default: case({RtypeSub, funct3})
                   4'b0000: ALUControl = 3'b000;    //Add operation
                   4'b1000: ALUControl = 3'b001;    //Sub operation
                   4'b0010: ALUControl = 3'b101;    //SLT operation
                   4'b0110: ALUControl = 3'b011;    //OR operation
                   4'b0111: ALUControl = 3'b010;    //AND operation  
                   default: ALUControl = 3'bx; 
                endcase   
    endcase
endmodule