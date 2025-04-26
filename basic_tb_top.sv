module testbench;
  AdderInterface vif(); // DUT interface
  adder_4bit dut (.a(vif.a), .b(vif.b), .sum(vif.sum));

  // Mailbox for communication between monitor and scoreboard
  mailbox observed_data;

  // Instantiate components
  Generator gen;
  Driver driver;
  Monitor monitor;
  Scoreboard scoreboard;

  initial begin
    // Initialize components
    gen = new();
    driver = new(vif);
    observed_data = new();
    monitor = new(vif, observed_data);
    scoreboard = new(observed_data);

    // Spawn tasks
    fork
      monitor.monitor_signals();
      scoreboard.check_results();
    join_none

    // Generate and drive transactions
    for (int i = 0; i < 10; i++) begin
      Transaction trans = gen.generate_transaction();
      driver.drive_input(trans);
      #20;
    end

    // Wait for scoreboard to complete
    #100;
    $finish;
  end
endmodule
