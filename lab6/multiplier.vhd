library IEEE;
use IEEE.std_logic_1164.all;

entity multiplier is


  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);
       o_Q          : out std_logic_vector(31 downto 0));

end multiplier;

architecture mixed of multiplier is
  signal s_Q    : std_logic_vector(31 downto 0);

begin
  
  
  -- Create a multiplexed input to the FF based on i_WE
  --with i_WE select
    --s_D <= i_D when '1',
      --     s_Q when others;
  
  -- This process handles the asyncrhonous reset and
  -- synchronous write. We want to be able to reset 
  -- our processor's registers so that we minimize
  -- glitchy behavior on startup.
  process (i_CLK, i_RST)
  begin
	if (i_RST = '1') then
		s_Q <= (others => '0');
	else
		if (rising_edge(i_CLK)) then
			if (i_WE = '1') then
				s_Q(31 downto 0) <= i_D;
			else -- shift right
				s_Q(31) <= '0';
				s_Q(30 downto 0) <= s_Q(31 downto 1);
				
			end if;
		end if;
	end if;

  end process;
  -- The output of the FF is fixed to s_Q
  o_Q <= s_Q;
  
end mixed;