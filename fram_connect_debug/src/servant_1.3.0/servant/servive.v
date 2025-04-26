`default_nettype none
module servive
(
 input wire 	   i_clk,
 input wire 	   i_rst_n,
 input wire       spi_miso,
 output wire      spi_sck,
 output wire      spi_ss,
 output wire      spi_mosi,
 output wire 	   q,
 output wire 	   uart_txd,
 output wire led1,
 output wire led2,
 output wire led3,
 output wire led4,
 output wire led5,
 output wire led6,
 output wire led7);

   parameter memfile = "zephyr_hello.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;

   assign uart_txd = q;

   servive_clock_gen clock_gen
     (.i_clk (i_clk),
      .i_rst (!i_rst_n),
      .o_clk (wb_clk),
      .o_rst (wb_rst));

   servant_spi_top
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .spi_miso(spi_miso),
      .spi_sck(spi_sck),
      .spi_ss(spi_ss),
      .spi_mosi(spi_mosi),
      .q      (q),
      .led1(led1),
      .led2(led2),
      .led3(led3),
      .led4(led4),
      .led5(led5),
      .led6(led6),
      .led7(led7));
		
	serial_out serial_out
		(.clk(i_clk),
       .reset_n(i_rst_n),
       .uart_tx(q));

endmodule
