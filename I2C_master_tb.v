`include "I2C_master.v"
module I2C_master_tb;

  reg clk_i;
  reg rst_i;
  reg m_w_r_i;
  reg m_start_i;
  reg m_stop_i;
  reg [6:0] m_slave_add_i;
  reg m_ack_i;
  reg [7:0] m_data_i;
  wire m_busy_o;
  wire m_error_o;
  wire m_data_ready_o;
  wire [7:0] m_data_o;
  wire SDA;
  wire SCA;
  reg wsda;
  reg wr;
  // assign SDA = wr == 1 ? wsda : 1'bz;
  I2C_master DUT (
      .clk_i(clk_i),
      .rst_i(rst_i),
      .m_w_r_i(m_w_r_i),
      .m_start_i(m_start_i),
      .m_stop_i(m_stop_i),
      .m_slave_add_i(m_slave_add_i),
      .m_ack_i(m_ack_i),
      .m_data_i(m_data_i),
      .m_busy_o(m_busy_o),
      .m_error_o(m_error_o),
      .m_data_ready_o(m_data_ready_o),
      .m_data_o(m_data_o),
      .SDA(SDA),
      .SCA(SCA)
  );
  wire test_SDA;
  wire test_SCA;
  // reg SDA_assTest;

  integer i = 1;
  // assign SDA = SDA_assTest;
  assign test_SDA = (SDA === 1'bz) ? 1 : 0;
  assign test_SCA = (SCA === 1'bz) ? 1 : 0;

  always #10 clk_i = ~clk_i;
  initial begin
    wsda          = 0;
    wr            = 0;
    clk_i         = 0;
    rst_i         = 0;
    m_w_r_i       = 0;
    m_start_i     = 0;
    m_stop_i      = 0;
    m_slave_add_i = 7'b1100111;
    m_ack_i       = 0;
    m_data_i      = 8'b11001010;

    #20;
    rst_i = 1;
    m_start_i = 1;
    @(negedge test_SDA);
    @(negedge test_SCA);
    $display("time = %0t | start passed", $time);
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write address passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write address failed", $time);
    end

    if (i == 1) $display("Write address passed");
    else $display("Write address failed");
    i = 0;



    // ACK
    @(negedge test_SCA);
    wsda = 'b0;
    wr   = 1;
    @(posedge test_SCA);

    // WRITE_BYTE
    @(negedge test_SCA);
    wr = 0;
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b0) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 'b1) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end
    @(posedge test_SCA)
    if (test_SDA == 0) $display("time = %0t | write byte passed", $time);
    else begin
      i = i - 1;
      $display("time = %0t | write byte failed", $time);
    end

    if (i == 0) $display("Write byte passed");
    else $display("Write byte failed");
    i = 0;



    #2000;
    $finish;
  end

endmodule
