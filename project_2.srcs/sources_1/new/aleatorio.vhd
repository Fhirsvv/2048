library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;


entity aleatorio is
  Port (
  clk : in std_logic;
  reset : in std_logic;
  enable : in std_logic;
  in_tablero : in t_tablero;
  end_aleatorio : out std_logic;
  out_tablero : out t_tablero
  );
end aleatorio;

architecture Behavioral of aleatorio is
    signal count : integer range 0 to 16;
    --signal count2 : integer range 0 to 16;
    signal tablero : t_tablero;
    signal fin : std_logic;
    signal tmp : t_tablero;
begin
   -- tablero <= in_tablero;
    process(clk, reset)
      
      variable count2 : integer range 0 to 16;
        variable tab_temp : t_tablero;
        variable done : boolean := false;
    begin
        if reset = '1' then
            count <= 0;
        elsif clk'event and clk = '1' then
            tab_temp := in_tablero;
            fin <= '0';
            count <= count + 1;
            if count = 16 then
                count <= 0;
            end if;
            
            if enable = '1' then
              count2 := count;
              tab_temp := in_tablero;
              for c in  0 to 16 loop
                for i in  0 to 3 loop
                  for j in 0 to 3 loop
                    if tab_temp(j)(i) = 0 and count2 - c = 0 and not done then
                      tab_temp(j)(i) := 1;
                      done := true;
                    end if;
                  end loop;
                end loop;
              end loop;
             fin <= '1';
             tmp <= tab_temp;
            end if;
        end if;
    end process;
out_tablero <= tmp;
--process(fin, in_tablero, tmp)
--begin
--    if fin = '1' then
        
--    else
--        out_tablero <= in_tablero;
--    end if;
--end process;

end_aleatorio <= fin;

end Behavioral;
