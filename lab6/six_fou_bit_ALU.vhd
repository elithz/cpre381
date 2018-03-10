library IEEE;
use IEEE.std_logic_1164.all;


entity six_fou_bit_ALU is
  generic(N : integer := 64);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    i_B  : in std_logic_vector(N-1 downto 0);
    i_Cin  : in std_logic;
    i_En : in std_logic;
    o_S  : out std_logic_vector(N-1 downto 0);
    o_Cout  :out std_logic);
end six_fou_bit_ALU;

architecture structure of six_fou_bit_ALU is
  component fulladder
    port(
    i_A  : in std_logic;
    i_B  : in std_logic;
    i_Cin  : in std_logic;
    i_En : in std_logic;
    o_S  : out std_logic;
    o_Cout  :out std_logic);
  end component;
  
  signal car_int : std_logic_vector(N downto 0); 


begin
  G1: for i in 0 to N-1 generate
     ns_full_adder: fulladder
     port MAP(
       i_A => i_A(i),
       i_B => i_B(i),
       i_Cin => car_int(i),
       i_En => i_En,
       o_S => o_S(i),
       o_Cout => car_int(i+1));
  
  
end generate;
  
  
  
  car_int(0) <= i_Cin;
  o_Cout <= car_int(N);
    
end structure;