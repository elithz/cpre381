onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /projectb/clock
add wave -noupdate /projectb/regf_rst
add wave -noupdate /projectb/imem_wren
add wave -noupdate /projectb/PC_rst
add wave -noupdate /projectb/if_id_reset
add wave -noupdate /projectb/id_ex_reset
add wave -noupdate /projectb/ex_mem_reset
add wave -noupdate /projectb/mem_wb_reset
add wave -noupdate /projectb/stallsAndFlashes
add wave -noupdate /projectb/byteena
add wave -noupdate /projectb/data
add wave -noupdate /projectb/give00
add wave -noupdate /projectb/giveFourtoThisPin
add wave -noupdate /projectb/alu0
add wave -noupdate /projectb/wbregdest
add wave -noupdate /projectb/wbinstr
add wave -noupdate /projectb/wbpcp4
add wave -noupdate -expand /projectb/b2v_inst/registers
add wave -noupdate /projectb/b2v_inst23/o_PC
add wave -noupdate /projectb/b2v_inst3/if_instruction
add wave -noupdate /projectb/b2v_inst3/id_instruction
add wave -noupdate /projectb/b2v_inst21/ex_instruction
add wave -noupdate /projectb/b2v_inst28/mem_instruction
add wave -noupdate /projectb/b2v_inst8/wb_instruction
add wave -noupdate /projectb/b2v_inst7/pc_stall
add wave -noupdate /projectb/b2v_inst7/if_id_stall
add wave -noupdate /projectb/b2v_inst7/if_id_flush
add wave -noupdate /projectb/b2v_inst7/id_ex_stall
add wave -noupdate /projectb/b2v_inst7/id_ex_flush
add wave -noupdate /projectb/b2v_inst7/ex_mem_stall
add wave -noupdate /projectb/b2v_inst7/ex_mem_flush
add wave -noupdate /projectb/b2v_inst7/mem_wb_stall
add wave -noupdate /projectb/b2v_inst7/mem_wb_flush
add wave -noupdate /projectb/b2v_inst15/o_equal
add wave -noupdate /projectb/b2v_inst21/ex_branch
add wave -noupdate /projectb/b2v_inst24/o_F
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13117 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 240
configure wave -valuecolwidth 90
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
WaveRestoreZoom {12010 ns} {13157 ns}
