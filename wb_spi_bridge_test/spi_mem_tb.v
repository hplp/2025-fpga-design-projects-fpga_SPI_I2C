`timescale 1ns / 1ps

module spi_mem_tb;
    // Declare the clock signal
	reg i_clk     ;
	reg i_rst_n   ;
	reg i_btn_n   ;
	wire spi_miso  ;
	wire spi_sck   ;
	wire spi_ss    ;
	wire spi_mosi  ;
	wire wb_clk_l  ;
	wire spi_miso_l;
	wire spi_sck_l ;
	wire spi_ss_l  ;
	wire spi_mosi_l;
	wire done      ;
	wire correct   ;
	wire btn_test  ;

   wire [17:0] ram_addr;
   wire [7:0] ram_wdata;
   wire ram_we;
   wire ram_re;
   reg [7:0] ram_rdata;
	 
	 integer i;

    // Instantiate the DUT
    spi_mem dut (
      .i_clk     (i_clk     ),
      .i_rst_n   (i_rst_n   ),
      .i_btn_n   (i_btn_n   ),
      .spi_miso  (spi_miso  ),
      .spi_sck   (spi_sck   ),
      .spi_ss    (spi_ss    ),
      .spi_mosi  (spi_mosi  ),
      .wb_clk_l  (wb_clk_l  ),
      .spi_miso_l(spi_miso_l),
      .spi_sck_l (spi_sck_l ),
      .spi_ss_l  (spi_ss_l  ),
      .spi_mosi_l(spi_mosi_l),
      .done      (done      ),
      .correct   (correct   ),
      .btn_test  (btn_test  )
    );

	
	servant_spi_slave_if
	#(.ADDRESS_WIDTH(18))
	spi_slave_if
	(//spi interface
		.spi_sck(spi_sck),
		.spi_cs(spi_ss),
		.spi_mosi(spi_mosi),
		.spi_miso(spi_miso), 
	//ram interface  
		.sAddress(ram_addr),
		.sCSn(),
		.sOEn(ram_re),
		.sWRn(ram_we),
		.sDqDir(),
		.sDqOut(ram_wdata),
		.sDqIn(ram_rdata));

    // Generate the clock signal (50 MHz)
    initial begin
        i_clk = 0; // Initialize clock to 0
        forever #10 i_clk = ~i_clk; // Toggle clock every 10 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        i_rst_n  = 1'b0;
		i_btn_n  = 1'b1;

        // Hold reset for a few clock cycles
        #50;
        i_rst_n = 1'b1;
		#50;

		for(i=0; i < 5; i=i+1) begin
			$display("Button press %d",i);
			i_btn_n  = 1'b0;
			@(negedge done);
			i_btn_n  = 1'b1;
			if(i==2) begin
				@(negedge ram_re);
				@(negedge ram_re);
				ram_rdata = 8'h0;
				@(negedge ram_re);
				ram_rdata = 8'h0;
				@(negedge ram_re);
				ram_rdata = 8'h34;
				@(negedge ram_re);
				ram_rdata = 8'h0;
			end else if (i==4) begin
				@(negedge ram_re);
				@(negedge ram_re);
				ram_rdata = 8'h56;
			end
			@(posedge done);
			if(!correct) $display("ERROR at button press %d",i);
			#40;
		end
		
		$display("Testbench completed");
        $finish; // End simulation
		  
	end
	
endmodule