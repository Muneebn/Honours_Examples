module void_example;
    // Function with void return type
    function void print_message(string message);
        $display("Message: %s", message);
    endfunction

    initial begin
        // Calling the void function
        print_message("This is a void function example.");
    end
    endmodule
