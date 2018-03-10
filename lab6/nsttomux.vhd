library IEEE;
use IEEE.std_logic_1164.all;


entity nsttomux is
  generic(N : integer := 32);
  port(
    i_Ain  : in std_logic_vector(N-1 downto 0);
    i_Bin  : in std_logic_vector(N-1 downto 0);
    i_Xin  : in std_logic;
    o_YS  : out std_logic_vector(N-1 downto 0);
    o_YD  : out std_logic_vector(N-1 downto 0));
end nsttomux;

architecture structure of nsttomux is
  
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
signal aX : std_logic_vector(N-1 downto 0);
signal bX : std_logic_vector(N-1 downto 0);

begin
  G1: for i in 0 to N-1 generate
  x_inv: inv
    port MAP(
      i_A  => i_Xin,
      o_F => xNOT);
  
      
  a_mulX: and2
    port MAP(
      i_A => i_Ain(i),
      i_B => xNOT,
      o_F => aX(i));
      
  b_mulX: and2
    port MAP(
      i_A => i_Bin(i),
      i_B => i_Xin,
      o_F => bX(i));
      
  ab_P: or2
    port MAP(
      i_A => aX(i),
      i_B => bX(i),
      o_F => o_YS(i));
  end generate;
  
  
  G2: for j in 0 to N-1 generate
    xNOT  <= not i_Xin;
    aX(j)  <= i_Ain(j) and xNOT;
    bX(j)  <= i_Bin(j) and i_Xin;
    o_YD(j)  <= aX(j) or bX(j);
  end generate;
  
  
end structure;
