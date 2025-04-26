class Driver;
  virtual interface AdderInterface vif;

  function new(virtual interface AdderInterface vif);
    this.vif = vif;
  endfunction

  task drive_input(Transaction trans);
    vif.a = trans.a;
    vif.b = trans.b;
    #10; // Wait for the DUT to compute
  endtask
endclass
