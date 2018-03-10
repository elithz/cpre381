library IEEE;
use IEEE.std_logic_1164.all;

entity six_fou_single_reg is
  generic (
    n  : integer := 64 
  );
  port(
    clk:              in std_logic; 
    reset:            in std_logic; 
    enable:           in std_logic;    
    r_in:             in std_logic_vector(n-1 downto 0);
    r_out:            out std_logic_vector(n-1 downto 0) 
  );   -- Data value output

end six_fou_single_reg;


architecture structural of six_fou_single_reg is
  component dff
    port(
      i_CLK        : in std_logic;     -- Clock input
      i_RST        : in std_logic;     -- Reset input
      i_WE         : in std_logic;     -- Write enable input
      i_D          : in std_logic;     -- Data value input
      o_Q          : out std_logic
    );
  end component;
  
  

begin
  G1: for i in 0 to n-1 generate 
    U1 : dff port map(
      i_CLK => clk, 
      i_RST => reset, 
      i_WE  => enable, 
      i_D   => r_in(i), 
      o_Q   => r_out(i)
    );
end generate;
  
  
  
end structural;
