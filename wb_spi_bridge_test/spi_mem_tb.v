`timescale 1ns / 1ps

module spi_mem_tb;
    // Declare the clock signal
    reg wb_clk;
    // Declare other inputs and outputs for your DUT as needed
    reg wb_rst;
	 reg [31:0] 	wb_mem_adr;
	 reg [31:0] 	wb_mem_dat;
 	 reg  [3:0] 	wb_mem_sel;
 	 reg  			wb_mem_we;
 	 reg  			wb_mem_stb;
	 wire [31:0] 	wb_mem_rdt;
    wire 			wb_mem_ack;
	 
	 integer i;

    // Instantiate the DUT
    spi_mem dut (
        .wb_clk(wb_clk),
        .wb_rst(wb_rst),
        .wb_mem_adr(wb_mem_adr),
        .wb_mem_dat(wb_mem_dat),
        .wb_mem_sel(wb_mem_sel),
        .wb_mem_we(wb_mem_we),
        .wb_mem_stb(wb_mem_stb),
        .wb_mem_rdt(wb_mem_rdt),
        .wb_mem_ack(wb_mem_ack)
    );

    // Generate the clock signal (50 MHz)
    initial begin
        wb_clk = 0; // Initialize clock to 0
        forever #10 wb_clk = ~wb_clk; // Toggle clock every 10 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        wb_rst = 1;
        wb_mem_adr = 0;
        wb_mem_dat = 0;
        wb_mem_sel = 4'h0;
        wb_mem_we = 0;
        wb_mem_stb = 0;

        // Hold reset for a few clock cycles
        #50;
        wb_rst = 0;
		  
		#20;

		$display("Write to consequtive addresses");
		
		// Write to consequtive addresses		
		wb_mem_sel = 4'hF;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*2;
			wb_mem_dat[15:8] = i*3;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*5;
			wb_mem_we = 1;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#20;
			wb_mem_stb = 0;
			#20;
		end

		#50;
		
		// Read and check from the written addresses
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat = 0;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[7:0] != i*2)
			$display("ERROR: Address %h: Byte 0 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[7:0]);
			if (wb_mem_rdt[15:8] != i*3)
			$display("ERROR: Address %h: Byte 1 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[15:8]);
			if (wb_mem_rdt[23:16] != i*4)
			$display("ERROR: Address %h: Byte 2 mismatch. Expected %h, got %h", i, i*4, wb_mem_rdt[23:16]);
			if (wb_mem_rdt[31:24] != i*5)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*5, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end
		#50;

		$display("Write to interleaving addresses");

		// Write to interleaving addresses		
		wb_mem_sel = 4'b1100;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*5;
			wb_mem_dat[15:8] = i*4;
			wb_mem_dat[23:16] = i*3;
			wb_mem_dat[31:24] = i*2;
			wb_mem_we = 1;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#20;
			wb_mem_stb = 0;
			#20;
		end
		
		// Read and check from the written addresses
		wb_mem_sel = 4'hF;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*2;
			wb_mem_dat[15:8] = i*3;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*5;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[7:0] != i*2)
			$display("ERROR: Address %h: Byte 0 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[7:0]);
			if (wb_mem_rdt[15:8] != i*3)
			$display("ERROR: Address %h: Byte 1 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[15:8]);
			if (wb_mem_rdt[23:16] != i*3)
			$display("ERROR: Address %h: Byte 2 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[23:16]);
			if (wb_mem_rdt[31:24] != i*2)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end

		$display("Reading interleaving addresses");

		// Read and check the addresses again to check if overwritten during writes		
		wb_mem_sel = 4'b1100;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat = 0;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[23:16] != i*3)
			$display("ERROR: Address %h: Byte 2 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[23:16]);
			if (wb_mem_rdt[31:24] != i*2)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end

		$display("Write to second addresses");

		// Write to second addresses		
		wb_mem_sel = 4'b0010;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*5;
			wb_mem_dat[15:8] = i*6;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*5;
			wb_mem_we = 1;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#20;
			wb_mem_stb = 0;
			#20;
		end
		
		// Read and check from the written addresses
		wb_mem_sel = 4'hF;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*2;
			wb_mem_dat[15:8] = i*3;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*5;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[7:0] != i*2)
			$display("ERROR: Address %h: Byte 0 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[7:0]);
			if (wb_mem_rdt[15:8] != i*6)
			$display("ERROR: Address %h: Byte 1 mismatch. Expected %h, got %h", i, i*6, wb_mem_rdt[15:8]);
			if (wb_mem_rdt[23:16] != i*3)
			$display("ERROR: Address %h: Byte 2 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[23:16]);
			if (wb_mem_rdt[31:24] != i*2)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end

		$display("Reading second address");

		// Read and check the addresses again to check if overwritten during writes		
		wb_mem_sel = 4'b0010;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat = 0;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[15:8] != i*6)
			$display("ERROR: Address %h: Byte 1 mismatch. Expected %h, got %h", i, i*6, wb_mem_rdt[15:8]);
			#10;
			wb_mem_stb = 0;
			#20;
		end

		$display("Write to last addresses");

		// Write to last addresses		
		wb_mem_sel = 4'b1000;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*5;
			wb_mem_dat[15:8] = i*4;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*7;
			wb_mem_we = 1;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#20;
			wb_mem_stb = 0;
			#20;
		end
		
		// Read and check from the written addresses
		wb_mem_sel = 4'hF;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat[7:0] = i*2;
			wb_mem_dat[15:8] = i*3;
			wb_mem_dat[23:16] = i*4;
			wb_mem_dat[31:24] = i*5;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[7:0] != i*2)
			$display("ERROR: Address %h: Byte 0 mismatch. Expected %h, got %h", i, i*2, wb_mem_rdt[7:0]);
			if (wb_mem_rdt[15:8] != i*6)
			$display("ERROR: Address %h: Byte 1 mismatch. Expected %h, got %h", i, i*6, wb_mem_rdt[15:8]);
			if (wb_mem_rdt[23:16] != i*3)
			$display("ERROR: Address %h: Byte 2 mismatch. Expected %h, got %h", i, i*3, wb_mem_rdt[23:16]);
			if (wb_mem_rdt[31:24] != i*7)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*7, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end

		$display("Reading last address");

		// Read and check the addresses again to check if overwritten during writes		
		wb_mem_sel = 4'b1000;
		for(i=0; i <= 32; i=i+4) begin
			wb_mem_adr = i;
			wb_mem_dat = 0;
			wb_mem_we = 0;
			wb_mem_stb = 1;
			@(posedge wb_mem_ack);
			#10
			if (wb_mem_rdt[31:24] != i*7)
			$display("ERROR: Address %h: Byte 3 mismatch. Expected %h, got %h", i, i*7, wb_mem_rdt[31:24]);
			#10;
			wb_mem_stb = 0;
			#20;
		end
		
		$display("Testbench completed");
        $finish; // End simulation
		  
	end
	
endmodule