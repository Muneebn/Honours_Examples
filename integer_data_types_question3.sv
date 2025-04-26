
//Create a SystemVerilog module that simulates a sensor data processing system. The system should:
//Use shortint to store and manipulate sensor readings, including range checking.
//Use int to calculate the total and average of multiple sensor readings.
//Use byte to handle sensor status codes and perform bitwise operations.
//Use integer to perform operations on large aggregated data values.
//Display the results of these operations and include error messages where applicable.

module sensor_data_processing;
    // Declare variables
    shortint sensor_reading1, sensor_reading2, sensor_reading3, sensor_sum;
    int total_readings, average_reading;
    byte status_code1, status_code2, status_and, status_or
    integer aggregated_data1, aggregated_data2, aggregated_sum;
    string error_message;

    // Function to check if sensor reading is within a valid range
    function shortint check_sensor_range(shortint reading, output error);
        if (reading < -32768 || reading > 32767) begin
            error = "Sensor reading out of range";
            return 0;
        end else begin
            error = "";
            return reading;
        end
    endfunction

    initial begin
        // Initialize variables
        sensorreading1 = 15000;
        sensorreading2 = 20000;
        sensorreading3 = -10000;
        statuscode1 = 8'hF0; // Hexadecimal representation of 240
        statuscode2 = 8'h0F; // Hexadecimal representation of 15
        aggregated_data_1 = 1000000000;
        aggregated_data_2 = 2000000000;

        // Check sensor readings and calculate sum
        sensor_reading1 = check_sensor_range(sensor_reading1, error_message);
        if error_message != "") $display("Error: %s", error_message);

        sensor_reading2 = check_sensor_range(sensor_reading2, error_message);
        if (error_message != "") $display("Error: %s", error_message);

        sensor_reading3 = check_sensor_range(sensor_reading3, error_message);
        if error_message != "") $display("Error: %s", error_message);

        sensor_sum = sensor_reading1 + sensor_reading2 + sensor_reading3;
        $display("Sensor Sum (shortint): %0d", sensor_sum); // Output: 25000

        // Calculate total and average readings
        total_readings = sensor_reading1 + sensor_reading2 + sensor_reading3;
        average_reading = total_readings / 3;
        $display("Total Readings (int): %0d", total_readings); // Output: 25000
        $display("Average Reading (int): %0d", average_reading); // Output: 8333

        // Perform bitwise operations on status codes
        status_and = status_code1 & status_code2;
        status_or = status_code1 | status_code2;
        $display("Status AND (byte): %0h", status_and); // Output: 00
        $display("Status OR (byte): %0h", status_or); // Output: FF

        // Aggregate large data values
        aggregated_sum = aggregated_data1 + aggregated_data2;
        $display("Aggregated Sum (integer): %0d", aggregated_sum); // Output: 3000000000
    end
endmodule
