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
-- CREATED		"Sun Feb 19 14:31:06 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY full_adder_8_bit IS 
	PORT
	(
		i_Cin :  IN  STD_LOGIC;
		i_A :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_B :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_Cout :  OUT  STD_LOGIC;
		o_Sum :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END full_adder_8_bit;

ARCHITECTURE bdf_type OF full_adder_8_bit IS 

COMPONENT full_adder
	PORT(i_A : IN STD_LOGIC;
		 i_B : IN STD_LOGIC;
		 i_Carry_in : IN STD_LOGIC;
		 o_Sum : OUT STD_LOGIC;
		 o_Carry_out : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	o_Sum_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;


BEGIN 



b2v_inst : full_adder
PORT MAP(i_A => i_A(0),
		 i_B => i_B(0),
		 i_Carry_in => i_Cin,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(0),
		 o_Carry_out => SYNTHESIZED_WIRE_5);


b2v_inst1 : full_adder
PORT MAP(i_A => i_A(4),
		 i_B => i_B(4),
		 i_Carry_in => SYNTHESIZED_WIRE_0,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(4),
		 o_Carry_out => SYNTHESIZED_WIRE_3);


b2v_inst2 : full_adder
PORT MAP(i_A => i_A(7),
		 i_B => i_B(7),
		 i_Carry_in => SYNTHESIZED_WIRE_1,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(7),
		 o_Carry_out => o_Cout);


b2v_inst3 : full_adder
PORT MAP(i_A => i_A(6),
		 i_B => i_B(6),
		 i_Carry_in => SYNTHESIZED_WIRE_2,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(6),
		 o_Carry_out => SYNTHESIZED_WIRE_1);


b2v_inst4 : full_adder
PORT MAP(i_A => i_A(5),
		 i_B => i_B(5),
		 i_Carry_in => SYNTHESIZED_WIRE_3,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(5),
		 o_Carry_out => SYNTHESIZED_WIRE_2);


b2v_inst5 : full_adder
PORT MAP(i_A => i_A(3),
		 i_B => i_B(3),
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(3),
		 o_Carry_out => SYNTHESIZED_WIRE_0);


b2v_inst6 : full_adder
PORT MAP(i_A => i_A(2),
		 i_B => i_B(2),
		 i_Carry_in => SYNTHESIZED_WIRE_4,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(2));


b2v_inst7 : full_adder
PORT MAP(i_A => i_A(1),
		 i_B => i_B(1),
		 i_Carry_in => SYNTHESIZED_WIRE_5,
		 o_Sum => o_Sum_ALTERA_SYNTHESIZED(1),
		 o_Carry_out => SYNTHESIZED_WIRE_4);

o_Sum <= o_Sum_ALTERA_SYNTHESIZED;

END bdf_type;