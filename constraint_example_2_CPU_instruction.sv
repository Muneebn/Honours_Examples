class CPUInstruction;
  rand bit [31:0] opcode;          // 32-bit opcode
  rand bit [7:0] source_reg;       // 8-bit source register ID
  rand bit [7:0] dest_reg;         // 8-bit destination register ID
  rand bit [15:0] imm_val;         // Immediate value (constant)
  rand bit [7:0] inst_type;        // Instruction type (0=Arithmetic, 1=Logic, 2=Load/Store)
  rand bit [15:0] program_counter; // Program counter

  // 1. Simple Constraint: Opcode must be non-zero
  constraint non_zero_opcode {
    opcode != 0;
  }

  // 2. Range Constraint: Immediate value must be in the range of -128 to 127 (signed value)
  constraint imm_range {
    imm_val inside {[-128:127]};
  }

  // 3. Weighted Constraint: Distribution of instruction types
  // Arithmetic (0) = 40%, Logic (1) = 30%, Load/Store (2) = 30%
  constraint inst_weighted {
    inst_type dist {0 := 40, 1 := 30, 2 := 30};
  }

  // 4. Conditional Constraint: If instruction type is Load/Store, the program counter must be aligned to 4
  constraint load_store_pc_alignment {
    inst_type == 2 -> program_counter % 4 == 0;
  }

  // 5. Iterative Constraint: Ensure source and destination registers are not the same across multiple instructions
  constraint reg_constraint {
    source_reg != dest_reg;
  }

  // 6. Soft Constraint: Prefer source register IDs to be lower than 32 (can be ignored if conflict occurs)
  constraint source_reg_pref {
    soft source_reg < 32;
  }

  // 7. Debugging and Randomization Conflicts
  function void debug();
    if (!this.randomize()) begin
      $display("Randomization failed: Conflicting constraints!");
    end else begin
      $display("Randomization succeeded!");
    end
  endfunction
endclass

module testbench;
  initial begin
    CPUInstruction inst = new();

    // Generate multiple instructions
    for (int i = 0; i < 5; i++) begin
      inst.debug(); // Handle potential randomization failures
      $display("\nInstruction %0d:", i + 1);
      $display("  Opcode              : %h", inst.opcode);
      $display("  Source Register     : %0d", inst.source_reg);
      $display("  Destination Register: %0d", inst.dest_reg);
      $display("  Immediate Value     : %0d", inst.imm_val);
      $display("  Instruction Type    : %0d (0=Arithmetic, 1=Logic, 2=Load/Store)", inst.inst_type);
      $display("  Program Counter     : %0d", inst.program_counter);
    end
  end
endmodule

