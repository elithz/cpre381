onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /projectb/clock
add wave -noupdate -radix hexadecimal /projectb/regf_rst
add wave -noupdate -radix hexadecimal /projectb/imem_wren
add wave -noupdate -radix hexadecimal /projectb/PC_rst
add wave -noupdate -radix hexadecimal /projectb/pcstall
add wave -noupdate -radix hexadecimal /projectb/idstallflush
add wave -noupdate -radix hexadecimal /projectb/exflushstall
add wave -noupdate -radix hexadecimal /projectb/memstallflush
add wave -noupdate -radix hexadecimal /projectb/wbstallflush
add wave -noupdate -radix binary /projectb/byteena
add wave -noupdate -radix hexadecimal /projectb/data
add wave -noupdate -radix binary /projectb/giv00
add wave -noupdate -radix decimal /projectb/giveFourtoThisPin
add wave -noupdate -radix hexadecimal /projectb/alu0
add wave -noupdate -radix hexadecimal /projectb/wbregdest
add wave -noupdate -radix hexadecimal /projectb/wbinstr
add wave -noupdate -radix hexadecimal /projectb/wbpcp4
add wave -noupdate -radix hexadecimal /projectb/b2v_inst45/q
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_reg_dest
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_mem_to_reg
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_reg_write
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_dmem_out
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_write_reg_sel
add wave -noupdate -radix hexadecimal /projectb/b2v_inst3/if_instruction
add wave -noupdate -radix hexadecimal /projectb/b2v_inst3/id_instruction
add wave -noupdate /projectb/b2v_inst21/ex_instruction
add wave -noupdate -radix hexadecimal /projectb/b2v_inst8/wb_instruction
add wave -noupdate /projectb/b2v_inst29/i_0
add wave -noupdate /projectb/b2v_inst29/i_1
add wave -noupdate /projectb/b2v_inst33/i_to_shift
add wave -noupdate /projectb/b2v_inst33/o_shifted
add wave -noupdate -radix hexadecimal -childformat {{/projectb/b2v_inst/registers(31) -radix hexadecimal} {/projectb/b2v_inst/registers(30) -radix hexadecimal} {/projectb/b2v_inst/registers(29) -radix hexadecimal} {/projectb/b2v_inst/registers(28) -radix hexadecimal} {/projectb/b2v_inst/registers(27) -radix hexadecimal} {/projectb/b2v_inst/registers(26) -radix hexadecimal} {/projectb/b2v_inst/registers(25) -radix hexadecimal} {/projectb/b2v_inst/registers(24) -radix hexadecimal} {/projectb/b2v_inst/registers(23) -radix hexadecimal} {/projectb/b2v_inst/registers(22) -radix hexadecimal} {/projectb/b2v_inst/registers(21) -radix hexadecimal} {/projectb/b2v_inst/registers(20) -radix hexadecimal} {/projectb/b2v_inst/registers(19) -radix hexadecimal} {/projectb/b2v_inst/registers(18) -radix hexadecimal} {/projectb/b2v_inst/registers(17) -radix hexadecimal} {/projectb/b2v_inst/registers(16) -radix hexadecimal} {/projectb/b2v_inst/registers(15) -radix hexadecimal} {/projectb/b2v_inst/registers(14) -radix hexadecimal} {/projectb/b2v_inst/registers(13) -radix hexadecimal} {/projectb/b2v_inst/registers(12) -radix hexadecimal} {/projectb/b2v_inst/registers(11) -radix hexadecimal} {/projectb/b2v_inst/registers(10) -radix hexadecimal} {/projectb/b2v_inst/registers(9) -radix hexadecimal} {/projectb/b2v_inst/registers(8) -radix hexadecimal} {/projectb/b2v_inst/registers(7) -radix hexadecimal} {/projectb/b2v_inst/registers(6) -radix hexadecimal} {/projectb/b2v_inst/registers(5) -radix hexadecimal} {/projectb/b2v_inst/registers(4) -radix hexadecimal} {/projectb/b2v_inst/registers(3) -radix hexadecimal} {/projectb/b2v_inst/registers(2) -radix hexadecimal} {/projectb/b2v_inst/registers(1) -radix hexadecimal} {/projectb/b2v_inst/registers(0) -radix hexadecimal}} -expand -subitemconfig {/projectb/b2v_inst/registers(31) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(30) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(29) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(28) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(27) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(26) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(25) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(24) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(23) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(22) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(21) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(20) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(19) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(18) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(17) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(16) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(15) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(14) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(13) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(12) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(11) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(10) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(9) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(8) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(7) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(6) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(5) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(4) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(3) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(2) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(1) {-height 15 -radix hexadecimal} /projectb/b2v_inst/registers(0) {-height 15 -radix hexadecimal}} /projectb/b2v_inst/registers
add wave -noupdate -radix hexadecimal /projectb/b2v_inst/registers(20)
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/i_instruction
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_reg_dest
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_jump
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_branch
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_mem_to_reg
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_ALU_op
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_mem_write
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_ALU_src
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/o_reg_write
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/op_code
add wave -noupdate -radix hexadecimal /projectb/b2v_inst37/func_code
add wave -noupdate -radix hexadecimal /projectb/b2v_inst15/o_equal
add wave -noupdate -radix hexadecimal /projectb/b2v_inst24/o_F
add wave -noupdate -radix hexadecimal /projectb/b2v_inst29/o_mux
add wave -noupdate -radix hexadecimal /projectb/b2v_inst30/o_mux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50117 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
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
WaveRestoreZoom {48908 ns} {50163 ns}
