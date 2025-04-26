typedef struct {
    logic [7:0]  id;
    logic [15:0] data;
    logic [31:0] timestamp;
} packet_t;

typedef union {
    logic [31:0] timestamp;
    packet_t packet;
} packet_or_timestamp_t;

module size_example;
    packet_t my_packet;
    packet_or_timestamp_t my_union;

    initial begin
        // Assign values to the struct
        my_packet.id = 8'hAA;
        my_packet.data = 16'h1234;
        my_packet.timestamp = 32'hDEADBEEF;

        // Assign values to the union
        my_union.packet = my_packet;

        // Print the sizes
        $display("Size of packet_t: %0d bytes", $bits(packet_t) / 8);
        $display("Size of packet_or_timestamp_t: %0d bytes", $bits(packet_or_timestamp_t) / 8);

        // Print the values
        $display("Struct - ID: %h, Data: %h, Timestamp: %h", my_packet.id, my_packet.data, my_packet.timestamp);
        $display("Union - Packet ID: %h, Packet Data: %h, Packet Timestamp: %h", my_union.packet.id, my_union.packet.data, my_union.packet.timestamp);
        $display("Union - Timestamp: %h", my_union.timestamp);
    end
endmodule
