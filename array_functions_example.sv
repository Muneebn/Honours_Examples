module array_functions_example;

  // Associative array for IoT devices (Device name as key, and status as value)
  string device_status[string]; // Associative array
  // Dynamic array for temperatures logged at different times
  real temperature_logs[];
  // Queue for recent notifications
  string notifications[$];

  initial begin
    // ---- DYNAMIC ARRAY FUNCTIONS ----
    // Allocate and log temperatures at different intervals
    temperature_logs = new[3];
    temperature_logs[0] = 24.5; // Temperature at Time 0
    temperature_logs[1] = 26.3; // Temperature at Time 1
    temperature_logs[2] = 23.8; // Temperature at Time 2

    // Display the size of the dynamic array
    $display("Initial Temperature Logs Size: %0d", temperature_logs.size());

    // Add a new temperature log dynamically
    temperature_logs.push_back(25.6); // Add temperature for Time 3
    $display("Temperature Logs After Push: %p", temperature_logs);

    // Sort the temperature logs
    temperature_logs.sort();
    $display("Sorted Temperature Logs: %p", temperature_logs);

    // Reverse the temperature logs
    temperature_logs.reverse();
    $display("Reversed Temperature Logs: %p", temperature_logs);

    // Remove duplicate temperatures
    temperature_logs.unique();
    $display("Unique Temperature Logs: %p", temperature_logs);

    // ---- ASSOCIATIVE ARRAY FUNCTIONS ----
    // Add devices to the IoT system
    device_status["LivingRoomLight"] = "ON";
    device_status["MainThermostat"] = "OFF";
    device_status["SecurityCamera"] = "Recording";

    // Check if a specific device exists
    if (device_status.exists("MainThermostat")) begin
      $display("MainThermostat Exists with Status: %s", device_status["MainThermostat"]);
    end

    // Iterate over the associative array and display all devices
    string device_name;
    device_name = device_status.first();
    $display("\nAll Device Statuses:");
    while (device_name != null) begin
      $display("Device: %s, Status: %s", device_name, device_status[device_name]);
      device_name = device_status.next(device_name);
    end

    // Delete a specific device
    device_status.delete("MainThermostat");
    if (!device_status.exists("MainThermostat")) begin
      $display("MainThermostat has been deleted.");
    end

    // Display the size of the associative array
    $display("Total Devices After Deletion: %0d", device_status.size());

    // ---- QUEUE FUNCTIONS ----
    // Add notifications to the queue
    notifications.push_back("LivingRoomLight turned ON");
    notifications.push_back("MainThermostat turned OFF");
    notifications.push_back("SecurityCamera started recording");

    // Display the size of the notification queue
    $display("\nInitial Notification Queue Size: %0d", notifications.size());

    // Pop the first notification (FIFO behavior)
    $display("First Notification: %s", notifications.pop_front());

    // Insert a new notification at position 1
    notifications.insert(1, "GarageDoor opened");
    $display("Notifications After Insert: %p", notifications);

    // Remove the last notification (LIFO behavior)
    $display("Last Notification Removed: %s", notifications.pop_back());

    // Sort the notification queue alphabetically
    notifications.sort();
    $display("Sorted Notifications: %p", notifications);

    // Reverse the notification queue
    notifications.reverse();
    $display("Reversed Notifications: %p", notifications);
  end

endmodule
