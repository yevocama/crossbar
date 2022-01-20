# create modelsim working library
vlib work

# compile all the Verilog sources
vlog ../rtl/*.v
vlog ram_slave.v
vlog crossbar_tb.v

# open the testbench module for simulation
vsim crossbar_tb

# add all testbench signals to time diagram
add wave /crossbar_tb/clk
add wave /crossbar_tb/areset_n

add wave            /crossbar_tb/master_0_req
add wave -radix hex /crossbar_tb/master_0_addr
add wave            /crossbar_tb/master_0_cmd
add wave -radix hex /crossbar_tb/master_0_wdata
add wave -radix hex /crossbar_tb/master_0_ack
add wave -radix hex /crossbar_tb/master_0_rdata

add wave            /crossbar_tb/master_1_req
add wave -radix hex /crossbar_tb/master_1_addr
add wave            /crossbar_tb/master_1_cmd
add wave -radix hex /crossbar_tb/master_1_wdata
add wave -radix hex /crossbar_tb/master_1_ack
add wave -radix hex /crossbar_tb/master_1_rdata

add wave            /crossbar_tb/master_2_req
add wave -radix hex /crossbar_tb/master_2_addr
add wave            /crossbar_tb/master_2_cmd
add wave -radix hex /crossbar_tb/master_2_wdata
add wave -radix hex /crossbar_tb/master_2_ack
add wave -radix hex /crossbar_tb/master_2_rdata

add wave            /crossbar_tb/master_3_req
add wave -radix hex /crossbar_tb/master_3_addr
add wave            /crossbar_tb/master_3_cmd
add wave -radix hex /crossbar_tb/master_3_wdata
add wave -radix hex /crossbar_tb/master_3_ack
add wave -radix hex /crossbar_tb/master_3_rdata

add wave            /crossbar_tb/slave_0_req
add wave -radix hex /crossbar_tb/slave_0_addr
add wave            /crossbar_tb/slave_0_cmd
add wave -radix hex /crossbar_tb/slave_0_wdata
add wave -radix hex /crossbar_tb/slave_0_ack
add wave -radix hex /crossbar_tb/slave_0_rdata

add wave            /crossbar_tb/slave_1_req
add wave -radix hex /crossbar_tb/slave_1_addr
add wave            /crossbar_tb/slave_1_cmd
add wave -radix hex /crossbar_tb/slave_1_wdata
add wave -radix hex /crossbar_tb/slave_1_ack
add wave -radix hex /crossbar_tb/slave_1_rdata

add wave            /crossbar_tb/slave_2_req
add wave -radix hex /crossbar_tb/slave_2_addr
add wave            /crossbar_tb/slave_2_cmd
add wave -radix hex /crossbar_tb/slave_2_wdata
add wave -radix hex /crossbar_tb/slave_2_ack
add wave -radix hex /crossbar_tb/slave_2_rdata

add wave            /crossbar_tb/slave_3_req
add wave -radix hex /crossbar_tb/slave_3_addr
add wave            /crossbar_tb/slave_3_cmd
add wave -radix hex /crossbar_tb/slave_3_wdata
add wave -radix hex /crossbar_tb/slave_3_ack
add wave -radix hex /crossbar_tb/slave_3_rdata

add wave -radix hex /crossbar_tb/ram_slave_0/mem
add wave -radix hex /crossbar_tb/ram_slave_1/mem
add wave -radix hex /crossbar_tb/ram_slave_2/mem
add wave -radix hex /crossbar_tb/ram_slave_3/mem

# run the simulation
run -all
wave zoom full
