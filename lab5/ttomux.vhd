library IEEE;
use IEEE.std_logic_1164.all;


entity ttomux is
  port(
    i_Ain  : in std_logic;
    i_Bin  : in std_logic;
    i_Xin  : in std_logic;
    o_Y  : out std_logic);
end ttomux;

architecture structure of ttomux is
  
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


signal xNOT : std_logic;
signal aX, bX : std_logic;

begin
  
  x_inv: inv
    port MAP(
      i_A  => i_Xin,
      o_F => xNOT);
      
  a_mulX: and2
    port MAP(
      i_A => i_Ain,
      i_B => xNOT,
      o_F => aX);
      
  b_mulX: and2
    port MAP(
      i_A => i_Bin,
      i_B => i_Xin,
      o_F => bX);
      
  ab_P: or2
    port MAP(
      i_A => aX,
      i_B => bX,
      o_F => o_Y);

end structure;
