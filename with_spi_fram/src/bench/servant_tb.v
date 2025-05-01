`timescale 1ns / 1ps
module servant_tb;

   parameter memfile = "D:/Github/2025-fpga-design-projects-fpga_SPI_I2C/with_spi_fram/src/servant_1.3.0/sw/test.hex";
   parameter memsize = 262144;
   parameter width = 1;
   parameter with_csr = 1;

   localparam baud_rate =
	      (width == 4) ? 57600*3 :
	      57600;

   reg wb_clk = 1'b0;
   reg wb_rst = 1'b0;

   wire q;

   always  #10 wb_clk <= !wb_clk;
   initial #10 wb_rst <= 1'b1;

//   vlog_tb_utils vtu();

   //uart_decoder #(baud_rate) uart_decoder (q);

   servive
     #(.memfile  (memfile),
       .memsize  (memsize))
   dut
     (.i_clk (wb_clk),
      .i_rst_n (wb_rst),
      .q      (q));

endmodule
