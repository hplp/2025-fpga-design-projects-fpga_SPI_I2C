transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/serv_temp {D:/serv_temp/spi_mem.v}
vlog -vlog01compat -work work +incdir+D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi {D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi/servant_spi_slave_if.v}
vlog -vlog01compat -work work +incdir+D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi {D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi/servant_spi_ram.v}
vlog -vlog01compat -work work +incdir+D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi {D:/serv_temp/serv_spi_ram-add_initial_changes/serv_spi_ram-add_initial_changes/servant_spi/servant_spi_master_if.v}

vlog -vlog01compat -work work +incdir+D:/serv_temp {D:/serv_temp/spi_mem_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  spi_mem_tb

add wave *
view structure
view signals
run -all
