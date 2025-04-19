`timescale 1ns / 1ps
module servant_tb;

   parameter memfile = "D:/serv_project/build/servant_1.3.0/without_spi/src/servant_1.3.0/sw/hello_uart.hex";
   parameter memsize = 32768;
   parameter width = 1;
   parameter with_csr = 1;

   localparam baud_rate =
	      (width == 4) ? 57600*3 :
	      57600;

   reg wb_clk = 1'b0;
   reg wb_rst = 1'b0;

   wire q;

   always  #31 wb_clk <= !wb_clk;
   initial #62 wb_rst <= 1'b1;

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
