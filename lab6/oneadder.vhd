library IEEE;
use IEEE.std_logic_1164.all;


entity one_fulladder is
  port(
    i_A  : in std_logic;
    i_B  : in std_logic;
    i_Cin  : in std_logic;
    o_S  : out std_logic;
    o_Cout  :out std_logic;
end one_fulladder;

architecture structure of one_fulladder is
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


signal bXORcin, notbXORcin  : std_logic;
signal nota, notb  : std_logic;
signal notc : std_logic;
signal notabc, anotbc : std_logic;
signal abcpabc  : std_logic;



signal bc, ac, ab : std_logic;
signal ana, bnb  : std_logic;
signal cnc  : std_logic;
signal bca, acb, abc  : std_logic;
signal bcaPacb :std_logic;

begin
  
    -- structure Sum calculation
  a_inv: inv
  port MAP(
    i_A => i_A,
    o_F => nota);
    
  b_inv: inv
  port MAP(
    i_A => i_B,
    o_F =>notb);
    
  c_inv: inv
  port MAP(
    i_A => i_Cin,
    o_F =>notc);
    
  bc_xor2: xor2
  port MAP(
    i_A => i_B,
    i_B => i_Cin,
    o_F => bXORcin);
  
  anbc_and2: and2
  port MAP(
    i_A => nota,
    i_B => bXORcin,
    o_F => notabc);
  
  nbc_inv: inv
  port MAP(
    i_A => bXORcin,
    o_F => notbXORcin);
    
  abcn_and2: and2
  port MAP(
    i_A => i_A,
    i_B => notbXORcin,
    o_F => anotbc);
    
  abcoabc_or2: or2
  port MAP(
    i_A => notabc,
    i_B => anotbc,
    o_F => o_S);

  
    
  
    -- structure Carry out calculation
  bc_and2: and2
  port MAP(
    i_A => i_B,
    i_B => i_Cin,
    o_F => bc);
    
  ac_and2: and2
  port MAP(
    i_A => i_A,  
    i_B => i_Cin,
    o_F => ac);
    
  ab_and2: and2
  port MAP(
    i_A => i_A,
    i_B => i_B,
    o_F => ab);
    
  ana_or2: or2
  port MAP(
    i_A => i_A,
    i_B => nota,
    o_F => ana);
    
  bnb_or2: or2
  port MAP(
    i_A => i_B,
    i_B => notb,
    o_F => bnb);
      
  cnc_or2: or2
  port MAP(
    i_A => i_Cin,
    i_B => notc,
    o_F => cnc);
    
  bca_and2: and2
  port MAP(
    i_A => bc,
    i_B => ana,
    o_F => bca);
    
  acb_and2: and2
  port MAP(
    i_A => ac,
    i_B => bnb,
    o_F => acb);
    
  abc_and2: and2
  port MAP(
    i_A => ab,
    i_B => cnc,
    o_F => abc);
    
  bcaPacb_or2: or2
  port MAP(
    i_A => bca,
    i_B => acb,
    o_F => bcaPacb);
    
  bPaPabc_or2: or2
  port MAP(
    i_A => bcaPacb,
    i_B => abc,
    o_F => o_Cout);
end structure;