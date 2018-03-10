-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition"
-- CREATED		"Thu Apr 27 09:34:53 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY projectB IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		regf_rst :  IN  STD_LOGIC;
		imem_wren :  IN  STD_LOGIC;
		PC_rst :  IN  STD_LOGIC;
		if_id_reset :  IN  STD_LOGIC;
		stallsAndFlashes :  IN  STD_LOGIC;
		byteena :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		data :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		give00 :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		giveFourtoThisPin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		alu0 :  OUT  STD_LOGIC;
		wbregdest :  OUT  STD_LOGIC;
		wbinstr :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		wbpcp4 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END projectB;

ARCHITECTURE bdf_type OF projectB IS 

COMPONENT register_file
	PORT(CLK : IN STD_LOGIC;
		 w_en : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 rs_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rt_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 w_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 w_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rs_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rt_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT branch_comparator
	PORT(i_rs_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_rt_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_equal : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT alu
	PORT(ALU_OP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 i_A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 shamt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 zero : OUT STD_LOGIC;
		 ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT id_ex
	PORT(CLK : IN STD_LOGIC;
		 ex_flush : IN STD_LOGIC;
		 ex_stall : IN STD_LOGIC;
		 idex_reset : IN STD_LOGIC;
		 id_reg_dest : IN STD_LOGIC;
		 id_branch : IN STD_LOGIC;
		 id_mem_to_reg : IN STD_LOGIC;
		 id_mem_write : IN STD_LOGIC;
		 id_ALU_src : IN STD_LOGIC;
		 id_reg_write : IN STD_LOGIC;
		 id_ALU_op : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 id_extended_immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_pc_plus_4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_rd_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 id_rs_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_rs_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 id_rt_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_rt_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_reg_dest : OUT STD_LOGIC;
		 ex_branch : OUT STD_LOGIC;
		 ex_mem_to_reg : OUT STD_LOGIC;
		 ex_mem_write : OUT STD_LOGIC;
		 ex_ALU_src : OUT STD_LOGIC;
		 ex_reg_write : OUT STD_LOGIC;
		 ex_ALU_op : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ex_extended_immediate : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_pc_plus_4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rd_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_rs_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rs_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_rt_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rt_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux21_5bit
	PORT(i_sel : IN STD_LOGIC;
		 i_0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 i_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 o_mux : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc_reg
	PORT(CLK : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 stall : IN STD_LOGIC;
		 i_next_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT and_2
	PORT(i_A : IN STD_LOGIC;
		 i_B : IN STD_LOGIC;
		 o_F : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ex_mem
	PORT(CLK : IN STD_LOGIC;
		 mem_flush : IN STD_LOGIC;
		 mem_stall : IN STD_LOGIC;
		 exmem_reset : IN STD_LOGIC;
		 ex_reg_dest : IN STD_LOGIC;
		 ex_mem_to_reg : IN STD_LOGIC;
		 ex_mem_write : IN STD_LOGIC;
		 ex_reg_write : IN STD_LOGIC;
		 ex_ALU_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_pc_plus_4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_rt_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ex_write_reg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 mem_reg_dest : OUT STD_LOGIC;
		 mem_mem_to_reg : OUT STD_LOGIC;
		 mem_mem_write : OUT STD_LOGIC;
		 mem_reg_write : OUT STD_LOGIC;
		 mem_ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_pc_plus_4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_rt_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_write_reg_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux21_32bit
	PORT(i_sel : IN STD_LOGIC;
		 i_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_mux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT if_id
	PORT(CLK : IN STD_LOGIC;
		 id_flush : IN STD_LOGIC;
		 id_stall : IN STD_LOGIC;
		 ifid_reset : IN STD_LOGIC;
		 if_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 if_pc_plus_4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 id_pc_plus_4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT adder_32
	PORT(i_A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sll_2
	PORT(i_to_shift : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_shifted : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT jumpaddrgnrt
	PORT(i_PCplusFour31_28 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 i_shifted_j_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_J_Addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sign_extender_26_32
	PORT(i_to_extend : IN STD_LOGIC_VECTOR(25 DOWNTO 0);
		 o_extended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT main_control
	PORT(i_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_reg_dest : OUT STD_LOGIC;
		 o_jump : OUT STD_LOGIC;
		 o_branch : OUT STD_LOGIC;
		 o_mem_to_reg : OUT STD_LOGIC;
		 o_mem_write : OUT STD_LOGIC;
		 o_ALU_src : OUT STD_LOGIC;
		 o_reg_write : OUT STD_LOGIC;
		 o_ALU_op : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sign_extender_16_32
	PORT(i_to_extend : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 o_extended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmem
GENERIC (depth_exp_of_2 : INTEGER;
			mif_filename : STRING
			);
	PORT(clock : IN STD_LOGIC;
		 wren : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 byteena : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT imem
GENERIC (depth_exp_of_2 : INTEGER;
			mif_filename : STRING
			);
	PORT(clock : IN STD_LOGIC;
		 wren : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 byteena : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux31_32bit
	PORT(i_00 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_01 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_10 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 o_mux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT forwarding
	PORT(wb_reg_write : IN STD_LOGIC;
		 mem_reg_write : IN STD_LOGIC;
		 ex_rs_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 ex_rt_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 mem_write_reg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wb_write_reg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rs_mux_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 rt_mux_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT hazard
	PORT(control_jump : IN STD_LOGIC;
		 id_branch : IN STD_LOGIC;
		 branch_taken : IN STD_LOGIC;
		 id_ex_memRead : IN STD_LOGIC;
		 ex_writRegSel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 id_ex_regRt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 if_id_regRs : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 if_id_regRt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 pc_stall : OUT STD_LOGIC;
		 if_id_stall : OUT STD_LOGIC;
		 if_id_flush : OUT STD_LOGIC;
		 id_ex_stall : OUT STD_LOGIC;
		 id_ex_flush : OUT STD_LOGIC;
		 ex_mem_stall : OUT STD_LOGIC;
		 ex_mem_flush : OUT STD_LOGIC;
		 mem_wb_stall : OUT STD_LOGIC;
		 mem_wb_flush : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mem_wb
	PORT(CLK : IN STD_LOGIC;
		 wb_flush : IN STD_LOGIC;
		 wb_stall : IN STD_LOGIC;
		 memwb_reset : IN STD_LOGIC;
		 mem_reg_dest : IN STD_LOGIC;
		 mem_mem_to_reg : IN STD_LOGIC;
		 mem_reg_write : IN STD_LOGIC;
		 mem_ALU_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_dmem_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_pc_plus_4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 mem_write_reg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 wb_reg_dest : OUT STD_LOGIC;
		 wb_mem_to_reg : OUT STD_LOGIC;
		 wb_reg_write : OUT STD_LOGIC;
		 wb_ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_dmem_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_pc_plus_4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wb_write_reg_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	id_instruction :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	id_pc_plus_4 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mem_ALU_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	o_PC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_87 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_88 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_89 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_90 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_91 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_92 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_93 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_94 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_95 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_96 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_34 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_35 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_97 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_98 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_99 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_100 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_40 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_41 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_42 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_43 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_101 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_46 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_47 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_48 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_50 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_51 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_52 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_54 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_55 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_56 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_57 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_59 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_60 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_62 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_102 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_65 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_103 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_69 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_70 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_71 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_78 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_79 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_80 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_81 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_83 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_84 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_85 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst : register_file
PORT MAP(CLK => clock,
		 w_en => SYNTHESIZED_WIRE_87,
		 reset => regf_rst,
		 rs_sel => id_instruction(25 DOWNTO 21),
		 rt_sel => id_instruction(20 DOWNTO 16),
		 w_data => SYNTHESIZED_WIRE_88,
		 w_sel => SYNTHESIZED_WIRE_89,
		 rs_data => SYNTHESIZED_WIRE_90,
		 rt_data => SYNTHESIZED_WIRE_91);


b2v_inst15 : branch_comparator
PORT MAP(i_rs_data => SYNTHESIZED_WIRE_90,
		 i_rt_data => SYNTHESIZED_WIRE_91,
		 o_equal => SYNTHESIZED_WIRE_26);


b2v_inst19 : alu
PORT MAP(ALU_OP => SYNTHESIZED_WIRE_5,
		 i_A => SYNTHESIZED_WIRE_6,
		 i_B => SYNTHESIZED_WIRE_7,
		 shamt => id_instruction(10 DOWNTO 6),
		 zero => alu0,
		 ALU_out => SYNTHESIZED_WIRE_33);


b2v_inst21 : id_ex
PORT MAP(CLK => clock,
		 ex_flush => SYNTHESIZED_WIRE_8,
		 ex_stall => SYNTHESIZED_WIRE_9,
		 idex_reset => if_id_reset,
		 id_reg_dest => SYNTHESIZED_WIRE_10,
		 id_branch => SYNTHESIZED_WIRE_92,
		 id_mem_to_reg => SYNTHESIZED_WIRE_12,
		 id_mem_write => SYNTHESIZED_WIRE_13,
		 id_ALU_src => SYNTHESIZED_WIRE_14,
		 id_reg_write => SYNTHESIZED_WIRE_15,
		 id_ALU_op => SYNTHESIZED_WIRE_16,
		 id_extended_immediate => SYNTHESIZED_WIRE_93,
		 id_instruction => id_instruction,
		 id_pc_plus_4 => id_pc_plus_4,
		 id_rd_sel => id_instruction(15 DOWNTO 11),
		 id_rs_data => SYNTHESIZED_WIRE_90,
		 id_rs_sel => id_instruction(25 DOWNTO 21),
		 id_rt_data => SYNTHESIZED_WIRE_91,
		 id_rt_sel => id_instruction(20 DOWNTO 16),
		 ex_reg_dest => SYNTHESIZED_WIRE_94,
		 ex_mem_to_reg => SYNTHESIZED_WIRE_96,
		 ex_mem_write => SYNTHESIZED_WIRE_31,
		 ex_ALU_src => SYNTHESIZED_WIRE_52,
		 ex_reg_write => SYNTHESIZED_WIRE_32,
		 ex_ALU_op => SYNTHESIZED_WIRE_5,
		 ex_extended_immediate => SYNTHESIZED_WIRE_54,
		 ex_instruction => SYNTHESIZED_WIRE_34,
		 ex_pc_plus_4 => SYNTHESIZED_WIRE_35,
		 ex_rd_sel => SYNTHESIZED_WIRE_22,
		 ex_rs_data => SYNTHESIZED_WIRE_57,
		 ex_rs_sel => SYNTHESIZED_WIRE_65,
		 ex_rt_data => SYNTHESIZED_WIRE_60,
		 ex_rt_sel => SYNTHESIZED_WIRE_95);


b2v_inst22 : mux21_5bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_94,
		 i_0 => SYNTHESIZED_WIRE_95,
		 i_1 => SYNTHESIZED_WIRE_22,
		 o_mux => SYNTHESIZED_WIRE_98);


b2v_inst23 : pc_reg
PORT MAP(CLK => clock,
		 reset => PC_rst,
		 stall => SYNTHESIZED_WIRE_23,
		 i_next_PC => SYNTHESIZED_WIRE_24,
		 o_PC => o_PC);


b2v_inst24 : and_2
PORT MAP(i_A => SYNTHESIZED_WIRE_92,
		 i_B => SYNTHESIZED_WIRE_26,
		 o_F => SYNTHESIZED_WIRE_99);


b2v_inst28 : ex_mem
PORT MAP(CLK => clock,
		 mem_flush => SYNTHESIZED_WIRE_27,
		 mem_stall => SYNTHESIZED_WIRE_28,
		 exmem_reset => if_id_reset,
		 ex_reg_dest => SYNTHESIZED_WIRE_94,
		 ex_mem_to_reg => SYNTHESIZED_WIRE_96,
		 ex_mem_write => SYNTHESIZED_WIRE_31,
		 ex_reg_write => SYNTHESIZED_WIRE_32,
		 ex_ALU_out => SYNTHESIZED_WIRE_33,
		 ex_instruction => SYNTHESIZED_WIRE_34,
		 ex_pc_plus_4 => SYNTHESIZED_WIRE_35,
		 ex_rt_data => SYNTHESIZED_WIRE_97,
		 ex_write_reg_sel => SYNTHESIZED_WIRE_98,
		 mem_reg_dest => SYNTHESIZED_WIRE_80,
		 mem_mem_to_reg => SYNTHESIZED_WIRE_81,
		 mem_mem_write => SYNTHESIZED_WIRE_55,
		 mem_reg_write => SYNTHESIZED_WIRE_102,
		 mem_ALU_out => mem_ALU_out,
		 mem_instruction => SYNTHESIZED_WIRE_84,
		 mem_pc_plus_4 => SYNTHESIZED_WIRE_85,
		 mem_rt_data => SYNTHESIZED_WIRE_56,
		 mem_write_reg_sel => SYNTHESIZED_WIRE_103);


b2v_inst29 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_99,
		 i_0 => SYNTHESIZED_WIRE_100,
		 i_1 => SYNTHESIZED_WIRE_40,
		 o_mux => SYNTHESIZED_WIRE_46);


b2v_inst3 : if_id
PORT MAP(CLK => clock,
		 id_flush => SYNTHESIZED_WIRE_41,
		 id_stall => SYNTHESIZED_WIRE_42,
		 ifid_reset => if_id_reset,
		 if_instruction => SYNTHESIZED_WIRE_43,
		 if_pc_plus_4 => SYNTHESIZED_WIRE_100,
		 id_instruction => id_instruction,
		 id_pc_plus_4 => id_pc_plus_4);


b2v_inst30 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_101,
		 i_0 => SYNTHESIZED_WIRE_46,
		 i_1 => SYNTHESIZED_WIRE_47,
		 o_mux => SYNTHESIZED_WIRE_24);


b2v_inst31 : adder_32
PORT MAP(i_A => SYNTHESIZED_WIRE_48,
		 i_B => id_pc_plus_4,
		 o_F => SYNTHESIZED_WIRE_40);


b2v_inst33 : sll_2
PORT MAP(i_to_shift => SYNTHESIZED_WIRE_93,
		 o_shifted => SYNTHESIZED_WIRE_48);


b2v_inst34 : jumpaddrgnrt
PORT MAP(i_PCplusFour31_28 => id_pc_plus_4(31 DOWNTO 28),
		 i_shifted_j_addr => SYNTHESIZED_WIRE_50,
		 o_J_Addr => SYNTHESIZED_WIRE_47);


b2v_inst35 : sll_2
PORT MAP(i_to_shift => SYNTHESIZED_WIRE_51,
		 o_shifted => SYNTHESIZED_WIRE_50);


b2v_inst36 : sign_extender_26_32
PORT MAP(i_to_extend => id_instruction(25 DOWNTO 0),
		 o_extended => SYNTHESIZED_WIRE_51);


b2v_inst37 : main_control
PORT MAP(i_instruction => id_instruction,
		 o_reg_dest => SYNTHESIZED_WIRE_10,
		 o_jump => SYNTHESIZED_WIRE_101,
		 o_branch => SYNTHESIZED_WIRE_92,
		 o_mem_to_reg => SYNTHESIZED_WIRE_12,
		 o_mem_write => SYNTHESIZED_WIRE_13,
		 o_ALU_src => SYNTHESIZED_WIRE_14,
		 o_reg_write => SYNTHESIZED_WIRE_15,
		 o_ALU_op => SYNTHESIZED_WIRE_16);


b2v_inst39 : sign_extender_16_32
PORT MAP(i_to_extend => id_instruction(15 DOWNTO 0),
		 o_extended => SYNTHESIZED_WIRE_93);


b2v_inst4 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_52,
		 i_0 => SYNTHESIZED_WIRE_97,
		 i_1 => SYNTHESIZED_WIRE_54,
		 o_mux => SYNTHESIZED_WIRE_7);


b2v_inst40 : adder_32
PORT MAP(i_A => o_PC,
		 i_B => giveFourtoThisPin,
		 o_F => SYNTHESIZED_WIRE_100);


b2v_inst44 : dmem
GENERIC MAP(depth_exp_of_2 => 10,
			mif_filename => "dmem.mif"
			)
PORT MAP(clock => clock,
		 wren => SYNTHESIZED_WIRE_55,
		 address => mem_ALU_out(11 DOWNTO 2),
		 byteena => byteena,
		 data => SYNTHESIZED_WIRE_56,
		 q => SYNTHESIZED_WIRE_83);


b2v_inst45 : imem
GENERIC MAP(depth_exp_of_2 => 10,
			mif_filename => "imem.mif"
			)
PORT MAP(clock => clock,
		 wren => imem_wren,
		 address => o_PC(11 DOWNTO 2),
		 byteena => byteena,
		 data => data,
		 q => SYNTHESIZED_WIRE_43);


b2v_inst46 : mux31_32bit
PORT MAP(i_00 => SYNTHESIZED_WIRE_57,
		 i_01 => SYNTHESIZED_WIRE_88,
		 i_10 => mem_ALU_out,
		 i_sel => SYNTHESIZED_WIRE_59,
		 o_mux => SYNTHESIZED_WIRE_6);


b2v_inst47 : mux31_32bit
PORT MAP(i_00 => SYNTHESIZED_WIRE_60,
		 i_01 => SYNTHESIZED_WIRE_88,
		 i_10 => mem_ALU_out,
		 i_sel => SYNTHESIZED_WIRE_62,
		 o_mux => SYNTHESIZED_WIRE_97);


b2v_inst5 : forwarding
PORT MAP(wb_reg_write => SYNTHESIZED_WIRE_87,
		 mem_reg_write => SYNTHESIZED_WIRE_102,
		 ex_rs_sel => SYNTHESIZED_WIRE_65,
		 ex_rt_sel => SYNTHESIZED_WIRE_95,
		 mem_write_reg_sel => SYNTHESIZED_WIRE_103,
		 wb_write_reg_sel => SYNTHESIZED_WIRE_89,
		 rs_mux_sel => SYNTHESIZED_WIRE_59,
		 rt_mux_sel => SYNTHESIZED_WIRE_62);


b2v_inst6 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_69,
		 i_0 => SYNTHESIZED_WIRE_70,
		 i_1 => SYNTHESIZED_WIRE_71,
		 o_mux => SYNTHESIZED_WIRE_88);


b2v_inst7 : hazard
PORT MAP(control_jump => SYNTHESIZED_WIRE_101,
		 id_branch => SYNTHESIZED_WIRE_92,
		 branch_taken => SYNTHESIZED_WIRE_99,
		 id_ex_memRead => SYNTHESIZED_WIRE_96,
		 ex_writRegSel => SYNTHESIZED_WIRE_98,
		 id_ex_regRt => SYNTHESIZED_WIRE_95,
		 if_id_regRs => id_instruction(25 DOWNTO 21),
		 if_id_regRt => id_instruction(20 DOWNTO 16),
		 pc_stall => SYNTHESIZED_WIRE_23,
		 if_id_stall => SYNTHESIZED_WIRE_42,
		 if_id_flush => SYNTHESIZED_WIRE_41,
		 id_ex_stall => SYNTHESIZED_WIRE_9,
		 id_ex_flush => SYNTHESIZED_WIRE_8,
		 ex_mem_stall => SYNTHESIZED_WIRE_28,
		 ex_mem_flush => SYNTHESIZED_WIRE_27,
		 mem_wb_stall => SYNTHESIZED_WIRE_79,
		 mem_wb_flush => SYNTHESIZED_WIRE_78);


b2v_inst8 : mem_wb
PORT MAP(CLK => clock,
		 wb_flush => SYNTHESIZED_WIRE_78,
		 wb_stall => SYNTHESIZED_WIRE_79,
		 memwb_reset => if_id_reset,
		 mem_reg_dest => SYNTHESIZED_WIRE_80,
		 mem_mem_to_reg => SYNTHESIZED_WIRE_81,
		 mem_reg_write => SYNTHESIZED_WIRE_102,
		 mem_ALU_out => mem_ALU_out,
		 mem_dmem_out => SYNTHESIZED_WIRE_83,
		 mem_instruction => SYNTHESIZED_WIRE_84,
		 mem_pc_plus_4 => SYNTHESIZED_WIRE_85,
		 mem_write_reg_sel => SYNTHESIZED_WIRE_103,
		 wb_reg_dest => wbregdest,
		 wb_mem_to_reg => SYNTHESIZED_WIRE_69,
		 wb_reg_write => SYNTHESIZED_WIRE_87,
		 wb_ALU_out => SYNTHESIZED_WIRE_70,
		 wb_dmem_out => SYNTHESIZED_WIRE_71,
		 wb_instruction => wbinstr,
		 wb_pc_plus_4 => wbpcp4,
		 wb_write_reg_sel => SYNTHESIZED_WIRE_89);


END bdf_type;