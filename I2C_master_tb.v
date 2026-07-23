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
  always #10 clk_i = ~clk_i;
  initial begin
    clk_i         = 0;
    rst_i         = 0;
    m_w_r_i       = 0;
    m_start_i     = 0;
    m_stop_i      = 0;
    m_slave_add_i = 0;
    m_ack_i       = 0;
    m_data_i      = 8'hA5;

    #20;
    rst_i = 1;

    #20;
    m_start_i = 1;
    m_slave_add_i = 1;

    #10;
    m_start_i = 0;
    m_slave_add_i = 0;

    #100;
    m_ack_i = 1;

    #10;
    m_ack_i = 0;

    #50;
    m_stop_i = 1;

    #10;
    m_stop_i = 0;

    #100;
    $finish;
  end

endmodule
