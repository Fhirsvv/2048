library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.game_library.all;

entity tb_2048 is
end entity;

architecture sim of tb_2048 is
  signal tablero : t_tablero := ((2,2,4,0),(0,2,4,2),(1,5,1,1),(2,2,2,2));
  signal clk : std_logic := '0';
    signal ciclos : integer := 0;
signal terminado : boolean := false;
begin



-- Generador de reloj
clk_process : process
begin
  clk <= '0';
  wait for 5 ns;  -- medio periodo
  clk <= '1';
  wait for 5 ns;  -- medio periodo
end process;


process(clk)
  variable tab_tmp : t_tablero;
begin
  if rising_edge(clk) then
    if not terminado then
      ciclos <= ciclos + 1;

      -- Copiar tablero a variable
      tab_tmp := tablero;

      -- Llamar al procedimiento
     --mover_izquierda(tab_tmp);
       -- mover_derecha(tab_tmp);
       --mover_arriba(tab_tmp);
       --mover_abajo(tab_tmp);
       insertar_ficha_simple(tab_tmp);
      -- Actualizar el signal con el resultado
      tablero <= tab_tmp;

      -- Marcar que terminó
      terminado <= true;

      report "Procedimiento ejecutado en " & integer'image(ciclos) & " ciclos de reloj";
    end if;
  end if;
end process;



end architecture;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

---- Importamos el paquete con el procedimiento
--use work.game_library.all;

--entity tb_2048 is
--end entity;

--architecture sim of tb_2048 is
--  signal tablero : t_tablero := (others => (others => 0));
--begin
--  process
--    variable cambio : boolean;
--     variable tab_tmp : t_tablero;
--  begin
--    -- Estado inicial
--    tablero(0)(0) <= 2;
--    tablero(0)(1) <= 2;
--    tablero(0)(2) <= 4;
--    tablero(0)(3) <= 0;

--    wait for 10 ns;

--    -- Mostrar tablero inicial
--    for r in 0 to 3 loop
--      report "Fila " & integer'image(r) & " = " &
--             integer'image(tablero(r)(0)) & " " &
--             integer'image(tablero(r)(1)) & " " &
--             integer'image(tablero(r)(2)) & " " &
--             integer'image(tablero(r)(3));
--    end loop;

--    -- Copiar signal a variable temporal
   
--    tab_tmp := tablero;

--    -- Llamar al procedimiento
--    mover_izquierda(tab_tmp);

--    -- Actualizar signal con el resultado
--    tablero <= tab_tmp;

--    wait for 10 ns;

--    -- Mostrar tablero después del movimiento
--    for r in 0 to 3 loop
--      report "Fila " & integer'image(r) & " = " &
--             integer'image(tablero(r)(0)) & " " &
--             integer'image(tablero(r)(1)) & " " &
--             integer'image(tablero(r)(2)) & " " &
--             integer'image(tablero(r)(3));
--    end loop;

--    -- Mostrar si hubo cambio
--    if cambio then
--      report "Hubo un cambio en el tablero";
--    else
--      report "No hubo cambios en el tablero";
--    end if;

--    wait;
--  end process;
--end architecture;
