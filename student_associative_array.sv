module student_score_tracker;

  // Associative array with integer keys for student IDs
  logic [7:0] scores[int]; // Key: Student ID (integer), Value: Score (8-bit)

  initial begin
    // Adding scores for students
    scores[101] = 85;  // Student ID 101 scored 85
    scores[102] = 92;  // Student ID 102 scored 92
    scores[103] = 78;  // Student ID 103 scored 78

    // Accessing and displaying scores
    $display("Score of Student 101: %0d", scores[101]);
    $display("Score of Student 102: %0d", scores[102]);
    $display("Score of Student 103: %0d", scores[103]);

    // Updating a student's score
    scores[103] = 88; // Update Student ID 103's score
    $display("Updated Score of Student 103: %0d", scores[103]);

    // Iterating through student IDs and their scores (manual key listing)
    $display("\nAll Student Scores:");
    $display("Student ID: 101, Score: %0d", scores[101]);
    $display("Student ID: 102, Score: %0d", scores[102]);
    $display("Student ID: 103, Score: %0d", scores[103]);

    // Manually removing a student's record
    scores[102] = 0; // Example: Setting score to 0 indicates removal
    $display("\nStudent ID 102's score is now: %0d (record removed)", scores[102]);
  end

endmodule
