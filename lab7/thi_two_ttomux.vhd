library IEEE;
use IEEE.std_logic_1164.all;


entity thi_two_ttomux is
  generic(N : integer := 32);
  port(
    i_Ain  : in std_logic_vector(N-1 downto 0);
    i_Bin  : in std_logic_vector(N-1 downto 0);
    i_Xin  : in std_logic;
    o_YD  : out std_logic_vector(N-1 downto 0));
end thi_two_ttomux;

architecture structure of thi_two_ttomux is


signal xNOT : std_logic;
signal aX : std_logic_vector(N-1 downto 0);
signal bX : std_logic_vector(N-1 downto 0);

begin
  
  
  
  G1: for j in 0 to N-1 generate
    xNOT  <= not i_Xin;
    aX(j)  <= i_Ain(j) and xNOT;
    bX(j)  <= i_Bin(j) and i_Xin;
    o_YD(j)  <= aX(j) or bX(j);
  end generate;
  
  
end structure;
