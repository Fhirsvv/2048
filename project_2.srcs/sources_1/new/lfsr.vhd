library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lfsr is
  Port (
    clk   : in  std_logic;
    reset : in  std_logic;
    lfsr_out : out std_logic_vector(7 downto 0)
  );
end lfsr;

architecture Behavioral of lfsr is
  signal lfsr_reg : std_logic_vector(7 downto 0) := "10101010"; -- semilla inicial
begin
  process(clk, reset)
    variable feedback : std_logic;
  begin
    if reset = '1' then
      lfsr_reg <= "10101010";  -- semilla
    elsif rising_edge(clk) then
      -- LFSR con taps en bits 8 y 6 (x^8 + x^6 + 1)
      feedback := lfsr_reg(7) xor lfsr_reg(5);
      lfsr_reg <= lfsr_reg(6 downto 0) & feedback;
    end if;
  end process;

  lfsr_out <= lfsr_reg;
end Behavioral;

