library IEEE;
use IEEE.std_logic_1164.all;

Entity bshift is   
      port (
        i_Drc : in  std_logic; -- '1' for left, '0' for right
        i_Typ : in  std_logic; -- '1' for logical, '0' for arithmetic
        i_SB : in  std_logic_vector(4 downto 0);  -- shift count
        i_Data : in  std_logic_vector (31 downto 0);
        o_Out : out std_logic_vector (31 downto 0) 
        );
end entity bshift;


architecture mixed of bshift is
  
  
  
  
  function to_integer(sig : std_logic_vector) return integer is
    variable num : integer := 0;
  begin
    for i in sig'range loop
      if sig(i)='1' then
        num := num * 2 + 1;
      else
        num := num * 2;
      end if;
    end loop;  -- i
    return num;
  end to_integer;




begin 
  
  process(i_Drc, i_Typ, i_Data, i_SB)
    
   variable shft : integer;
   variable out_right_arithmetic : std_logic_vector(31 downto 0);
   variable out_right_logical    : std_logic_vector(31 downto 0);
   variable out_left_logical     : std_logic_vector(31 downto 0);
   
  begin
    
    shft := to_integer(i_SB);
    
    if i_Typ = '0' then
      out_right_arithmetic := (31 downto 32-shft => i_Data(31)) & i_Data(31 downto shft);
      o_Out <= out_right_arithmetic after 250 ps;
    else
      if i_Drc = '1' then
        out_left_logical := i_Data(31-shft downto 0) & (shft-1 downto 0 => '0');
        o_Out <= out_left_logical after 250 ps;
      else
        out_right_logical := (31 downto 32-shft => '0') & i_Data(31 downto shft);
        o_Out <= out_right_logical after 250 ps;
      end if;
    end if;
    
  end process;
end mixed;