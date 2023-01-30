
module extend(input  logic [31:7] instr,
              input  logic [1:0]  immsrc,
              output logic [31:0] immext);
 
  always_comb
    case(immsrc) 
               // I-type 
      2'b00: immext = {{20{instr[31]}}, instr[31:20]};  //12-bit signed immediate
               // S-type (stores)
      2'b01: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};  //12-bit signed immediate 
               // B-type (branches)
      2'b10: immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};  //
               // J-type (jal)
      2'b11: immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};  // 
      default: immext = 32'bx; // undefined
    endcase             
endmodule