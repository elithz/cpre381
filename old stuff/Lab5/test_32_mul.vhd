library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity test_32_mul is 
  port( a : in std_logic_vector( 31 downto 0);
        b : in std_logic_vector( 31 downto 0);
        aisp: in std_logic;
        bisp: in std_logic);
       
end test_32_mul;


  



architecture behave of test_32_mul is
  
component multi_32 is 
  port( a : in std_logic_vector( 31 downto 0);
        b : in std_logic_vector( 31 downto 0);
        aisp: in std_logic;
        bisp: in std_logic;
        c : out std_logic_vector(63 downto 0));
end component;

signal output :std_logic_vector(63 downto 0);
begin
  
  process
    begin
      G1: multi_32
      port map( a => "00000000000000000000000000101010",
                b => "00000000000000000000000000001010",
                aisp => '1',
                bisp => '0',
                c => output);
                
                
      wait for 500 ns;
      
end process;
  
end behave;