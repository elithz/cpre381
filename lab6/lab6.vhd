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
-- CREATED		"Wed Mar 01 20:15:15 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY lab6 IS 
	PORT
	(
		i_CLK :  IN  STD_LOGIC;
		i_RST :  IN  STD_LOGIC;
		i_WE :  IN  STD_LOGIC;
		ALU_En :  IN  STD_LOGIC;
		product_RES :  IN  STD_LOGIC;
		product_EN :  IN  STD_LOGIC;
		i_Cin_f :  IN  STD_LOGIC;
		Multiplicand_f :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Multiplier_f :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		zero_64 :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
		o_Cout_f :  OUT  STD_LOGIC;
		RESULT :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END lab6;

ARCHITECTURE bdf_type OF lab6 IS 

COMPONENT multiplicand
	PORT(i_CLK : IN STD_LOGIC;
		 i_RST : IN STD_LOGIC;
		 i_WE : IN STD_LOGIC;
		 i_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_Q : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT multiplier
	PORT(i_CLK : IN STD_LOGIC;
		 i_RST : IN STD_LOGIC;
		 i_WE : IN STD_LOGIC;
		 i_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 o_Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT six_fou_bit_alu
GENERIC (N : INTEGER
			);
	PORT(i_Cin : IN STD_LOGIC;
		 i_En : IN STD_LOGIC;
		 i_A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 i_B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 o_Cout : OUT STD_LOGIC;
		 o_S : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT six_fou_single_reg
GENERIC (n : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 r_in : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 r_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT six_fou_ttomux
GENERIC (N : INTEGER
			);
	PORT(i_Xin : IN STD_LOGIC;
		 i_Ain : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 i_Bin : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 o_YD : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	o_Q :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(63 DOWNTO 0);


BEGIN 
RESULT <= SYNTHESIZED_WIRE_2;



b2v_inst : multiplicand
PORT MAP(i_CLK => i_CLK,
		 i_RST => i_RST,
		 i_WE => i_WE,
		 i_D => Multiplicand_f,
		 o_Q => SYNTHESIZED_WIRE_3);


b2v_inst1 : multiplier
PORT MAP(i_CLK => i_CLK,
		 i_RST => i_RST,
		 i_WE => i_WE,
		 i_D => Multiplier_f,
		 o_Q => o_Q);


b2v_inst2 : six_fou_bit_alu
GENERIC MAP(N => 64
			)
PORT MAP(i_Cin => i_Cin_f,
		 i_En => ALU_En,
		 i_A => SYNTHESIZED_WIRE_0,
		 i_B => SYNTHESIZED_WIRE_1,
		 o_Cout => o_Cout_f,
		 o_S => SYNTHESIZED_WIRE_2);


b2v_inst3 : six_fou_single_reg
GENERIC MAP(n => 64
			)
PORT MAP(clk => i_CLK,
		 reset => product_RES,
		 enable => product_EN,
		 r_in => SYNTHESIZED_WIRE_2,
		 r_out => SYNTHESIZED_WIRE_1);


b2v_inst4 : six_fou_ttomux
GENERIC MAP(N => 64
			)
PORT MAP(i_Xin => o_Q(0),
		 i_Ain => zero_64,
		 i_Bin => SYNTHESIZED_WIRE_3,
		 o_YD => SYNTHESIZED_WIRE_0);


END bdf_type;