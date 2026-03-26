library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.funciones.all;
use ieee.numeric_std.all;
use work.game_library.all;

entity functions_tb is
--  Port ( );
end functions_tb;

architecture Behavioral of functions_tb is
    signal Tablero:t_Tablero:=((2,2,2,0),(2,2,0,4),(0,0,0,0),(0,1,0,2));
    signal Dir:std_logic_vector(1 downto 0):="00";
begin
    process
    begin
        wait for 10us;
        Tablero<=move(Tablero,Dir);
        wait for 2us;
        Tablero<=join(Tablero,Dir);
        wait for 2us;
        Tablero<=move(Tablero,Dir);
        if unsigned(Dir)<"11" then
            Dir<=std_logic_vector(unsigned(Dir)+1);
        else
            Dir<="00";
        end if;
 
    end process;

end Behavioral;
