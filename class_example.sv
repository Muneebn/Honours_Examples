class MyClass;
    // Data members (variables)
    int a;
    string name;

    // Constructor
    function new(int initial_a, string initial_name);
        a = initial_a;
        name = initial_name;
    endfunction

    // Member function
    function void display();
        $display("a = %0d, name = %s", a, name);
    endfunction
endclass

module class_example;
    MyClass obj1, obj2;

    initial begin
        // Create objects using the constructor
        obj1 = new(10, "Object1");
        obj2 = new(20, "Object2");

        // Call member functions
        obj1.display(); // Output: a = 10, name = Object1
        obj2.display(); // Output: a = 20, name = Object2
    end
endmodule
