class Generator;
  Transaction trans;

  function new();
    trans = new();
  endfunction

  function Transaction generate_transaction();
    assert(trans.randomize()); // Randomize the transaction
    trans.compute_expected();  // Compute the expected result
    return trans;
  endfunction
endclass
