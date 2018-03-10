library IEEE;
use IEEE.std_logic_1164.all;


entity one_bit_ALU is
  port(
    i_A  : in std_logic;
    i_B  : in std_logic;
    i_Cin : in std_logic;
    i_Op  : in std_logic_vector(2 downto 0);
    i_Les : in std_logic;
    o_Re  : out std_logic;
    o_Cout  :out std_logic;
    o_Set : out std_logic
    );
end one_bit_ALU;


architecture structure of one_bit_ALU is
  component fulladder
  port(
    i_A  : in std_logic;
    i_B  : in std_logic;
    i_Cin  : in std_logic;
    o_S  : out std_logic;
    o_Cout  :out std_logic
  );
  end component;

  component two_one_mux
    port(
      in_data : std_logic_vector(1 downto 0);
      S1 : in std_logic;
      O: out STD_LOGIC
    );
  end component;
  
  

signal i_Binv, R_and, R_or, R_nand, R_nor, R_xor, R_add_sub, R_slt, NOT_B, B_ADDER : std_logic;


begin
  
NOT_B <= not i_B;
R_and <= i_A and i_B;
R_or  <= i_A or i_B;
R_nand <= i_A nand i_B;
R_nor <= i_A nor i_B;
R_xor <= i_A xor i_B;



i_Binv <= '1' when (i_Op = "011") else 
          '1' when (i_Op = "111") else
          '0';

mux2 : two_one_mux
port MAP(
  in_data(0) => i_B,
  in_data(1) => NOT_B,
  S1         => i_Binv,
  O          => B_ADDER
);



add : fulladder
port MAP(i_A, B_ADDER, i_Cin, R_add_sub, o_Cout);
  


o_Re <= R_and when (i_Op = "000") else
        R_or  when (i_Op = "001") else
        R_add_sub when (i_Op = "010") else
        R_add_sub when (i_op = "011") else
        R_nand when (i_Op = "100") else
        R_nor  when (i_Op = "101") else
        R_xor  when (i_Op = "110") else
        i_Les;
        
o_Set <= R_add_sub;

  

end structure;