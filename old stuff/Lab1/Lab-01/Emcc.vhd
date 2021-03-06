
library IEEE;
use IEEE.std_logic_1164.all;


entity Emcc is

  port(iCLK             : in std_logic;
       iM 		            : in integer;
       oE 		            : out integer);

end Emcc;

architecture structure of Emcc is
  
  -- Describe the component entities as defined in Adder.vhd 
  -- and Multiplier.vhd (not strictly necessary).

  component Multiplier
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;

  -- Arbitrary constants for the A, B, C values. No need to change these.
  constant cC : integer := 9487;

  -- Signals to store A*x, B*x
  signal sVALUE_Cc      : integer;

begin

  
  ---------------------------------------------------------------------------
  -- Level 1: Calculate A*x, B*x
  ---------------------------------------------------------------------------
  g_Mult1: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => cC,
             iB               => cC,
             oC               => sVALUE_Cc);

  g_Mult2: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => sVALUE_Cc,
             iB               => iM,
             oC               => oE);
  
end structure;
