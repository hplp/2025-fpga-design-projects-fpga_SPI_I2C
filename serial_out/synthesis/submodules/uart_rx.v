module uart_rx (
    input wire clk,          // System clock
    input wire reset_n,      // Active-low reset
    input wire rx,           // UART_TX line
    output reg [7:0] data,   // Captured data byte
    output reg valid         // Data valid flag
);
    parameter BAUD_TICKS = 28781; // Adjust for your baud rate (e.g., 115200 baud @ 50 MHz)

    //with_spi: 2:28781, 16:168781 without_spi: 878
    
    reg [31:0] counter;
    reg [3:0] bit_index;
    reg [9:0] shift_reg;
    reg rx_busy;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 0;
            bit_index <= 0;
            rx_busy <= 0;
            shift_reg <= 0;
            valid <= 0;
        end else begin
            valid <= 0;
            if (!rx_busy && !rx) begin
                // Start bit detected
                rx_busy <= 1;
                counter <= 0;
                bit_index <= 0;
            end else if (rx_busy) begin
                counter <= counter + 1;
                if (counter == BAUD_TICKS/2 && bit_index == 0) begin
                    counter <= 0;
                    bit_index <= bit_index + 1;
                    if (rx) begin
                        rx_busy <= 0;
                    end
                end
                else if (counter == BAUD_TICKS - 1) begin
                    counter <= 0;
                    shift_reg <= {rx, shift_reg[9:1]};
                    bit_index <= bit_index + 1;
                    if (bit_index == 10) begin
                        rx_busy <= 0;
                        data <= shift_reg[8:1];
                        valid <= 1;
                    end
                end
            end
        end
    end
endmodule
