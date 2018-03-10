library ieee;
use ieee.std_logic_1164.all;


entity DEC_2TO4 is port(
  Input : in std_logic_vector(1 downto 0);
  Output : out std_logic_vector(3 downto 0));
end DEC_2TO4;



architecture IMP of DEC_2TO4 is
  
begin
  Output(0) <= (not Input(0)) and (not Input(1));
  Output(1) <= Input(0) and (not Input(1));
  Output(2) <= (not Input(0)) and Input(1);
  Output(3) <= Input(0) and Input(1);
end IMP;