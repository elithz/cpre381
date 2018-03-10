library ieee;
use ieee.std_logic_1164.all;

entity two_one_mux is
port( 
  in_data : std_logic_vector(1 downto 0);
  S1 : in std_logic;
  O: out STD_LOGIC
);
end two_one_mux;

architecture behavioral of two_one_mux is
  
begin

    O<= in_data(0) when (S1='0') else
        in_data(1); 

end behavioral;
