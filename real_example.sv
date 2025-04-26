module real_example;
    real a, b, result;

    initial begin
        // Default value of real variables is 0.0
        $display("Default a: %0f", a); // Output: 0.0
        $display("Default b: %0f", b); // Output: 0.0

        a = 3.14159;
        b = 2.71828;
        result = a * b; // Perform a real number multiplication
        $display("Result: %0f", result); // Output: 8.53973
    end
endmodule
