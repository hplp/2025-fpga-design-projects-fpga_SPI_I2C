`default_nettype none
module spi_mem
(
 input wire  i_clk,
 input wire  i_rst_n,
 input wire  i_btn_n,
 input wire  spi_miso,
 output wire spi_sck,
 output wire spi_ss,
 output wire spi_mosi,
 output wire wb_clk_l,
 output wire spi_miso_l,
 output wire spi_sck_l,
 output wire spi_ss_l,
 output wire spi_mosi_l,
 output reg done,
 output reg correct,
 output wire btn_test);


   reg [31:0] 	wb_mem_adr = 0;
   reg [31:0] 	wb_mem_dat = 0;
   reg [3:0] 	wb_mem_sel = 0;
   reg 	wb_mem_we = 0;
   reg 	wb_mem_stb = 0;
   wire [31:0] 	wb_mem_rdt;
   wire 	wb_mem_ack;

   wire wb_clk, wb_rst;
   reg temp_btn;
   wire  wb_btn;
   wire posedge_btn;

   reg [4:0] state = 4;
   
 assign wb_clk_l   = wb_clk;
 assign spi_sck_l  = spi_sck;
 assign spi_ss_l   = spi_ss;
 assign spi_mosi_l = spi_mosi;
 assign spi_miso_l = spi_miso;
 assign btn_test   = wb_mem_ack;
 assign posedge_btn = wb_btn & ~temp_btn;

  always @(posedge wb_clk) begin
    temp_btn <= wb_btn;
  end

 servive_clock_gen clock_gen
     (.i_clk (i_clk),
      .i_rst (!i_rst_n),
      .i_btn (!i_btn_n),
      .o_clk (wb_clk),
      .o_rst (wb_rst),
      .o_btn (wb_btn));
   
  servant_spi_master_if
    #(.ADDRESS_WIDTH(24),
      .CLOCK_DIVIDER(2))
  spi_master_if
    (// Wishbone Slave Interface
      .clock(wb_clk),
      .reset(wb_rst),
      .wr_data(wb_mem_dat),
      .address(wb_mem_adr[23:2]),
      .wb_sel(wb_mem_sel),
      .wb_we(wb_mem_we),
      .wb_cyc(wb_mem_stb),
      .rd_data(wb_mem_rdt),
      .wb_ack(wb_mem_ack),
      .configed_out(),
    // SPI Master Interface
      .spi_miso(spi_miso),
      .spi_sck(spi_sck),
      .spi_ss(spi_ss),
      .spi_mosi(spi_mosi));

  // always @(posedge wb_btn or posedge wb_rst) begin
  //   if (wb_rst) begin
  //     btn_test <= 1'b0;
  //   end else if (wb_btn) begin 
  //     btn_test <= ~btn_test;
  //   end else begin
  //     btn_test <= btn_test;
  //   end
  // end

  always @(posedge wb_clk) begin
		if (wb_rst) begin
      state <= 4;
      wb_mem_adr <= 0;
      wb_mem_dat <= 0;
      wb_mem_sel <= 0;
      wb_mem_we  <= 0;
      wb_mem_stb <= 0;
      done <= 1;
      correct <= 1;
    end else begin
      case (state)
        0: begin
          if (posedge_btn) begin
            state <= 1;
            wb_mem_adr <= 32'h0;
            wb_mem_dat <= 32'h0;
            wb_mem_sel <= 4'b0000;
            wb_mem_we  <= 1;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 0;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        1: begin
          if (wb_mem_ack) begin
            state <= 2;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= 1;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        2: begin
          if (posedge_btn) begin
            state <= 3;
            wb_mem_adr <= 32'h0;
            wb_mem_dat <= 32'h0;
            wb_mem_sel <= 4'b0000;
            wb_mem_we  <= 0;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 2;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        3: begin
          if (wb_mem_ack) begin
            state <= 6;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            if (wb_mem_rdt[7:0] == 8'b10) correct <= 1;
            else correct <= 0;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        4: begin
          if (posedge_btn) begin
            state <= 5;
            wb_mem_adr <= 32'h82e0;
            wb_mem_dat <= 32'h12345678;
            wb_mem_sel <= 4'b0100;
            wb_mem_we  <= 1;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 4;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        5: begin
          if (wb_mem_ack) begin
            state <= 2;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= 1;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        6: begin
          if (posedge_btn) begin
            state <= 7;
            wb_mem_adr <= 32'h82e0;
            wb_mem_dat <= 32'h0;
            wb_mem_sel <= 4'b1111;
            wb_mem_we  <= 0;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 6;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        7: begin
          if (wb_mem_ack) begin
            state <= 8;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            if (wb_mem_rdt[31:0] == 32'h00340000) correct <= 1;
            else correct <= 0;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        8: begin
          if (posedge_btn) begin
            state <= 9;
            wb_mem_adr <= 32'h82e0;
            wb_mem_dat <= 32'h12005678;
            wb_mem_sel <= 4'b1111;
            wb_mem_we  <= 1;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 8;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        9: begin
          if (wb_mem_ack) begin
            state <= 10;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= 1;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        10: begin
          if (posedge_btn) begin
            state <= 11;
            wb_mem_adr <= 32'h82e0;
            wb_mem_dat <= 32'h0;
            wb_mem_sel <= 4'b0010;
            wb_mem_we  <= 0;
            wb_mem_stb <= 1;
            done <= 0;
            correct <= 0;
          end else begin
            state <= 10;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            correct <= correct;
          end
        end
        11: begin
          if (wb_mem_ack) begin
            state <= 4;
            wb_mem_adr <= 0;
            wb_mem_dat <= 0;
            wb_mem_sel <= 0;
            wb_mem_we  <= 0;
            wb_mem_stb <= 0;
            done <= 1;
            if (wb_mem_rdt[31:0] == 32'h00345600) correct <= 1;
            else correct <= 0;
          end else begin
            state <= state;
            wb_mem_adr <= wb_mem_adr;
            wb_mem_dat <= wb_mem_dat;
            wb_mem_sel <= wb_mem_sel;
            wb_mem_we  <= wb_mem_we ;
            wb_mem_stb <= wb_mem_stb;
            done <= done;
            correct <= correct;
          end
        end
        default: begin
          state <= 4;
          wb_mem_adr <= 0;
          wb_mem_dat <= 0;
          wb_mem_sel <= 0;
          wb_mem_we  <= 0;
          wb_mem_stb <= 0;
          done <= 1;
          correct <= 1;
        end
		  endcase
    end
	end

endmodule
