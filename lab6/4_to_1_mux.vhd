library ieee;
use work.array2D.all;
use ieee.std_logic_1164.all;

entity four_one_mux is
port( 
  in_data : array32_bit(3 downto 0);
  S1,S2: in std_logic;
  O: out STD_LOGIC_VECTOR(31 downto 0)
);
end four_one_mux;

architecture behavioral of four_one_mux is
  
begin

    O<= in_data(0) when (S1='0' and S2='0') else
        in_data(1) when (S1='0' and S2='1') else
        in_data(2) when (S1='1' and S2='0') else
        in_data(3);

end behavioral;