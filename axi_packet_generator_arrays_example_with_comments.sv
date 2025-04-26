/*
Explanation of the Code
Struct for AXI Packets:
A packed struct named axi_packet_t represents an AXI packet with fields like addr, data, id, and burst_type.

Dynamic Array:
The dynamic array axi_packets[] stores the generated AXI packets, with each packet being initialized with random values.

Associative Array:
The associative array packet_status[int] tracks the status of packets using their IDs as keys.

Queue:
The queue processing_queue simulates FIFO processing of packets.

Array Functions:
Functions like size(), push_back(), pop_front(), and iteration methods (first, next) are demonstrated in the code.
*/

module axi_packet_generator;

  // Define a packed struct for an AXI packet
  typedef struct packed {
    logic [31:0] addr;      // Address
    logic [31:0] data;      // Data
    logic [3:0]  id;        // Packet ID
    logic [1:0]  burst_type; // Burst Type (e.g., INCR, FIXED)
  } axi_packet_t;

  // Dynamic array for generated AXI packets
  axi_packet_t axi_packets[];

  // Associative array to track packet statuses (Key: Packet ID, Value: Status)
  string packet_status[int];

  // Queue to simulate a pipeline of packets for processing
  axi_packet_t processing_queue[$];

  initial begin
    // Step 1: Generate 5 AXI packets
    axi_packets = new[5]; // Allocate space for 5 packets
    for (int i = 0; i < axi_packets.size(); i++) begin
      axi_packets[i].addr = $urandom_range(0, 2**32-1); // Random address
      axi_packets[i].data = $urandom_range(0, 2**32-1); // Random data
      axi_packets[i].id = i;                            // Packet ID
      axi_packets[i].burst_type = $urandom_range(0, 2); // Random burst type (0, 1, or 2)
      $display("Generated Packet %0d - Addr: %h, Data: %h, ID: %0d, Burst: %0d",
               i, axi_packets[i].addr, axi_packets[i].data, axi_packets[i].id, axi_packets[i].burst_type);
    end

    // Step 2: Store packet statuses in an associative array
    foreach (axi_packets[i]) begin
      packet_status[axi_packets[i].id] = "Pending"; // Initially mark all packets as "Pending"
    end

    // Display the packet statuses
    $display("\nPacket Statuses:");
    int id;
    id = packet_status.first();
    while (id != null) begin
      $display("Packet ID: %0d, Status: %s", id, packet_status[id]);
      id = packet_status.next(id);
    end

    // Step 3: Process packets using a queue
    foreach (axi_packets[i]) begin
      processing_queue.push_back(axi_packets[i]); // Add packets to the processing queue
    end

    // Process packets one by one (FIFO order)
    $display("\nProcessing Packets:");
    while (!processing_queue.empty()) begin
      axi_packet_t packet = processing_queue.pop_front(); // Remove the first packet
      packet_status[packet.id] = "Processed";             // Update its status
      $display("Processed Packet ID: %0d, Addr: %h, Data: %h", packet.id, packet.addr, packet.data);
    end

    // Step 4: Display final statuses of all packets
    $display("\nFinal Packet Statuses:");
    id = packet_status.first();
    while (id != null) begin
      $display("Packet ID: %0d, Status: %s", id, packet_status[id]);
      id = packet_status.next(id);
    end
  end

endmodule
