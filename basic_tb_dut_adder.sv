module adder_4bit (
  input  logic [3:0] a,  // Input A
  input  logic [3:0] b,  // Input B
  output logic [4:0] sum // Sum output
);
  assign sum = a + b; // Simple addition
endmodule
