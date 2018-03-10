library ieee;
use ieee.std_logic_1164.all;


entity DEC_3TO8 is port(
  Enable : in std_logic;
  Input : in std_logic_vector(2 downto 0);
  Output : out std_logic_vector(7 downto 0)
);
end DEC_3TO8;



architecture IMP of DEC_3TO8 is
  
begin
  Output(0) <= (not Input(0)) and (not Input(1)) and (not Input(2)) and Enable;
  Output(1) <= Input(0) and (not Input(1)) and (not Input(2)) and Enable;
  Output(2) <= (not Input(0)) and Input(1) and (not Input(2)) and Enable;
  Output(3) <= Input(0) and Input(1) and (not Input(2))  and Enable;
  Output(4) <= (not Input(0)) and (not Input(1)) and Input(2) and Enable;
  Output(5) <= Input(0) and (not Input(1)) and Input(2) and Enable;
  Output(6) <= (not Input(0)) and Input(1) and Input(2) and Enable;
  Output(7) <= Input(0) and Input(1) and Input(2) and Enable;
end IMP;
