class Scoreboard;
  mailbox observed_data;
  int error_count = 0;

  function new(mailbox observed_data);
    this.observed_data = observed_data;
  endfunction

  task check_results();
    Transaction trans;
    forever begin
      observed_data.get(trans); // Get transactions from the monitor
      if (trans.expected_sum !== trans.expected_sum) begin
        $display("ERROR: Mismatch! A=%0d, B=%0d, Expected=%0d, Got=%0d", 
                 trans.a, trans.b, trans.expected_sum, trans.expected_sum);
        error_count++;
      end else begin
        $display("PASS: A=%0d, B=%0d, Sum=%0d", trans.a, trans.b, trans.expected_sum);
      end
    end
  endtask
endclass
