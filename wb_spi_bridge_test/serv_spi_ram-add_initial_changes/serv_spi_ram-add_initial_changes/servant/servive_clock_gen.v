`default_nettype none
module servive_clock_gen
  (input wire i_clk,
   input wire i_rst,
   input wire i_btn,
   output reg o_clk,
   output wire o_rst,
   output wire o_btn);

   wire        locked;
   reg [9:0]   r;
   reg [9:0]   b;

   assign o_rst = r[9];
   assign o_btn = b[9];

   always @(posedge o_clk) begin
       r <= {r[8:0],i_rst};
       b <= {b[8:0],i_btn};
   end

  //  wire [5:0] 	  clk;

  //  assign 	  o_clk = clk[0];

   localparam integer MAX_COUNT = 1_562_500 - 1;

    reg [21:0] counter; // 22 bits needed to count up to 1,562,499

    always @(posedge i_clk) begin
        if (counter >= MAX_COUNT) begin
            counter <= 22'h0;
            o_clk <= ~o_clk; // Toggle output clock
        end else begin
            counter <= counter + 22'h1;
        end
    end

  //  altpll
  //    #(.operation_mode         ("NORMAL"),
  //      .clk0_divide_by         (500),
  //      .clk0_multiply_by       (16),
  //      .inclk0_input_frequency (20000))
  //  pll
  //    (.areset       (i_rst),
  //     .inclk        ({1'b0, i_clk}),
  //     .clk          (clk),
  //     .locked       (locked));

endmodule
