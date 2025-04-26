module string_example;
    string greeting;

    initial begin
        // Default value of string variables is an empty string
        $display("Default greeting: '%s'", greeting); // Output: ''

        greeting = "Hello, SystemVerilog!";
        $display("Greeting: %s", greeting); // Output: Hello, SystemVerilog!
    end
endmodule
