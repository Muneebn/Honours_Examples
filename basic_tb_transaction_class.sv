class Transaction;
  rand bit [3:0] a;  // 4-bit input A
  rand bit [3:0] b;  // 4-bit input B
  bit [4:0] expected_sum; // Expected result (calculated manually)

  // Generate the expected result
  function void compute_expected();
    expected_sum = a + b;
  endfunction

  // Constraint for random values
  constraint valid_values {
    a inside {[0:15]}; // A is 4 bits
    b inside {[0:15]}; // B is 4 bits
  }
endclass
