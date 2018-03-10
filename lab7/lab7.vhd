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
-- CREATED		"Wed Mar 08 11:02:27 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY lab7 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reg_we :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		reg_dest :  IN  STD_LOGIC;
		sel_imm :  IN  STD_LOGIC;
		mem_we :  IN  STD_LOGIC;
		ALU_OP :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		by_teena :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		immidiate :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rs_sel :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		rt_sel :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		shamt :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		w_addr :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		ALUzero :  OUT  STD_LOGIC;
		ALU_q :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rsdata_o :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rtdata_o :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END lab7;

ARCHITECTURE bdf_type OF lab7 IS 

COMPONENT thi_two_ttomux
GENERIC (N : INTEGER
			);
	PORT(i_Xin : IN STD_LOGIC;
		 i_Ain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 i_Bin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_YD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT register_file
GENERIC (N : INTEGER
			);
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

COMPONENT mem
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

SIGNAL	ALU_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 
rsdata_o <= SYNTHESIZED_WIRE_2;
rtdata_o <= SYNTHESIZED_WIRE_6;



b2v_inst : thi_two_ttomux
GENERIC MAP(N => 32
			)
PORT MAP(i_Xin => reg_dest,
		 i_Ain => SYNTHESIZED_WIRE_0,
		 i_Bin => ALU_out,
		 o_YD => SYNTHESIZED_WIRE_1);


b2v_inst2 : register_file
GENERIC MAP(N => 32
			)
PORT MAP(CLK => clk,
		 w_en => reg_we,
		 reset => reset,
		 rs_sel => rs_sel,
		 rt_sel => rt_sel,
		 w_data => SYNTHESIZED_WIRE_1,
		 w_sel => w_addr,
		 rs_data => SYNTHESIZED_WIRE_2,
		 rt_data => SYNTHESIZED_WIRE_6);


b2v_inst3 : alu
PORT MAP(ALU_OP => ALU_OP,
		 i_A => SYNTHESIZED_WIRE_2,
		 i_B => SYNTHESIZED_WIRE_3,
		 shamt => shamt,
		 zero => ALUzero,
		 ALU_out => ALU_out);


b2v_inst4 : mem
GENERIC MAP(depth_exp_of_2 => 10,
			mif_filename => "U:\cpre381\lab7\Memory\dmem.mif"
			)
PORT MAP(clock => clk,
		 wren => mem_we,
		 address => ALU_out(9 DOWNTO 0),
		 byteena => by_teena,
		 data => SYNTHESIZED_WIRE_6,
		 q => SYNTHESIZED_WIRE_0);


b2v_inst5 : thi_two_ttomux
GENERIC MAP(N => 32
			)
PORT MAP(i_Xin => sel_imm,
		 i_Ain => SYNTHESIZED_WIRE_6,
		 i_Bin => immidiate,
		 o_YD => SYNTHESIZED_WIRE_3);

ALU_q <= ALU_out;

END bdf_type;