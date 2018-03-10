onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /projecta/clock
add wave -noupdate /projecta/regf_rst
add wave -noupdate /projecta/imem_wren
add wave -noupdate /projecta/PC_rst
add wave -noupdate /projecta/byteena
add wave -noupdate /projecta/data
add wave -noupdate /projecta/giveFourtoThisPin
add wave -noupdate /projecta/after_ex
add wave -noupdate /projecta/alu_in1
add wave -noupdate /projecta/alu_in2
add wave -noupdate /projecta/imem_o25
add wave -noupdate /projecta/instruction
add wave -noupdate /projecta/jumpAddr
add wave -noupdate /projecta/ALU_out
add wave -noupdate -expand /projecta/b2v_inst/registers
add wave -noupdate /projecta/b2v_inst19/mem(10)
add wave -noupdate /projecta/b2v_inst19/mem(9)
add wave -noupdate /projecta/b2v_inst19/mem(8)
add wave -noupdate /projecta/b2v_inst19/mem(7)
add wave -noupdate /projecta/b2v_inst19/mem(6)
add wave -noupdate /projecta/b2v_inst19/mem(5)
add wave -noupdate /projecta/b2v_inst19/mem(4)
add wave -noupdate /projecta/b2v_inst19/mem(3)
add wave -noupdate /projecta/b2v_inst19/mem(2)
add wave -noupdate /projecta/b2v_inst19/mem(1)
add wave -noupdate /projecta/b2v_inst19/mem(0)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {331 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {942 ns}
