module time_example;
    time start_time, end_time, elapsed_time;

    initial begin
        // Default value of time variables is 0
        $display("Default start_time: %0t", start_time); // Output: 0
        $display("Default end_time: %0t", end_time);     // Output: 0

        start_time = $time; // Capture the current simulation time
        #15; // Wait for 15 time units
        end_time = $time; // Capture the current simulation time
        elapsed_time = end_time - start_time; // Calculate elapsed time
        $display("Elapsed time: %0t", elapsed_time); // Output: 15
    end
endmodule
