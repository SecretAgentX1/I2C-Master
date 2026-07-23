module SCA (
    input  wire clk,
    input  wire rst,
    // input  wire en,
    output reg  SCA_clk
);

  always @(posedge clk, negedge rst) begin
    if (!rst) begin
      SCA_clk <= 1'b1;
    end else SCA_clk <= ~SCA_clk;

  end

endmodule
