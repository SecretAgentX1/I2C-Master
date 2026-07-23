`include "SCA.v"
module I2C_master (
    input wire clk_i,
    input wire rst_i,
    input wire m_w_r_i,
    input wire m_start_i,
    input wire m_stop_i,
    input wire [6:0] m_slave_add_i,
    input wire m_ack_i,
    input wire [7:0] m_data_i,
    output reg m_busy_o,
    output reg m_error_o,
    output reg m_data_ready_o,
    output reg [7:0] m_data_o,
    inout SDA,
    inout SCA
);
  localparam IDLE = 0, START = 1, WRITE_BYTE = 3,WRITE_ADDRESS= 2, RECV_ACK_NACK = 4, READ_BYTE = 5, SEND_ACK_NACK = 6,AFTER_ACK = 7, STOP = 8;
  reg [7:0] tmp_addr;
  reg [7:0] temp_data;
  reg [3:0] data_bits_counter;
  reg ack_bits_counter;


  reg Drive_flag;
  reg [3:0] current_state, next_state;
  // reg SCA_drive;

  reg  SCA_en;
  wire SCA_clk;

  // internal flags in I2C
  //   reg  start_flag;
  //   reg  write_flag;
  //   reg  recv_ack_flag;
  //   reg  stop_flag;
  //   reg  read_flag;
  //   reg  send_ack_nack;



  SCA sca (
      .clk(clk_i),
      .rst(rst_i),
      //   .en(SCA_en),
      .SCA_clk(SCA_clk)
  );



  always @(posedge clk_i or negedge rst_i) begin
    if (!rst_i) begin
      current_state <= IDLE;
      Drive_flag <= 1'b1;
      //   start_flag <= 0;
      //   write_flag <= 0;
      //   recv_ack_flag <= 0;
      data_bits_counter <= 0;
      //   read_flag <= 0;
      //   stop_flag <= 0;
      m_data_o <= 0;
      //   send_ack_nack <= 0;
      SCA_en <= 0;
      tmp_addr <= 0;
      temp_data <= 0;
      m_error_o <= 0;
      m_busy_o <= 0;
      m_data_ready_o <= 0;
      ack_bits_counter <= 0;
    end else begin
      current_state <= next_state;
    end
  end


  // i2c workflow
  always @(negedge SCA_clk) begin
    if (current_state == WRITE_ADDRESS) begin
      if (data_bits_counter != 8) Drive_flag <= tmp_addr[7-data_bits_counter];
      data_bits_counter <= data_bits_counter + 1;
      if (data_bits_counter == 8) begin
        Drive_flag <= 1;
        data_bits_counter <= 0;
      end


    end else if (current_state == WRITE_BYTE) begin
      m_error_o <= 0;
      ack_bits_counter <= 0;
      if (data_bits_counter != 8) Drive_flag <= temp_data[7-data_bits_counter];
      data_bits_counter <= data_bits_counter + 1;
      if (data_bits_counter == 8) begin
        Drive_flag <= 1;
        data_bits_counter <= 0;
        temp_data <= 0;
      end



    end else if (current_state == SEND_ACK_NACK) begin
      m_data_ready_o <= 0;
      Drive_flag <= m_ack_i;
    end else if (current_state == AFTER_ACK) Drive_flag <= 1;
  end

  always @(posedge SCA_clk) begin
    if (current_state == START) begin
      tmp_addr   <= {m_slave_add_i, m_w_r_i};
      temp_data  <= m_data_i;
      Drive_flag <= 0;
      m_busy_o   <= 1;


    end else if (current_state == RECV_ACK_NACK) begin
      m_error_o <= SDA;
      ack_bits_counter <= ack_bits_counter + 1;


    end else if (current_state == READ_BYTE) begin
      m_error_o <= 0;
      if (data_bits_counter != 8) temp_data <= {temp_data[6:0], SDA};
      data_bits_counter <= data_bits_counter + 1;
      if (data_bits_counter == 8) begin
        m_data_ready_o <= 1;
        m_data_o <= temp_data;
        temp_data <= 0;
        data_bits_counter <= 0;
      end



    end else if (current_state == STOP) begin
      Drive_flag <= 1;
      m_busy_o   <= 0;
    end

  end

  always @(*) begin
    case (current_state)
      IDLE: begin
        if (m_start_i) next_state = START;
        else begin
          next_state = IDLE;
        end
        SCA_en = 0;

      end
      START: begin
        if (m_stop_i) next_state = STOP;
        else begin
          next_state = Drive_flag ? START : WRITE_ADDRESS;
        end
        SCA_en = 1;

      end
      WRITE_ADDRESS: begin
        if (m_stop_i) next_state = STOP;
        else if (data_bits_counter == 0) begin
          next_state = RECV_ACK_NACK;
        end else next_state = WRITE_ADDRESS;
        SCA_en = 1;


      end
      WRITE_BYTE: begin
        if (m_stop_i) next_state = STOP;
        else if (data_bits_counter == 0) next_state = RECV_ACK_NACK;
        else next_state = WRITE_BYTE;
        SCA_en = 1;

      end
      RECV_ACK_NACK: begin
        if (m_stop_i) next_state = STOP;
        else if (ack_bits_counter == 1) next_state = tmp_addr[0] ? READ_BYTE : WRITE_BYTE;
        else next_state = RECV_ACK_NACK;
        SCA_en = 1;

      end
      READ_BYTE: begin
        if (m_stop_i) next_state = STOP;
        else if (data_bits_counter == 8) begin
          next_state = SEND_ACK_NACK;
        end else next_state = READ_BYTE;
        SCA_en = 1;


      end
      SEND_ACK_NACK: begin
        SCA_en = 1;
        if (m_stop_i) next_state = STOP;
        else next_state = AFTER_ACK;

      end
      AFTER_ACK: begin
        SCA_en = 1;
        if (m_stop_i) next_state = STOP;
        else next_state = tmp_addr[0] ? READ_BYTE : WRITE_BYTE;
      end
      STOP: begin
        SCA_en = 1;
        next_state = IDLE;



      end
      default: begin
        SCA_en = 0;
        next_state = IDLE;
      end

    endcase

  end



  assign SDA = Drive_flag ? 1'bz : 1'b0;
  assign SCA = SCA_en ? (SCA_clk ? 1'bz : 1'b0) : 1'bz;
endmodule
