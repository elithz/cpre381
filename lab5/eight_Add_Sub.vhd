library IEEE;
use IEEE.std_logic_1164.all;


entity eight_Add_Sub is
  generic(N : integer := 8);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    i_B  : in std_logic_vector(N-1 downto 0);
    i_Switch  : in std_logic; -- 1: S = A - B, 0: S = A + B
    o_S  : out std_logic_vector(N-1 downto 0);
    o_Cout  :out std_logic);
end eight_Add_Sub;

architecture structure of eight_Add_Sub is
  component onsecomplementer_eightbit
  --generic(N : integer := 1);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    o_F  : out std_logic_vector(N-1 downto 0));
  end component;
  
  component eightbit_ttomux
  --generic(N : integer := 1);
  port(
    i_Ain  : in std_logic_vector(N-1 downto 0);
    i_Bin  : in std_logic_vector(N-1 downto 0);
    i_Xin  : in std_logic;
    o_YS  : out std_logic_vector(N-1 downto 0);
    o_YD  : out std_logic_vector(N-1 downto 0));
  end component;
  
  component eight_fulladder
  --generic(N : integer := 1);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    i_B  : in std_logic_vector(N-1 downto 0);
    i_Cin  : in std_logic;
    o_S  : out std_logic_vector(N-1 downto 0);
    o_Cout  :out std_logic);
  end component;
  
  
  signal b_inv  : std_logic_vector(N-1 downto 0); -- B'
  signal mux_out  : std_logic_vector(N-1 downto 0);
  
begin
  G1: for i in 0 to N-1 generate
  inv_b: onsecomplementer_eightbit
  port MAP(
    i_A => i_B,
    o_F => b_inv);
    
  mux: eightbit_ttomux
  port MAP(
    i_Ain => i_B,
    i_Bin => b_inv,
    i_Xin => i_Switch,
    o_YS  => mux_out);
    
  fulladder_here: eight_fulladder
  port MAP(
    i_A => i_A,
    i_B => mux_out,
    i_Cin => i_Switch,
    o_S => o_S,
    o_Cout  => o_Cout);
  end generate;
end structure;