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
-- CREATED		"Wed Mar 29 21:32:12 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY projectA IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		regf_rst :  IN  STD_LOGIC;
		imem_wren :  IN  STD_LOGIC;
		PC_rst :  IN  STD_LOGIC;
		byteena :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		data :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		giveFourtoThisPin :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		after_ex :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		alu_in1 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		alu_in2 :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		imem_o25 :  OUT  STD_LOGIC_VECTOR(25 DOWNTO 0);
		instruction :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		jumpAddr :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END projectA;

ARCHITECTURE bdf_type OF projectA IS 

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

COMPONENT alu
	PORT(ALU_OP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 i_A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 shamt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 zero : OUT STD_LOGIC;
		 ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

COMPONENT and_2
	PORT(i_A : IN STD_LOGIC;
		 i_B : IN STD_LOGIC;
		 o_F : OUT STD_LOGIC
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

COMPONENT mux21_5bit
	PORT(i_sel : IN STD_LOGIC;
		 i_0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 i_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 o_mux : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sign_extender_16_32
	PORT(i_to_extend : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 o_extended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT jumpaddrgnrt
	PORT(i_PCplusFour31_28 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 i_shifted_j_addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_J_Addr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

COMPONENT pc_reg
	PORT(CLK : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 i_next_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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

COMPONENT sign_extender_26_32
	PORT(i_to_extend : IN STD_LOGIC_VECTOR(25 DOWNTO 0);
		 o_extended : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux21_32bit
	PORT(i_sel : IN STD_LOGIC;
		 i_0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_mux : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	ALU_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	o_F :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	o_mux :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	o_PC :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	q :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	rs_data :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
after_ex <= SYNTHESIZED_WIRE_7;
jumpAddr <= SYNTHESIZED_WIRE_23;



b2v_inst : register_file
PORT MAP(CLK => clock,
		 w_en => SYNTHESIZED_WIRE_0,
		 reset => regf_rst,
		 rs_sel => q(25 DOWNTO 21),
		 rt_sel => q(20 DOWNTO 16),
		 w_data => SYNTHESIZED_WIRE_1,
		 w_sel => SYNTHESIZED_WIRE_2,
		 rs_data => rs_data,
		 rt_data => SYNTHESIZED_WIRE_25);


b2v_inst1 : alu
PORT MAP(ALU_OP => SYNTHESIZED_WIRE_3,
		 i_A => rs_data,
		 i_B => o_mux,
		 shamt => q(10 DOWNTO 6),
		 zero => SYNTHESIZED_WIRE_5,
		 ALU_out => ALU_out);


b2v_inst10 : main_control
PORT MAP(i_instruction => q,
		 o_reg_dest => SYNTHESIZED_WIRE_8,
		 o_jump => SYNTHESIZED_WIRE_21,
		 o_branch => SYNTHESIZED_WIRE_4,
		 o_mem_to_reg => SYNTHESIZED_WIRE_14,
		 o_mem_write => SYNTHESIZED_WIRE_11,
		 o_ALU_src => SYNTHESIZED_WIRE_18,
		 o_reg_write => SYNTHESIZED_WIRE_0,
		 o_ALU_op => SYNTHESIZED_WIRE_3);


b2v_inst11 : and_2
PORT MAP(i_A => SYNTHESIZED_WIRE_4,
		 i_B => SYNTHESIZED_WIRE_5,
		 o_F => SYNTHESIZED_WIRE_16);


b2v_inst12 : adder_32
PORT MAP(i_A => SYNTHESIZED_WIRE_6,
		 i_B => o_F,
		 o_F => SYNTHESIZED_WIRE_17);


b2v_inst13 : adder_32
PORT MAP(i_A => o_PC,
		 i_B => giveFourtoThisPin,
		 o_F => o_F);


b2v_inst14 : sll_2
PORT MAP(i_to_shift => SYNTHESIZED_WIRE_7,
		 o_shifted => SYNTHESIZED_WIRE_10);


b2v_inst15 : mux21_5bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_8,
		 i_0 => q(20 DOWNTO 16),
		 i_1 => q(15 DOWNTO 11),
		 o_mux => SYNTHESIZED_WIRE_2);


b2v_inst16 : sign_extender_16_32
PORT MAP(i_to_extend => q(15 DOWNTO 0),
		 o_extended => SYNTHESIZED_WIRE_24);


b2v_inst17 : sll_2
PORT MAP(i_to_shift => SYNTHESIZED_WIRE_24,
		 o_shifted => SYNTHESIZED_WIRE_6);


b2v_inst18 : jumpaddrgnrt
PORT MAP(i_PCplusFour31_28 => o_F(31 DOWNTO 28),
		 i_shifted_j_addr => SYNTHESIZED_WIRE_10,
		 o_J_Addr => SYNTHESIZED_WIRE_23);


b2v_inst19 : dmem
GENERIC MAP(depth_exp_of_2 => 10,
			mif_filename => "U:\cpre381\projectA\dmem.mif"
			)
PORT MAP(clock => clock,
		 wren => SYNTHESIZED_WIRE_11,
		 address => ALU_out(11 DOWNTO 2),
		 byteena => byteena,
		 data => SYNTHESIZED_WIRE_25,
		 q => SYNTHESIZED_WIRE_15);


b2v_inst2 : pc_reg
PORT MAP(CLK => clock,
		 reset => PC_rst,
		 i_next_PC => SYNTHESIZED_WIRE_13,
		 o_PC => o_PC);


b2v_inst20 : imem
GENERIC MAP(depth_exp_of_2 => 10,
			mif_filename => "U:\cpre381\projectA\imem.mif"
			)
PORT MAP(clock => clock,
		 wren => imem_wren,
		 address => o_PC(11 DOWNTO 2),
		 byteena => byteena,
		 data => data,
		 q => q);


b2v_inst5 : sign_extender_26_32
PORT MAP(i_to_extend => q(25 DOWNTO 0),
		 o_extended => SYNTHESIZED_WIRE_7);


b2v_inst6 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_14,
		 i_0 => ALU_out,
		 i_1 => SYNTHESIZED_WIRE_15,
		 o_mux => SYNTHESIZED_WIRE_1);


b2v_inst7 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_16,
		 i_0 => o_F,
		 i_1 => SYNTHESIZED_WIRE_17,
		 o_mux => SYNTHESIZED_WIRE_22);


b2v_inst8 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_18,
		 i_0 => SYNTHESIZED_WIRE_25,
		 i_1 => SYNTHESIZED_WIRE_24,
		 o_mux => o_mux);


b2v_inst9 : mux21_32bit
PORT MAP(i_sel => SYNTHESIZED_WIRE_21,
		 i_0 => SYNTHESIZED_WIRE_22,
		 i_1 => SYNTHESIZED_WIRE_23,
		 o_mux => SYNTHESIZED_WIRE_13);

alu_in1 <= rs_data;
alu_in2 <= o_mux;
imem_o25(25 DOWNTO 0) <= q(25 DOWNTO 0);
instruction <= q;

END bdf_type;