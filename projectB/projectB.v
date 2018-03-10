// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition"
// CREATED		"Tue Apr 25 21:17:01 2017"

module projectB(
	clock,
	regf_rst,
	imem_wren,
	PC_rst,
	if_id_reset,
	id_ex_reset,
	ex_mem_reset,
	mem_wb_reset,
	byteena,
	data,
	giveFourtoThisPin,
	alu0,
	wbregdest,
	wbinstr,
	wbpcp4
);


input wire	clock;
input wire	regf_rst;
input wire	imem_wren;
input wire	PC_rst;
input wire	if_id_reset;
input wire	id_ex_reset;
input wire	ex_mem_reset;
input wire	mem_wb_reset;
input wire	[3:0] byteena;
input wire	[31:0] data;
input wire	[31:0] giveFourtoThisPin;
output wire	alu0;
output wire	wbregdest;
output wire	[31:0] wbinstr;
output wire	[31:0] wbpcp4;

wire	[31:0] id_instruction;
wire	[31:0] id_pc_plus_4;
wire	[31:0] mem_ALU_out;
wire	[31:0] o_PC;
wire	SYNTHESIZED_WIRE_86;
wire	[31:0] SYNTHESIZED_WIRE_87;
wire	[4:0] SYNTHESIZED_WIRE_88;
wire	SYNTHESIZED_WIRE_89;
wire	SYNTHESIZED_WIRE_90;
wire	SYNTHESIZED_WIRE_91;
wire	[4:0] SYNTHESIZED_WIRE_92;
wire	[4:0] SYNTHESIZED_WIRE_93;
wire	[31:0] SYNTHESIZED_WIRE_94;
wire	[31:0] SYNTHESIZED_WIRE_95;
wire	[3:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_19;
wire	SYNTHESIZED_WIRE_20;
wire	[3:0] SYNTHESIZED_WIRE_21;
wire	[31:0] SYNTHESIZED_WIRE_96;
wire	SYNTHESIZED_WIRE_97;
wire	[4:0] SYNTHESIZED_WIRE_27;
wire	SYNTHESIZED_WIRE_28;
wire	[31:0] SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_36;
wire	SYNTHESIZED_WIRE_37;
wire	[31:0] SYNTHESIZED_WIRE_38;
wire	[31:0] SYNTHESIZED_WIRE_39;
wire	[31:0] SYNTHESIZED_WIRE_40;
wire	[31:0] SYNTHESIZED_WIRE_98;
wire	SYNTHESIZED_WIRE_43;
wire	[31:0] SYNTHESIZED_WIRE_99;
wire	[31:0] SYNTHESIZED_WIRE_45;
wire	SYNTHESIZED_WIRE_46;
wire	SYNTHESIZED_WIRE_47;
wire	[31:0] SYNTHESIZED_WIRE_48;
wire	[31:0] SYNTHESIZED_WIRE_51;
wire	[31:0] SYNTHESIZED_WIRE_52;
wire	[31:0] SYNTHESIZED_WIRE_53;
wire	[31:0] SYNTHESIZED_WIRE_55;
wire	[31:0] SYNTHESIZED_WIRE_56;
wire	SYNTHESIZED_WIRE_57;
wire	[31:0] SYNTHESIZED_WIRE_59;
wire	SYNTHESIZED_WIRE_60;
wire	[31:0] SYNTHESIZED_WIRE_61;
wire	[31:0] SYNTHESIZED_WIRE_62;
wire	[1:0] SYNTHESIZED_WIRE_64;
wire	[31:0] SYNTHESIZED_WIRE_65;
wire	[1:0] SYNTHESIZED_WIRE_67;
wire	SYNTHESIZED_WIRE_100;
wire	[4:0] SYNTHESIZED_WIRE_70;
wire	[4:0] SYNTHESIZED_WIRE_101;
wire	SYNTHESIZED_WIRE_74;
wire	[31:0] SYNTHESIZED_WIRE_75;
wire	[31:0] SYNTHESIZED_WIRE_76;
wire	SYNTHESIZED_WIRE_77;
wire	SYNTHESIZED_WIRE_78;
wire	SYNTHESIZED_WIRE_79;
wire	SYNTHESIZED_WIRE_80;
wire	[31:0] SYNTHESIZED_WIRE_82;
wire	[31:0] SYNTHESIZED_WIRE_83;
wire	[31:0] SYNTHESIZED_WIRE_84;





register_file	b2v_inst(
	.CLK(clock),
	.w_en(SYNTHESIZED_WIRE_86),
	.reset(regf_rst),
	.rs_sel(id_instruction[25:21]),
	.rt_sel(id_instruction[20:16]),
	.w_data(SYNTHESIZED_WIRE_87),
	.w_sel(SYNTHESIZED_WIRE_88),
	.rs_data(SYNTHESIZED_WIRE_94),
	.rt_data(SYNTHESIZED_WIRE_95));


Hazard	b2v_inst1(
	.control_jump(SYNTHESIZED_WIRE_89),
	.id_branch(SYNTHESIZED_WIRE_90),
	.id_ex_memRead(SYNTHESIZED_WIRE_91),
	.ex_writRegSel(SYNTHESIZED_WIRE_92),
	.id_ex_regRt(SYNTHESIZED_WIRE_93),
	.if_id_regRs(id_instruction[25:21]),
	.if_id_regRt(id_instruction[20:16]),
	.pc_stall(SYNTHESIZED_WIRE_28),
	.if_id_stall(SYNTHESIZED_WIRE_47),
	.if_id_flush(SYNTHESIZED_WIRE_46),
	.id_ex_stall(SYNTHESIZED_WIRE_14),
	.id_ex_flush(SYNTHESIZED_WIRE_13),
	.ex_mem_stall(SYNTHESIZED_WIRE_33),
	.ex_mem_flush(SYNTHESIZED_WIRE_32),
	.mem_wb_stall(SYNTHESIZED_WIRE_78),
	.mem_wb_flush(SYNTHESIZED_WIRE_77));


branch_comparator	b2v_inst15(
	.i_rs_data(SYNTHESIZED_WIRE_94),
	.i_rt_data(SYNTHESIZED_WIRE_95),
	.o_equal(SYNTHESIZED_WIRE_31));


ALU	b2v_inst19(
	.ALU_OP(SYNTHESIZED_WIRE_10),
	.i_A(SYNTHESIZED_WIRE_11),
	.i_B(SYNTHESIZED_WIRE_12),
	.shamt(id_instruction[10:6]),
	.zero(alu0),
	.ALU_out(SYNTHESIZED_WIRE_38));


id_ex	b2v_inst21(
	.CLK(clock),
	.ex_flush(SYNTHESIZED_WIRE_13),
	.ex_stall(SYNTHESIZED_WIRE_14),
	.idex_reset(id_ex_reset),
	.id_reg_dest(SYNTHESIZED_WIRE_15),
	.id_branch(SYNTHESIZED_WIRE_90),
	.id_mem_to_reg(SYNTHESIZED_WIRE_17),
	.id_mem_write(SYNTHESIZED_WIRE_18),
	.id_ALU_src(SYNTHESIZED_WIRE_19),
	.id_reg_write(SYNTHESIZED_WIRE_20),
	.id_ALU_op(SYNTHESIZED_WIRE_21),
	.id_extended_immediate(SYNTHESIZED_WIRE_96),
	.id_instruction(id_instruction),
	.id_pc_plus_4(id_pc_plus_4),
	.id_rd_sel(id_instruction[15:11]),
	.id_rs_data(SYNTHESIZED_WIRE_94),
	.id_rs_sel(id_instruction[25:21]),
	.id_rt_data(SYNTHESIZED_WIRE_95),
	.id_rt_sel(id_instruction[20:16]),
	.ex_reg_dest(SYNTHESIZED_WIRE_97),
	
	.ex_mem_to_reg(SYNTHESIZED_WIRE_91),
	.ex_mem_write(SYNTHESIZED_WIRE_36),
	.ex_ALU_src(SYNTHESIZED_WIRE_57),
	.ex_reg_write(SYNTHESIZED_WIRE_37),
	.ex_ALU_op(SYNTHESIZED_WIRE_10),
	.ex_extended_immediate(SYNTHESIZED_WIRE_59),
	.ex_instruction(SYNTHESIZED_WIRE_39),
	.ex_pc_plus_4(SYNTHESIZED_WIRE_40),
	.ex_rd_sel(SYNTHESIZED_WIRE_27),
	.ex_rs_data(SYNTHESIZED_WIRE_62),
	.ex_rs_sel(SYNTHESIZED_WIRE_70),
	.ex_rt_data(SYNTHESIZED_WIRE_65),
	.ex_rt_sel(SYNTHESIZED_WIRE_93));


mux21_5bit	b2v_inst22(
	.i_sel(SYNTHESIZED_WIRE_97),
	.i_0(SYNTHESIZED_WIRE_93),
	.i_1(SYNTHESIZED_WIRE_27),
	.o_mux(SYNTHESIZED_WIRE_92));


PC_reg	b2v_inst23(
	.CLK(clock),
	.reset(PC_rst),
	.stall(SYNTHESIZED_WIRE_28),
	.i_next_PC(SYNTHESIZED_WIRE_29),
	.o_PC(o_PC));


and_2	b2v_inst24(
	.i_A(SYNTHESIZED_WIRE_90),
	.i_B(SYNTHESIZED_WIRE_31),
	.o_F(SYNTHESIZED_WIRE_43));


ex_mem	b2v_inst28(
	.CLK(clock),
	.mem_flush(SYNTHESIZED_WIRE_32),
	.mem_stall(SYNTHESIZED_WIRE_33),
	.exmem_reset(ex_mem_reset),
	.ex_reg_dest(SYNTHESIZED_WIRE_97),
	.ex_mem_to_reg(SYNTHESIZED_WIRE_91),
	.ex_mem_write(SYNTHESIZED_WIRE_36),
	.ex_reg_write(SYNTHESIZED_WIRE_37),
	.ex_ALU_out(SYNTHESIZED_WIRE_38),
	.ex_instruction(SYNTHESIZED_WIRE_39),
	.ex_pc_plus_4(SYNTHESIZED_WIRE_40),
	.ex_rt_data(SYNTHESIZED_WIRE_98),
	.ex_write_reg_sel(SYNTHESIZED_WIRE_92),
	.mem_reg_dest(SYNTHESIZED_WIRE_79),
	.mem_mem_to_reg(SYNTHESIZED_WIRE_80),
	.mem_mem_write(SYNTHESIZED_WIRE_60),
	.mem_reg_write(SYNTHESIZED_WIRE_100),
	.mem_ALU_out(mem_ALU_out),
	.mem_instruction(SYNTHESIZED_WIRE_83),
	.mem_pc_plus_4(SYNTHESIZED_WIRE_84),
	.mem_rt_data(SYNTHESIZED_WIRE_61),
	.mem_write_reg_sel(SYNTHESIZED_WIRE_101));


mux21_32bit	b2v_inst29(
	.i_sel(SYNTHESIZED_WIRE_43),
	.i_0(SYNTHESIZED_WIRE_99),
	.i_1(SYNTHESIZED_WIRE_45),
	.o_mux(SYNTHESIZED_WIRE_51));


if_id	b2v_inst3(
	.CLK(clock),
	.id_flush(SYNTHESIZED_WIRE_46),
	.id_stall(SYNTHESIZED_WIRE_47),
	.ifid_reset(if_id_reset),
	.if_instruction(SYNTHESIZED_WIRE_48),
	.if_pc_plus_4(SYNTHESIZED_WIRE_99),
	.id_instruction(id_instruction),
	.id_pc_plus_4(id_pc_plus_4));


mux21_32bit	b2v_inst30(
	.i_sel(SYNTHESIZED_WIRE_89),
	.i_0(SYNTHESIZED_WIRE_51),
	.i_1(SYNTHESIZED_WIRE_52),
	.o_mux(SYNTHESIZED_WIRE_29));


adder_32	b2v_inst31(
	.i_A(SYNTHESIZED_WIRE_53),
	.i_B(id_pc_plus_4),
	.o_F(SYNTHESIZED_WIRE_45));


sll_2	b2v_inst33(
	.i_to_shift(SYNTHESIZED_WIRE_96),
	.o_shifted(SYNTHESIZED_WIRE_53));


jumpAddrGNRT	b2v_inst34(
	.i_PCplusFour31_28(id_pc_plus_4[31:28]),
	.i_shifted_j_addr(SYNTHESIZED_WIRE_55),
	.o_J_Addr(SYNTHESIZED_WIRE_52));


sll_2	b2v_inst35(
	.i_to_shift(SYNTHESIZED_WIRE_56),
	.o_shifted(SYNTHESIZED_WIRE_55));


sign_extender_26_32	b2v_inst36(
	.i_to_extend(id_instruction[25:0]),
	.o_extended(SYNTHESIZED_WIRE_56));


main_control	b2v_inst37(
	.i_instruction(id_instruction),
	.o_reg_dest(SYNTHESIZED_WIRE_15),
	.o_jump(SYNTHESIZED_WIRE_89),
	.o_branch(SYNTHESIZED_WIRE_90),
	.o_mem_to_reg(SYNTHESIZED_WIRE_17),
	.o_mem_write(SYNTHESIZED_WIRE_18),
	.o_ALU_src(SYNTHESIZED_WIRE_19),
	.o_reg_write(SYNTHESIZED_WIRE_20),
	.o_ALU_op(SYNTHESIZED_WIRE_21));


sign_extender_16_32	b2v_inst39(
	.i_to_extend(id_instruction[15:0]),
	.o_extended(SYNTHESIZED_WIRE_96));


mux21_32bit	b2v_inst4(
	.i_sel(SYNTHESIZED_WIRE_57),
	.i_0(SYNTHESIZED_WIRE_98),
	.i_1(SYNTHESIZED_WIRE_59),
	.o_mux(SYNTHESIZED_WIRE_12));


adder_32	b2v_inst40(
	.i_A(o_PC),
	.i_B(giveFourtoThisPin),
	.o_F(SYNTHESIZED_WIRE_99));


dmem	b2v_inst44(
	.clock(clock),
	.wren(SYNTHESIZED_WIRE_60),
	.address(mem_ALU_out[11:2]),
	.byteena(byteena),
	.data(SYNTHESIZED_WIRE_61),
	.q(SYNTHESIZED_WIRE_82));
	defparam	b2v_inst44.depth_exp_of_2 = 10;
	defparam	b2v_inst44.mif_filename = "dmem.mif";


imem	b2v_inst45(
	.clock(clock),
	.wren(imem_wren),
	.address(o_PC[11:2]),
	.byteena(byteena),
	.data(data),
	.q(SYNTHESIZED_WIRE_48));
	defparam	b2v_inst45.depth_exp_of_2 = 10;
	defparam	b2v_inst45.mif_filename = "imem.mif";


mux31_32bit	b2v_inst46(
	.i_00(SYNTHESIZED_WIRE_62),
	.i_01(SYNTHESIZED_WIRE_87),
	.i_10(mem_ALU_out),
	.i_sel(SYNTHESIZED_WIRE_64),
	.o_mux(SYNTHESIZED_WIRE_11));


mux31_32bit	b2v_inst47(
	.i_00(SYNTHESIZED_WIRE_65),
	.i_01(SYNTHESIZED_WIRE_87),
	.i_10(mem_ALU_out),
	.i_sel(SYNTHESIZED_WIRE_67),
	.o_mux(SYNTHESIZED_WIRE_98));


forwarding	b2v_inst5(
	.wb_reg_write(SYNTHESIZED_WIRE_86),
	.mem_reg_write(SYNTHESIZED_WIRE_100),
	.ex_rs_sel(SYNTHESIZED_WIRE_70),
	.ex_rt_sel(SYNTHESIZED_WIRE_93),
	.mem_write_reg_sel(SYNTHESIZED_WIRE_101),
	.wb_write_reg_sel(SYNTHESIZED_WIRE_88),
	.rs_mux_sel(SYNTHESIZED_WIRE_64),
	.rt_mux_sel(SYNTHESIZED_WIRE_67));


mux21_32bit	b2v_inst6(
	.i_sel(SYNTHESIZED_WIRE_74),
	.i_0(SYNTHESIZED_WIRE_75),
	.i_1(SYNTHESIZED_WIRE_76),
	.o_mux(SYNTHESIZED_WIRE_87));


mem_wb	b2v_inst8(
	.CLK(clock),
	.wb_flush(SYNTHESIZED_WIRE_77),
	.wb_stall(SYNTHESIZED_WIRE_78),
	.memwb_reset(mem_wb_reset),
	.mem_reg_dest(SYNTHESIZED_WIRE_79),
	.mem_mem_to_reg(SYNTHESIZED_WIRE_80),
	.mem_reg_write(SYNTHESIZED_WIRE_100),
	.mem_ALU_out(mem_ALU_out),
	.mem_dmem_out(SYNTHESIZED_WIRE_82),
	.mem_instruction(SYNTHESIZED_WIRE_83),
	.mem_pc_plus_4(SYNTHESIZED_WIRE_84),
	.mem_write_reg_sel(SYNTHESIZED_WIRE_101),
	.wb_reg_dest(wbregdest),
	.wb_mem_to_reg(SYNTHESIZED_WIRE_74),
	.wb_reg_write(SYNTHESIZED_WIRE_86),
	.wb_ALU_out(SYNTHESIZED_WIRE_75),
	.wb_dmem_out(SYNTHESIZED_WIRE_76),
	.wb_instruction(wbinstr),
	.wb_pc_plus_4(wbpcp4),
	.wb_write_reg_sel(SYNTHESIZED_WIRE_88));


endmodule
