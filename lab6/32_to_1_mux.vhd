library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.array2D.all;


entity thirtytwo_one_mux is
     port(
         din : in array32_bit(31 downto 0);
         sel : in STD_LOGIC_VECTOR(4 downto 0);
         dout : out STD_LOGIC_VECTOR(31 downto 0)
         );
end thirtytwo_one_mux;

architecture structure of thirtytwo_one_mux is

  component eit_one_mux
    port (
      din : in array32_bit(7 downto 0);
      sel : in STD_LOGIC_VECTOR(2 downto 0);
      dout : out STD_LOGIC_VECTOR(31 downto 0)
    );
  end component;
   
  component four_one_mux
    port(
      in_data : array32_bit(3 downto 0);
      S1,S2: in std_logic;
      O: out STD_LOGIC_VECTOR(31 downto 0)
    );
  end component;

  signal four_in1, four_in2, four_in3, four_in4 : STD_LOGIC_VECTOR(31 downto 0);

  begin
  ei_2_one1: eit_one_mux
  port MAP(
    din(0) => din(0),
    din(1) => din(1),
    din(2) => din(2),
    din(3) => din(3),
    din(4) => din(4),
    din(5) => din(5),
    din(6) => din(6),
    din(7) => din(7),
    sel(0) => sel(0),
    sel(1) => sel(1),
    sel(2) => sel(2),
    dout => four_in1
  );
  ei_2_one2: eit_one_mux
  port MAP(
    din(0) => din(8),
    din(1) => din(9),
    din(2) => din(10),
    din(3) => din(11),
    din(4) => din(12),
    din(5) => din(13),
    din(6) => din(14),
    din(7) => din(15),
    sel(0) => sel(0),
    sel(1) => sel(1),
    sel(2) => sel(2),
    dout => four_in2
  );
  ei_2_one3: eit_one_mux
  port MAP(
    din(0) => din(16),
    din(1) => din(17),
    din(2) => din(18),
    din(3) => din(19),
    din(4) => din(20),
    din(5) => din(21),
    din(6) => din(22),
    din(7) => din(23),
    sel(0) => sel(0),
    sel(1) => sel(1),
    sel(2) => sel(2),
    dout => four_in3
  );
  ei_2_one4: eit_one_mux
  port MAP(
    din(0) => din(24),
    din(1) => din(25),
    din(2) => din(26),
    din(3) => din(27),
    din(4) => din(28),
    din(5) => din(29),
    din(6) => din(30),
    din(7) => din(31),
    sel(0) => sel(0),
    sel(1) => sel(1),
    sel(2) => sel(2),
    dout => four_in4
  );
  
  fo_2_one: four_one_mux
  port MAP(
    in_data(0) => four_in1,
    in_data(1) => four_in2,
    in_data(2) => four_in3,
    in_data(3) => four_in4,
    S1 => sel(3),
    S2 => sel(4),
    O => dout
  );

end structure;