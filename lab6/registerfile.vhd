library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.array2D.all;


entity registerfile is
    generic(n : integer := 32);
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
end registerfile;

architecture structure of registerfile is
  
  
  component and2
  port(
    i_A          : in std_logic;
    i_B          : in std_logic;
    o_F          : out std_logic
  );
end component;
  
  component thirtytwo_one_mux
 
  port(
    din : in array32_bit(n - 1 downto 0);
    sel : in STD_LOGIC_VECTOR(4 downto 0);
    dout : out STD_LOGIC_VECTOR(n - 1 downto 0)
  );
  end component;
  
  
  component single_reg
  port(
    clk:              in std_logic; 
    reset:            in std_logic; 
    enable:           in std_logic;    
    r_in:             in std_logic_vector(n-1 downto 0);
    r_out:            out std_logic_vector(n-1 downto 0) 
  );
  end component;
  
  component DEC_5T32
  port(
    Enable  : in std_logic;
    Input   : in std_logic_vector(4 downto 0);
    Output  : out std_logic_vector(n - 1 downto 0)  
  );
  end component;
  
  signal Asel : std_logic_vector(n - 1 downto 0);
  signal OReg : array32_bit(n - 1 downto 0);
  
  
  begin
    
      
      
    W1 : DEC_5T32 
    port MAP(
      we, wr, ASel
    );
    
    G1: for i in 0 to n-1 generate
    
    REGS : single_reg 
    port MAP(
      clk, '0', ASel(i), wdata, r_out => OReg(i)
    );
    
    end generate;
    MUX1 : thirtytwo_one_mux
    port MAP(
      OReg, rr1, rdata1
    );
    
    
    MUX2 : thirtytwo_one_mux
    port MAP(
      OReg, rr2, rdata2
    );
    
  
  
end structure;

