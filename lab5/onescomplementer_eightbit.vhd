library IEEE;
use IEEE.std_logic_1164.all;


entity onsecomplementer_eightbit is
  generic(N : integer := 8);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    o_F  : out std_logic_vector(N-1 downto 0));
end onsecomplementer_eightbit;

architecture structure of onsecomplementer_eightbit is
component inv
  port(
    i_A : in std_logic;
    o_F : out std_logic);
end component;
  
  begin
    
    G1: for i in 0 to N-1 generate
      inv_i: inv
        port map(
          i_A => i_A(i),
          o_F => o_F(i));
    end generate;
end structure;
