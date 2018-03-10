library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.array2D.all;


entity aplication is
    generic(N : integer := 32);
    port(
      --wdata  : out std_logic_vector(N-1 downto 0);
      imNum : in STD_LOGIC_VECTOR(N - 1 downto 0);
      nAdd_Sub_Switch : in STD_LOGIC;
      ALUSrc : in STD_LOGIC;
         clk : in STD_LOGIC;
         we : in STD_LOGIC;
         rr1 : in STD_LOGIC_VECTOR(4 downto 0);
         rr2 : in STD_LOGIC_VECTOR(4 downto 0);
         wr : in STD_LOGIC_VECTOR(4 downto 0)
         --wdata : in STD_LOGIC_VECTOR(n - 1 downto 0);
         --rdata1 : out STD_LOGIC_VECTOR(n - 1 downto 0);
         --rdata2 : out STD_LOGIC_VECTOR(n - 1 downto 0)
          );
end aplication;

architecture structure of aplication is
  
  component nAdd_Sub
  --generic(N : integer := 1);
  port(
    i_A  : in std_logic_vector(N-1 downto 0);
    i_B  : in std_logic_vector(N-1 downto 0);
    i_Switch  : in std_logic; -- 1: S = A - B, 0: S = A + B
    o_S  : out std_logic_vector(N-1 downto 0);
    o_Cout  :out std_logic
    );
  end component;
  
  component two_one_mux
  --generic(N : integer := 1);
  port(
    in_data : array32_bit(1 downto 0);
  S1 : in std_logic;
  O: out STD_LOGIC_VECTOR(31 downto 0)
  );
  end component;
  
  component registerfile
  --generic(N : integer := 1);
  port(
     clk : in STD_LOGIC;
         we : in STD_LOGIC;
         rr1 : in STD_LOGIC_VECTOR(4 downto 0);
         rr2 : in STD_LOGIC_VECTOR(4 downto 0);
         wr : in STD_LOGIC_VECTOR(4 downto 0);
         wdata : in STD_LOGIC_VECTOR(n - 1 downto 0);
         rdata1 : out STD_LOGIC_VECTOR(n - 1 downto 0);
         rdata2 : out STD_LOGIC_VECTOR(n - 1 downto 0)
         );
  end component;
  
  signal wdata  : std_logic_vector(N-1 downto 0); 
  signal rdata1  : std_logic_vector(N-1 downto 0);
  signal rdata2  : std_logic_vector(N-1 downto 0); 
  signal mux_to_ALU : std_logic_vector(N-1 downto 0);
  
  begin
   G1: for i in 0 to N-1 generate
     
   REG_F :  registerfile
   port MAP(
     clk, we, rr1, rr2, wr, wdata, rdata1, rdata2
   );
   
   MUX_32 : two_one_mux
   port MAP(
     in_data(0) => rdata2,
     in_data(1) => imNum,
     S1 => ALUSrc,
     O => mux_to_ALU
   );
   
   
   ALU : nAdd_Sub
   port MAP(
     rdata1, mux_to_ALU, nAdd_Sub_Switch, wdata
   );
   
 end generate;
  
end structure;