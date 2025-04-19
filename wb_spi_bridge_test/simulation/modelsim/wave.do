onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_mem_tb/wb_clk
add wave -noupdate /spi_mem_tb/wb_rst
add wave -noupdate /spi_mem_tb/wb_mem_adr
add wave -noupdate /spi_mem_tb/wb_mem_dat
add wave -noupdate /spi_mem_tb/wb_mem_sel
add wave -noupdate /spi_mem_tb/wb_mem_we
add wave -noupdate /spi_mem_tb/wb_mem_stb
add wave -noupdate /spi_mem_tb/wb_mem_rdt
add wave -noupdate /spi_mem_tb/wb_mem_ack
add wave -noupdate /spi_mem_tb/i
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_slave_if/sAddress
add wave -noupdate /spi_mem_tb/dut/spi_slave_if/sCSn
add wave -noupdate /spi_mem_tb/dut/spi_slave_if/sOEn
add wave -noupdate /spi_mem_tb/dut/spi_slave_if/sWRn
add wave -noupdate /spi_mem_tb/dut/spi_slave_if/sDqDir
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_slave_if/sDqOut
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_slave_if/sDqIn
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_miso
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_sck
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_ss
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_mosi
add wave -noupdate /spi_mem_tb/dut/spi_master_if/serial_clk
add wave -noupdate -radix unsigned /spi_mem_tb/dut/spi_master_if/clk_cnt
add wave -noupdate -radix unsigned /spi_mem_tb/dut/spi_master_if/bit_cnt
add wave -noupdate /spi_mem_tb/dut/spi_master_if/state
add wave -noupdate /spi_mem_tb/dut/spi_master_if/wr_cmd
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_master_if/address_reg
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_master_if/wr_data_reg
add wave -noupdate -radix hexadecimal /spi_mem_tb/dut/spi_master_if/rd_data_reg
add wave -noupdate /spi_mem_tb/dut/spi_master_if/byte_offset
add wave -noupdate /spi_mem_tb/dut/spi_master_if/num_bytes
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_out_reg
add wave -noupdate /spi_mem_tb/dut/spi_master_if/spi_in_reg
add wave -noupdate /spi_mem_tb/dut/spi_master_if/sel_dec_offset
add wave -noupdate /spi_mem_tb/dut/spi_master_if/sel_dec_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69317 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 106
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {245760 ps}
