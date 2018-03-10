library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity twoscompliment is
      generic
      (
              Nbits : positive := 32 
       );
 port 
( 
           --Inputs
           din : in std_logic_vector (Nbits-1 downto 0);
           --Outputs
           dout : out std_logic_vector (Nbits-1 downto 0)
);
end twoscompliment;

architecture func of twoscompliment is

begin

dout <= not(din) + 1;

end func; 