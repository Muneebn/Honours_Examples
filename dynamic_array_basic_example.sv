module dynamic_array_test;

  // Dynamic array declaration
  logic [7:0] dynamic_array[];

  // Variable to hold the size retrieved from testplusargs
  integer size;

  initial begin
    // Default size in case testplusargs is not provided
    size = 10; 

    // Retrieve size from testplusargs
    if ($value$plusargs("ARRAY_SIZE=%d", size)) begin
      $display("Dynamic array size provided: %0d", size);
    end else begin
      $display("No testplusargs provided. Using default size: %0d", size);
    end

    // Allocate dynamic array with the determined size
    dynamic_array = new[size];

    // Initialize the dynamic array
    for (int i = 0; i < size; i++) begin
      dynamic_array[i] = i;
    end

    // Display the array contents
    $display("Dynamic array contents:");
    for (int i = 0; i < size; i++) begin
      $display("Element [%0d]: %0d", i, dynamic_array[i]);
    end
  end

endmodule
