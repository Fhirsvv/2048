library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector_flanco is
  Port (
    clk, reset, s : in std_logic;
    sout : out std_logic
  );
end detector_flanco;

architecture Behavioral of detector_flanco is
 signal s1,s2 : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            s1 <= '0';
            s2 <= '1';
        elsif rising_edge(clk) then
            s1 <= s;
            s2 <= s1;
        end if;
    end process;
    
    sout <= s1 and not s2;

end Behavioral;
