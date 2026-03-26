library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity merge is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    in_tablero : in t_tablero;
    movimiento : in std_logic_vector(3 downto 0);
    out_tablero : out t_tablero;
    fin : out std_logic
  );
end merge;

architecture Behavioral of merge is

    pure function fmerge (line : t_columna) return t_columna is
      variable aux : t_columna := (others =>0);
      variable j : integer := 0;
    begin
        for i in 0 to 3 loop
            if line(i) /= 0 then
                aux(j) := line(i);
                j := j + 1;
            end if;
         end loop;
         return aux;
      end function;

      signal union, tmp : t_tablero;
      
begin


process_merge : process(clk, reset)
variable j,i : integer range 0 to 3 := 0;
variable z : unsigned (1 downto 0) := "00";
begin
    if reset = '1' then
        union <= (others =>(others => 0));
        tmp <= (others =>(others => 0));
    elsif clk'event and clk = '1' then
     if enable = '1' then
     if movimiento = "1000" then --up
--            for j in 0 to 3 loop
--                for i in 0 to 3 loop
--                    union(i)(j) <= in_tablero(j)(i);
--                end loop;
--                tmp(j) <= fmerge(union(j));
--            end loop;

--            for x in 0 to 3 loop
--            j := 0;
--                for y in 0 to 3 loop
--                    if in_tablero(y)(x) /= 0 then
--                        tmp(j)(i) <= in_tablero(y)(x);
--                        j := j + 1;
--                    end if;
--                end loop;
--                 i := i + 1;
--            end loop;
         elsif movimiento = "0100" then --down
--           for j in 3 to 0 loop
--                for i in 3 to 0 loop
--                    union(i)(j) <= in_tablero(j)(i);
--                end loop;
--                tmp(j) <= fmerge(union(j));
--            end loop;
--            for x in 0 to 3 loop
--                for y in 0 to 3 loop
--                    if in_tablero(3-y)(x) /= 0 then
--                        tmp(3-(TO_INTEGER(z)))(x) <= in_tablero(3-y)(x);
--                        z := z + 1;
--                    end if;
--                end loop;
--            end loop;
         elsif movimiento = "0001" then -- right
--            for j in 0 to 3 loop
--                tmp(j) <= fmerge(in_tablero(j));
--            end loop;
            
         elsif movimiento = "0010" then -- left
--             for j in 3 to 0 loop
--                for i in 3 to 0 loop
--                    union(i)(j) <= in_tablero(3 - i)(j);
--                end loop;
--                tmp(j) <= fmerge(union(j));
--            end loop;

--            for y in 0 to 3 loop
--                for x in 0 to 3 loop
--                    if in_tablero(y)(3-x) /= 0 then
--                        tmp(i)(3-j) <= in_tablero(y)(3-x);
--                        j := j + 1;
--                    end if;    
--                end loop;
 --             i := i + 1;
--            end loop;
            
          end if;
        end if;
      end if;
end process;

fin <= '1' when enable = '1' else '0';
out_tablero <= tmp;
end Behavioral;
