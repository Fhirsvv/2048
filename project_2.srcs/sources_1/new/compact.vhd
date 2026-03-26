library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;

entity compact is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    in_tablero : in t_tablero;
    movimiento : in std_logic_vector(3 downto 0);
    out_tablero : out t_tablero;
    fin : out std_logic
  );
end compact;

architecture Beh of compact is

    pure function fcompact (line : t_columna) return t_columna is
        variable aux : t_columna := (others =>0);
        variable j : integer := 0;
    begin
         for i in 0 to 2 loop
            if aux(i) = aux(i + 1) and aux(i) /= 0 then
              --aux(i) := std_logic_vector(unsigned(aux(i) + 1));
              aux(i) := aux(i) + 1;
              aux(i + 1) := 0;
            end if;
          end loop;
        return aux;
    end function;
    
    signal union, tmp : t_tablero;
begin

process_compact : process(clk, reset)
begin
    if reset = '1' then
        union <= (others =>(others => 0));
        tmp <= (others =>(others => 0));
    elsif clk'event and clk = '1' then
    if enable = '1' then
--     if movimiento(3) = '1' then --up
--            for j in 0 to 3 loop
--                for i in 0 to 3 loop
--                    union(i)(j) <= in_tablero(j)(i);
--                end loop;
--                tmp(j) <= fcompact(union(j));
--            end loop;
--         elsif movimiento(2) = '1' then --down
--           for j in 3 to 0 loop
--                for i in 3 to 0 loop
--                    union(i)(j) <= in_tablero(j)(i);
--                end loop;
--                tmp(j) <= fcompact(union(j));
--            end loop;
--         elsif movimiento(1) = '1' then -- right
--            for j in 0 to 3 loop
--                tmp(j) <= fcompact(in_tablero(j));
--            end loop;
--         elsif movimiento(0) = '1' then -- left
--             for j in 3 to 0 loop
--                for i in 3 to 0 loop
--                    union(i)(j) <= in_tablero(3 - i)(j);
--                end loop;
--                tmp(j) <= fcompact(union(j));
--            end loop;
--          end if;
        end if;
      end if;
end process;

fin <= '1' when enable = '1' else '0';
out_tablero <= tmp;
end Beh;