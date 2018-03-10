    library ieee;
    use ieee.std_logic_1164.all;
     
    entity MUX_21 is
    	port(
    		A: in std_logic_vector( 31 downto 0);
    		B: in std_logic_vector( 31 downto 0);
    		S: in std_logic;
    		Z: out std_logic_vector( 31 downto 0));
    end MUX_21;
     
    architecture main of MUX_21 is
    begin
      process(s,A,B)
    	   begin
    	     if( s ='1' )then
    	     Z <= A;
  	     else
  	       Z <= B;
	       end if;
	    end process;
    end main;