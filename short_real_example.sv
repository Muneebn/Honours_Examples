module shortreal_example;
    shortreal x, y, sum;

    initial begin
        // Default value of shortreal variables is 0.0
        $display("Default x: %0f", x); // Output: 0.0
        $display("Default y: %0f", y); // Output: 0.0

        x = 1.23;
        y = 4.56;
        sum = x + y; // Perform a shortreal addition
        $display("Sum: %0f", sum); // Output: 5.79
    end
endmodule
