library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity eit_one_mux is
     port(
         din : in STD_LOGIC_VECTOR(7 downto 0);
         sel : in STD_LOGIC_VECTOR(2 downto 0);
         dout : out STD_LOGIC
     );
end eit_one_mux;

architecture structure of eit_one_mux is
begin
  
    dout <= din(0) when (sel="000") else
            din(1) when (sel="001") else
            din(2) when (sel="010") else
            din(3) when (sel="011") else
            din(4) when (sel="100") else
            din(5) when (sel="101") else
            din(6) when (sel="110") else
            din(7);

end structure;
