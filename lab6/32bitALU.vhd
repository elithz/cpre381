library IEEE;
use IEEE.std_logic_1164.all;


entity thir_two_bit_ALU is
  port(
    i_A  : in std_logic_vector(31 downto 0);
    i_B  : in std_logic_vector(31 downto 0);
    i_Op  : in std_logic_vector(2 downto 0);
    i_SorU : in std_logic;
    o_Re  : out std_logic_vector(31 downto 0);
    o_Of  : out std_logic;
    o_Zero : out std_logic
    );
end thir_two_bit_ALU;

architecture mixed of thir_two_bit_ALU is
  component one_bit_ALU
    port(
      i_A  : in std_logic;
      i_B  : in std_logic;
      i_Cin : in std_logic;
      i_Op  : in std_logic_vector(2 downto 0);
      i_Les : in std_logic;
      o_Re  : out std_logic;
      o_Cout  :out std_logic;
      o_Set : out std_logic
    );
  end component;
  
  
  signal  i_Cin : std_logic;
  signal o_Cout : std_logic;
  signal car_int : std_logic_vector(32 downto 0);
  signal o_Set : std_logic_vector(31 downto 0);
  signal o_Re_temp : std_logic_vector(31 downto 0);
  
  
  begin
    
    --i_Binv <= '1' when (i_Op = "011") else '0';
    i_Cin <= '1' when (i_Op = "011") else 
             '1' when (i_Op = "111") else
             '0';
      
    
    G1: for i in 0 to 31 generate
      obA0 : one_bit_ALU
      port MAP(
        i_A   => i_A(i),
        i_B   => i_B(i),
        i_Cin => car_int(i),
        i_Op  => i_Op,
        i_Les => '0',
        o_Re  => o_Re_temp(i),
        o_Cout => car_int(i + 1),
        o_Set => o_Set(i)
      );
    end generate;
    
    car_int(0) <= i_Cin;
    o_Cout <= car_int(32);
    
    --o_Re <= o_Re_temp;
    
    process(i_Op, o_Set, o_Re_temp)
      begin
        if (i_Op = "111") then
          o_Re(31 downto 1) <= "0000000000000000000000000000000";
          o_Re(0) <= o_Set(31);
        else
          o_Re <= o_Re_temp;
        end if;
    end process;
    
    --o_Re <= ("00000000000000000000000000000000 o_Set(31)) when (i_Op = "111") else o_Re_temp;
  process(i_SorU, i_A, i_B, o_Re_temp)
    begin
      if (i_SorU = '0') then
        if (i_Op = "010") then
          o_Of <= o_Cout;
        elsif (i_Op = "011") then
          o_Of <= o_Cout;
        else
          o_Of <= '0';
        end if;
      else
        if (i_Op = "010") then
          o_Of <= (i_A(31) and i_B(31) and ( not o_Re_temp(31))) or (( not i_A(31)) and ( not i_B(31)) and o_Re_temp(31));
        elsif (i_Op = "011") then
          o_Of <= (i_A(31) and i_B(31) and ( not o_Re_temp(31))) or (( not i_A(31)) and ( not i_B(31)) and o_Re_temp(31));
        else
          o_Of <= '0';
        end if;
      end if;
    end process;
    
    o_Zero <= '1' when (o_Re_temp = "00000000000000000000000000000000") else
              '0';
    
  end mixed;
        