module alu(input  logic [31:0] a, b,
           input  logic [2:0]  alucontrol,
           output logic [31:0] result,
           output logic        zero);

  logic [31:0] condinvb, sum;
  logic        v;              // overflow
  logic        isAddSub;       // true when is add or subtract operation

  assign condinvb = alucontrol[0] ? ~b : b;
  assign sum = a + condinvb + alucontrol[0];
  assign isAddSub = ~alucontrol[2] & ~alucontrol[1] |
                    ~alucontrol[1] & alucontrol[0];
                    
  always_comb
    case (alucontrol)
      //
      3'b000:  result = sum;         //Add
      3'b001:  result = sum;         //Sub
      3'b101:  result = (a < b) ? 1: 0; //SLT
      3'b011:  result = a | b;       //OR
      3'b010:  result = a & b;       //AND
      default: result = 32'bx; 
    endcase

  assign zero = (result) ? 0 : 1;
  assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;
  
endmodule
