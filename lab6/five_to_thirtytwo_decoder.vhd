library ieee;
use ieee.std_logic_1164.all;


entity DEC_5T32 is 
  port(
    Enable  : in std_logic;
    Input   : in std_logic_vector(4 downto 0);
    Output  : out std_logic_vector(31 downto 0)
  );
end DEC_5T32;


architecture IMP of DEC_5T32 is
  
  component DEC_2TO4
    port(
      Input : in std_logic_vector(1 downto 0);
      Output : out std_logic_vector(3 downto 0)
    );
  end component;
  
  component DEC_3TO8
    port(
      Enable : in std_logic;
      Input : in std_logic_vector(2 downto 0);
      Output : out std_logic_vector(7 downto 0)
    );
  end component;

  
  signal enable_1, enable_2, enable_3, enable_4 : std_logic;
  
  begin
    
  d2_4: DEC_2TO4
  port MAP(
    Input(0) => Input(3),
    Input(1) => Input(4), 
    Output(0) => enable_1, 
    Output(1) => enable_2,
    Output(2) => enable_3,
    Output(3) => enable_4
  );
    
  d3_8_1: DEC_3TO8
  port MAP(
    Enable => enable_1,
    Input(0) => Input(0),
    Input(1) => Input(1),
    Input(2) => Input(2),
    Output(0) => Output(0),
    Output(1) => Output(1),
    Output(2) => Output(2),
    Output(3) => Output(3),
    Output(4) => Output(4),
    Output(5) => Output(5),
    Output(6) => Output(6),
    Output(7) => Output(7)
  );
  d3_8_2: DEC_3TO8
  port MAP(
    Enable => enable_2,
    Input(0) => Input(0),
    Input(1) => Input(1),
    Input(2) => Input(2),
    Output(0) => Output(8),
    Output(1) => Output(9),
    Output(2) => Output(10),
    Output(3) => Output(11),
    Output(4) => Output(12),
    Output(5) => Output(13),
    Output(6) => Output(14),
    Output(7) => Output(15)
  );
  d3_8_3: DEC_3TO8
  port MAP(
    Enable => enable_3,
    Input(0) => Input(0),
    Input(1) => Input(1),
    Input(2) => Input(2),
    Output(0) => Output(16),
    Output(1) => Output(17),
    Output(2) => Output(18),
    Output(3) => Output(19),
    Output(4) => Output(20),
    Output(5) => Output(21),
    Output(6) => Output(22),
    Output(7) => Output(23)
  );
  d3_8_4: DEC_3TO8
  port MAP(
    Enable => enable_4,
    Input(0) => Input(0),
    Input(1) => Input(1),
    Input(2) => Input(2),
    Output(0) => Output(24),
    Output(1) => Output(25),
    Output(2) => Output(26),
    Output(3) => Output(27),
    Output(4) => Output(28),
    Output(5) => Output(29),
    Output(6) => Output(30),
    Output(7) => Output(31)
  );
end IMP;