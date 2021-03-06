library IEEE;
use IEEE.std_logic_1164.all;


entity fulladder is
  port(
    i_A  : in std_logic;
    i_B  : in std_logic;
    i_Cin  : in std_logic;
    o_S  : out std_logic;
    o_Cout  :out std_logic);
end fulladder;

architecture structure of fulladder is
  component inv
  port(
    i_A : in std_logic;
    o_F : out std_logic);
end component;

component and2
  port(
    i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;

component or2
  port(
    i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;

component xor2
  port(
    i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;



begin
o_S <= i_A xor i_B xor i_Cin;
o_Cout <= (i_A and i_B) or (i_A and i_Cin) or (i_B and i_Cin);
end structure;

    
