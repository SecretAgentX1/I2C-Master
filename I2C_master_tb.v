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
  assign SDA = wr == 1 ? wsda : 1'bz;
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

  integer i = 0;
  // assign SDA = SDA_assTest;
  assign test_SDA = (SDA === 1'bz) ? 1 : 0;
  assign test_SCA = (SCA === 1'bz) ? 1 : 0;
  // Tasks
  task write_byte;
    input [7:0] t_data_i;
    input [6:0] t_slave_add_i;
    input t_rst_i;
    begin
      wsda          = 0;
      wr            = 0;
      clk_i         = 0;
      rst_i         = t_rst_i;
      m_w_r_i       = 0;
      m_start_i     = 0;
      m_stop_i      = 0;
      m_slave_add_i = t_slave_add_i;
      m_ack_i       = 0;
      m_data_i      = t_data_i;

      #20;
      rst_i     = 1;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
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

      if (i == 0) $display("Write address passed");
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
      if (test_SDA == m_data_i[7]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[6]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[5]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[4]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[3]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[2]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[1]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[0]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end

      if (i == 0) $display("Write byte passed");
      else $display("Write byte failed");
      i = 0;


      // stopping

      @(negedge test_SCA) wsda = 'b0;
      wr = 1;
      // wsda = 1;
      @(posedge test_SCA);

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("stopped here");
    end
  endtask


  task read_byte;
    input [7:0] t_data_o;
    input [6:0] t_slave_add_i;
    input t_rst_i;
    begin
      wsda          = 0;
      wr            = 0;
      clk_i         = 0;
      rst_i         = t_rst_i;
      m_w_r_i       = 1;
      m_start_i     = 0;
      m_stop_i      = 0;
      m_slave_add_i = t_slave_add_i;
      m_ack_i       = 0;
      m_data_i      = 8'b00000000;

      @(posedge clk_i) $display("time: %0d -> start here", $time);
      rst_i = 1;
      m_stop_i = 0;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == 1) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end

      if (i == 0) $display("Write address passed");
      else $display("Write address failed");
      i = 0;

      // ACK
      @(negedge test_SCA) $display("time: %0t | this is ack after write address", $time);
      wsda = 'b0;
      wr   = 1;
      @(posedge test_SCA);
      $display("time: %0t | this is after ack", $time);

      // READ_BYTE
      @(negedge test_SCA);
      wsda = t_data_o[7];
      @(posedge test_SCA)
      if (SDA == t_data_o[7]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[6];
      @(posedge test_SCA)
      if (SDA == t_data_o[6]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[5];
      @(posedge test_SCA)
      if (SDA == t_data_o[5]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[4];
      @(posedge test_SCA)
      if (SDA == t_data_o[4]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[3];
      @(posedge test_SCA)
      if (SDA == t_data_o[3]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[2];
      @(posedge test_SCA)
      if (SDA == t_data_o[2]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[1];
      @(posedge test_SCA)
      if (SDA == t_data_o[1]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[0];
      @(posedge test_SCA)
      if (SDA == t_data_o[0]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge clk_i)
      if (m_data_o == t_data_o) $display("time = %0t | final read byte passed", $time);
      else $display("time = %0t | final read byte failed", $time);


      // send ack
      @(negedge test_SCA) m_ack_i = 1;






      // Stopping after reading

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_ack_i = 0;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("%0t stopped here", $time);

    end
  endtask

  task write_read;
    input [7:0] t_data_i;
    input [7:0] t_data_o;
    input [6:0] t_slave_add_i;
    input t_rst_i;
    begin
      wsda          = 0;
      wr            = 0;
      clk_i         = 0;
      rst_i         = 0;
      m_w_r_i       = 0;
      m_start_i     = 0;
      m_stop_i      = 0;
      m_slave_add_i = 7'b0100111;
      m_ack_i       = 0;
      m_data_i      = 8'b11001010;

      #20;
      rst_i = 1;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
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

      if (i == 0) $display("Write address passed");
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
      if (test_SDA == m_data_i[7]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[6]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[5]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[4]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[3]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[2]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[1]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[0]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end

      if (i == 0) $display("Write byte passed");
      else $display("Write byte failed");
      i = 0;

      // stopping

      @(negedge test_SCA) wsda = 'b0;
      wr = 1;
      // wsda = 1;
      @(posedge test_SCA);

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("stopped here");

      #90 @(posedge clk_i) $display("time: %0d -> start here", $time);
      m_stop_i  = 0;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == 1) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end

      if (i == 0) $display("Write address passed");
      else $display("Write address failed");
      i = 0;

      // ACK
      @(negedge test_SCA) $display("time: %0t | this is ack after write address", $time);
      wsda = 'b0;
      wr   = 1;
      @(posedge test_SCA);
      $display("time: %0t | this is after ack", $time);

      // READ_BYTE
      @(negedge test_SCA);
      wsda = t_data_o[7];
      @(posedge test_SCA)
      if (SDA == t_data_o[7]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[6];
      @(posedge test_SCA)
      if (SDA == t_data_o[6]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[5];
      @(posedge test_SCA)
      if (SDA == t_data_o[5]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[4];
      @(posedge test_SCA)
      if (SDA == t_data_o[4]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[3];
      @(posedge test_SCA)
      if (SDA == t_data_o[3]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[2];
      @(posedge test_SCA)
      if (SDA == t_data_o[2]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[1];
      @(posedge test_SCA)
      if (SDA == t_data_o[1]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[0];
      @(posedge test_SCA)
      if (SDA == t_data_o[0]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge clk_i)
      if (m_data_o == t_data_o) $display("time = %0t | final read byte passed", $time);
      else $display("time = %0t | final read byte failed", $time);



      // send ack
      @(negedge test_SCA) m_ack_i = 1;






      // Stopping after reading

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_ack_i = 0;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("%0t stopped here", $time);

    end
  endtask

  task read_write;
    input [7:0] t_data_i;
    input [7:0] t_data_o;
    input [6:0] t_slave_add_i;
    input t_rst_i;
    begin
      wsda          = 0;
      wr            = 0;
      clk_i         = 0;
      rst_i         = 0;
      m_w_r_i       = 1;
      m_start_i     = 0;
      m_stop_i      = 0;
      m_slave_add_i = t_slave_add_i;
      m_ack_i       = 0;
      m_data_i      = t_data_i;

      #20 @(posedge clk_i) $display("time: %0d -> start here", $time);
      rst_i = 1;
      m_stop_i = 0;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == 1) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end

      if (i == 0) $display("Write address passed");
      else $display("Write address failed");
      i = 0;

      // ACK
      @(negedge test_SCA) $display("time: %0t | this is ack after write address", $time);
      wsda = 'b0;
      wr   = 1;
      @(posedge test_SCA);
      $display("time: %0t | this is after ack", $time);

      // READ_BYTE
      @(negedge test_SCA);
      wsda = t_data_o[7];
      @(posedge test_SCA)
      if (SDA == t_data_o[7]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[6];
      @(posedge test_SCA)
      if (SDA == t_data_o[6]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[5];
      @(posedge test_SCA)
      if (SDA == t_data_o[5]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[4];
      @(posedge test_SCA)
      if (SDA == t_data_o[4]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[3];
      @(posedge test_SCA)
      if (SDA == t_data_o[3]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[2];
      @(posedge test_SCA)
      if (SDA == t_data_o[2]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[1];
      @(posedge test_SCA)
      if (SDA == t_data_o[1]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge test_SCA);
      wsda = t_data_o[0];
      @(posedge test_SCA)
      if (SDA == t_data_o[0]) $display("time = %0t | read byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | read byte failed", $time);
      end

      @(negedge clk_i)
      if (m_data_o == t_data_o) $display("time = %0t | final read byte passed", $time);
      else $display("time = %0t | final read byte failed", $time);



      // send ack
      @(negedge test_SCA) m_ack_i = 1;






      // Stopping after reading

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_ack_i = 0;
      m_w_r_i = 1;
      m_slave_add_i = 1;

      $display("%0t stopped here", $time);



      #100;
      @(posedge clk_i) $display("time: %0d -> start here", $time);
      m_stop_i = 0;
      m_w_r_i = 0;
      rst_i = 1;
      m_start_i = 1;
      m_slave_add_i = t_slave_add_i;
      m_data_i = t_data_i;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == t_slave_add_i[0]) $display("time = %0t | write address passed", $time);
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

      if (i == 0) $display("Write address passed");
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
      // @(negedge test_SCA);
      $display("%0t test here", $time);
      @(posedge test_SCA)
      if (test_SDA == m_data_i[7]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[6]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[5]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[4]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[3]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[2]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[1]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[0]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end

      if (i == 0) $display("Write byte passed");
      else $display("Write byte failed");
      i = 0;

      // stopping

      @(negedge test_SCA) wsda = 'b0;
      wr = 1;
      // wsda = 1;
      @(posedge test_SCA);

      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("stopped here");

      #90;

    end
  endtask

  task write_write;
    input [7:0] t_data_i;
    input [6:0] t_slave_add_i;
    input [7:0] t_data_i2;
    input t_rst_i;
    begin
      wsda          = 0;
      wr            = 0;
      clk_i         = 0;
      rst_i         = t_rst_i;
      m_w_r_i       = 0;
      m_start_i     = 0;
      m_stop_i      = 0;
      m_slave_add_i = t_slave_add_i;
      m_ack_i       = 0;
      m_data_i      = t_data_i;

      #20;
      rst_i     = 1;
      m_start_i = 1;
      @(negedge test_SDA);
      @(negedge test_SCA);
      $display("time = %0t | start passed", $time);
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[6]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[5]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[4]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[3]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[2]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[1]) $display("time = %0t | write address passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write address failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_slave_add_i[0]) $display("time = %0t | write address passed", $time);
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

      if (i == 0) $display("Write address passed");
      else $display("Write address failed");
      i = 0;



      // ACK
      @(negedge test_SCA);
      m_data_i = t_data_i2;
      wsda     = 'b0;
      wr       = 1;
      @(posedge test_SCA);

      // WRITE_BYTE
      @(negedge test_SCA);
      wr = 0;

      @(posedge test_SCA)
      if (test_SDA == m_data_i[7]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[6]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[5]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[4]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[3]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[2]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[1]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[0]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end

      if (i == 0) $display("Write byte passed");
      else $display("Write byte failed");
      i = 0;


      // ack

      @(negedge test_SCA) wsda = 'b0;
      wr = 1;
      // wsda = 1;
      @(posedge test_SCA);

      //write another byte
      @(negedge test_SCA);
      wr = 0;
      @(posedge test_SCA)
      if (test_SDA == m_data_i[7]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[6]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[5]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[4]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[3]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[2]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[1]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end
      @(posedge test_SCA)
      if (test_SDA == m_data_i[0]) $display("time = %0t | write byte passed", $time);
      else begin
        i = i - 1;
        $display("time = %0t | write byte failed", $time);
      end

      if (i == 0) $display("Write byte passed");
      else $display("Write byte failed");
      i = 0;


      // stopping

      @(negedge test_SCA) wsda = 'b0;
      wr = 1;
      // wsda = 1;
      @(posedge test_SCA);


      //Stopping 
      @(negedge test_SCA);
      wr = 0;
      wsda = 0;
      m_start_i = 0;
      m_stop_i = 1;
      m_w_r_i = 1;
      m_slave_add_i = 1;
      $display("stopped here");
    end
  endtask

  task read_read;
    input [7:0] t_data_o;
    input [7:0] t_data_o2;
    input [6:0] t_slave_add_i;
    input [6:0] t_slave_add_i2;
    input t_rst_i;
    begin
      read_byte(t_data_o, t_slave_add_i, 0);
      read_byte(t_data_o2, t_slave_add_i2, 0);
    end
  endtask

  localparam t_slave_add_i = 7'b1010111, t_data_i = 8'b00101100, t_rst_i = 0 , t_data_o = 8'b10111000,t_data_i2= 8'b01000111,t_slave_add_i2=7'b1011001,t_data_o2 = 8'b00101100;

  wire [1:0] W = 0, R = 1, WR = 2, RW = 3, WW = 4;

  wire [2:0] ChoiceOfTest = WR;
  always #10 clk_i = ~clk_i;
  initial begin
    // case (ChoiceOfTest)
    // write_byte(t_data_i, t_slave_add_i, 0);
    // read_byte(t_data_o, t_slave_add_i, 0);
    // write_read(t_data_i, t_data_o, t_slave_add_i, 0);
    // read_write(t_data_i, t_data_o, t_slave_add_i, 0);
    // write_write(t_data_i, t_slave_add_i, t_data_i2, 0);
    read_read(t_data_o, t_data_o2, t_slave_add_i, t_slave_add_i2, 0);

    //   default: write_byte(t_data_i, t_slave_add_i, 0);
    // endcase


    #90 #2000;
    $finish;



  end







endmodule
