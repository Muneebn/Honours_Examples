class NetworkPacket;
  rand bit [15:0] src_addr;     // Source address
  rand bit [15:0] dest_addr;    // Destination address
  rand bit [7:0] priority;      // Priority level
  rand bit [15:0] payload_size; // Size of the payload
  rand bit [7:0] data[10];      // Payload data (array of random bytes)

  // 1. Simple Constraint: Source and destination addresses should not be equal
  constraint addr_diff {
    src_addr != dest_addr;
  }

  // 2. Range Constraint: Payload size must be between 64 and 1500 bytes
  constraint size_range {
    payload_size inside {[64:1500]};
  }

  // 3. Weighted Constraint: Priority levels are weighted
  // Priority 0 (Low) has 50%, Priority 1 (Medium) has 30%, Priority 2 (High) has 20%
  constraint priority_weighted {
    priority dist {0 := 50, 1 := 30, 2 := 20};
  }

  // 4. Conditional Constraint: If the priority is High (2), payload size must not exceed 512 bytes
  constraint high_priority_constraint {
    priority == 2 -> payload_size <= 512;
  }

  // 5. Iterative Constraint: All data bytes in the payload must be less than 240 (0xF0)
  constraint data_constraint {
    foreach (data[i]) { data[i] < 8'hF0; }
  }

  // 6. Debugging Conflicts
  // Check for randomization failures and resolve conflicts
  function void debug();
    if (!this.randomize()) begin
      $display("Randomization failed due to conflicting constraints.");
    end else begin
      $display("Randomization succeeded!");
    end
  endfunction
endclass

module testbench;
  initial begin
    NetworkPacket pkt = new();

    // Generate packets with constraints
    for (int i = 0; i < 5; i++) begin
      pkt.debug(); // Debug function to handle randomization
      $display("\nPacket %0d:", i + 1);
      $display("  Source Address     : %0h", pkt.src_addr);
      $display("  Destination Address: %0h", pkt.dest_addr);
      $display("  Priority           : %0d (0=Low, 1=Medium, 2=High)", pkt.priority);
      $display("  Payload Size       : %0d bytes", pkt.payload_size);

      $display("  Payload Data       : ");
      foreach (pkt.data[j]) begin
        $display("    Data[%0d]: %0h", j, pkt.data[j]);
      end
    end
  end
endmodule

