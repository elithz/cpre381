library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity multi_32 is 
  port( a : in std_logic_vector( 31 downto 0);
        b : in std_logic_vector( 31 downto 0);
        aisp: in std_logic;
        bisp: in std_logic;
        c : out std_logic_vector(31 downto 0));
end multi_32;

architecture extend of multi_32 is
    
component twoscompliment
  
  port( din : in std_logic_vector (31 downto 0);
        dout : out std_logic_vector (31 downto 0));
end component;

component MUX_21
  port(	A: in std_logic_vector( 31 downto 0);
    		  B: in std_logic_vector( 31 downto 0);
    		  S: in std_logic;
    		  Z: out std_logic_vector( 31 downto 0));
end component;
    
signal invert_a : std_logic_vector(31 downto 0);
signal invert_b : std_logic_vector(31 downto 0);
signal invert_c : std_logic_vector(63 downto 0);
signal in_a :std_logic_vector(31 downto 0);
signal in_b :std_logic_vector(31 downto 0);
signal out_c : std_logic_vector(63 downto 0);
signal abis :std_logic;
signal temp_c: std_logic_vector(63 downto 0);

    signal b0:          unsigned (31 downto 0);
    signal b1:          unsigned (31 downto 0);
    signal b2:          unsigned (31 downto 0);
    signal b3:          unsigned (31 downto 0);
    signal b4:          unsigned (31 downto 0);
    signal b5:          unsigned (31 downto 0);
    signal b6:          unsigned (31 downto 0);
    signal b7:          unsigned (31 downto 0);
    signal b8:          unsigned (31 downto 0);
    signal b9:          unsigned (31 downto 0);
    signal b10:          unsigned (31 downto 0);
    signal b11:          unsigned (31 downto 0);
    signal b12:          unsigned (31 downto 0);
    signal b13:          unsigned (31 downto 0);
    signal b14:          unsigned (31 downto 0);
    signal b15:          unsigned (31 downto 0);
    signal b16:          unsigned (31 downto 0);
    signal b17:          unsigned (31 downto 0);
    signal b18:          unsigned (31 downto 0);
    signal b19:          unsigned (31 downto 0);
    signal b20:          unsigned (31 downto 0);
    signal b21:          unsigned (31 downto 0);
    signal b22:          unsigned (31 downto 0);
    signal b23:          unsigned (31 downto 0);
    signal b24:          unsigned (31 downto 0);
    signal b25:          unsigned (31 downto 0);
    signal b26:          unsigned (31 downto 0);
    signal b27:          unsigned (31 downto 0);
    signal b28:          unsigned (31 downto 0);
    signal b29:          unsigned (31 downto 0);
    signal b30:          unsigned (31 downto 0);
    signal b31:          unsigned (31 downto 0);

    signal pp1:         unsigned (31 downto 0);
    signal pp2:         unsigned (31 downto 0);   
    signal pp3:         unsigned (31 downto 0); 
    signal pp4:         unsigned (31 downto 0);
    signal pp5:         unsigned (31 downto 0);
    signal pp6:         unsigned (31 downto 0);   
    signal pp7:         unsigned (31 downto 0); 
    signal pp8:         unsigned (31 downto 0);
    signal pp9:         unsigned (31 downto 0);
    signal pp10:         unsigned (31 downto 0);   
    signal pp11:         unsigned (31 downto 0); 
    signal pp12:         unsigned (31 downto 0);
    signal pp13:         unsigned (31 downto 0);
    signal pp14:         unsigned (31 downto 0);   
    signal pp15:         unsigned (31 downto 0); 
    signal pp16:         unsigned (31 downto 0);
    signal pp17:         unsigned (31 downto 0);
    signal pp18:         unsigned (31 downto 0);   
    signal pp19:         unsigned (31 downto 0); 
    signal pp20:         unsigned (31 downto 0);
    signal pp21:         unsigned (31 downto 0);
    signal pp22:         unsigned (31 downto 0);   
    signal pp23:         unsigned (31 downto 0); 
    signal pp24:         unsigned (31 downto 0);
    signal pp25:         unsigned (31 downto 0);
    signal pp26:         unsigned (31 downto 0);   
    signal pp27:         unsigned (31 downto 0); 
    signal pp28:         unsigned (31 downto 0);
    signal pp29:         unsigned (31 downto 0);
    signal pp30:         unsigned (31 downto 0);   
    signal pp31:         unsigned (31 downto 0); 
    signal pp32:         unsigned (31 downto 0);

    signal s:           unsigned (63 downto 0);
        
begin
  
  abis <= aisp and bisp;
  
  G1:twoscompliment
  port map( din => a,
        dout => invert_a);
  
  G2:twoscompliment
  port map( din => b,
        dout => invert_b); 
        
  G3: MUX_21
  port map( A => a,
            B => invert_a,
            S => aisp,
            Z => in_a);
            
  G4: MUX_21
  port map( A => b,
            B => invert_b,
            S => bisp,
            Z => in_b);                     
  
 
 

    -- AND Array Multiplies

    b0 <= (others => in_b(0));
    b1 <= (others => in_b(1));
    b2 <= (others => in_b(2));
    b3 <= (others => in_b(3));
    b4 <= (others => in_b(4));
    b5 <= (others => in_b(5));
    b6 <= (others => in_b(6));
    b7 <= (others => in_b(7));
    b8 <= (others => in_b(8));
    b9 <= (others => in_b(9));
    b10 <= (others => in_b(10));
    b11 <= (others => in_b(11));
    b12 <= (others => in_b(12));
    b13 <= (others => in_b(13));
    b14 <= (others => in_b(14));
    b15 <= (others => in_b(15));
    b16 <= (others => in_b(16));
    b17 <= (others => in_b(17));
    b18 <= (others => in_b(18));
    b19 <= (others => in_b(19));
    b20 <= (others => in_b(20));
    b21 <= (others => in_b(21));
    b22 <= (others => in_b(22));
    b23 <= (others => in_b(23));
    b24 <= (others => in_b(24));
    b25 <= (others => in_b(25));
    b26 <= (others => in_b(26));
    b27 <= (others => in_b(27));
    b28 <= (others => in_b(28));
    b29 <= (others => in_b(29));
    b30 <= (others => in_b(30));
    b31 <= (others => in_b(31));

    pp1 <= unsigned (in_a) and b0;

    pp2 <= unsigned (in_a) and b1;

    pp3 <= unsigned (in_a) and b2;

    pp4 <= unsigned (in_a) and b3;

    pp5 <= unsigned (in_a) and b4;

    pp6 <= unsigned (in_a) and b5;

    pp7 <= unsigned (in_a) and b6;

    pp8 <= unsigned (in_a) and b7;
    
    pp9 <= unsigned (in_a) and b8;

    pp10 <= unsigned (in_a) and b9;

    pp11 <= unsigned (in_a) and b10;

    pp12 <= unsigned (in_a) and b11;

    pp13 <= unsigned (in_a) and b12;

    pp14 <= unsigned (in_a) and b13;

    pp15 <= unsigned (in_a) and b14;

    pp16 <= unsigned (in_a) and b15;
    
    pp17 <= unsigned (in_a) and b16;

    pp18 <= unsigned (in_a) and b17;

    pp19 <= unsigned (in_a) and b18;

    pp20 <= unsigned (in_a) and b19;

    pp21 <= unsigned (in_a) and b20;

    pp22 <= unsigned (in_a) and b21;

    pp23 <= unsigned (in_a) and b22;

    pp24 <= unsigned (in_a) and b23;
    
    pp25 <= unsigned (in_a) and b24;

    pp26 <= unsigned (in_a) and b25;

    pp27 <= unsigned (in_a) and b26;

    pp28 <= unsigned (in_a) and b27;

    pp29 <= unsigned (in_a) and b28;

    pp30 <= unsigned (in_a) and b29;

    pp31 <= unsigned (in_a) and b30;

    pp32 <= unsigned (in_a) and b31;
    

    -- Sum

    s <=   ( '0' & pp32 & "0000000000000000000000000000000")
         + (       pp31 & "000000000000000000000000000000") 
         + (       pp30 & "00000000000000000000000000000") 
         + (       pp29 & "0000000000000000000000000000") 
         + (       pp28 & "000000000000000000000000000") 
         + (       pp27 & "00000000000000000000000000")  
         + (       pp26 & "0000000000000000000000000")  
         + (       pp25 & "000000000000000000000000") 
         + (       pp24 & "00000000000000000000000") 
         + (       pp23 & "0000000000000000000000") 
         + (       pp22 & "000000000000000000000") 
         + (       pp21 & "00000000000000000000")  
         + (       pp20 & "0000000000000000000") 
         + (       pp19 & "000000000000000000") 
         + (       pp18 & "00000000000000000") 
         + (       pp17 & "0000000000000000") 
         + (       pp16 & "000000000000000") 
         + (       pp15 & "00000000000000")  
         + (       pp14 & "0000000000000")     
         + (       pp13 & "000000000000") 
         + (       pp12 & "00000000000") 
         + (       pp11 & "0000000000") 
         + (       pp10 & "000000000") 
         + (       pp9  & "00000000")  
         + (       pp8  & "0000000") 
         + (       pp7  & "000000" ) 
         + (       pp6  & "00000"  ) 
         + (       pp5  & "0000"   ) 
         + (       pp4  & "000"    )  
         + (       pp3  & "00"     )
         + (       pp2  & '0'      )
         +         pp1;

    out_c <= std_logic_vector (s); 
    
    invert_c <= not(out_c) + 1;
        

        
    process(aisp,bisp,out_c,invert_c)
    	   begin
    	     if( aisp ='1' and bisp = '1' )then
    	     temp_c <= out_c;
  	     elsif( aisp = '1' and bisp = '0')then
  	       temp_c <= invert_c;
	      elsif( aisp ='0' and bisp = '1')then
	        temp_c <= invert_c;
	      else
	        temp_c <= out_c;
	       end if;
	    end process;
    
    A1: for i in 0 to 31 generate
    
    c(i) <= temp_c(i);
    
    end generate;
    
end architecture;