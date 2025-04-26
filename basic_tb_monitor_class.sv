class Monitor;
  virtual interface AdderInterface vif;
  mailbox observed_data;

  function new(virtual interface AdderInterface vif, mailbox observed_data);
    this.vif = vif;
    this.observed_data = observed_data;
  endfunction

  task monitor_signals();
    forever begin
      #10; // Observe after each computation
      Transaction trans = new();
      trans.a = vif.a;
      trans.b = vif.b;
      trans.expected_sum = vif.sum;
      observed_data.put(trans); // Send observed data to the scoreboard
    end
  endtask
endclass
