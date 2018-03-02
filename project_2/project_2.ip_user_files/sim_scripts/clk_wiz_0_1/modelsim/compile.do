vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../../week3.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0_sim_netlist.vhdl" \


