library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- importa tu paquete con la definición de t_tablero y los procedimientos
use work.game_library.all;  

entity tb_fsm is
end tb_fsm;

architecture sim of tb_fsm is
  -- Señales de prueba
  signal clk, reset       : std_logic := '0';
  signal btn_up, btn_down : std_logic := '0';
  signal btn_left, btn_right : std_logic := '0';
  signal tablero_salida   : t_tablero;

  -- Reloj: 10 ns -> 100 MHz
  constant clk_period : time := 10 ns;

begin
  -- DUT
  uut: entity work.fsm
    port map(
      clk => clk,
      reset => reset,
      btn_up => btn_up,
      btn_down => btn_down,
      btn_left => btn_left,
      btn_right => btn_right,
      tablero_salida => tablero_salida
    );

  -- Generación del reloj
  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
    end loop;
  end process;

  -- Estímulos
  stim_proc : process
  begin
    -- Reset inicial
    reset <= '1';
    wait for 2*clk_period;
    reset <= '0';
    wait for 5*clk_period;

    -- Pulsar LEFT
    btn_left <= '1';
    wait for clk_period;
    btn_left <= '0';

    -- Esperar a que pase por mover + aleatorio
    wait for 20*clk_period;

    -- Pulsar UP
    btn_up <= '1';
    wait for clk_period;
    btn_up <= '0';
    wait for 20*clk_period;

    -- Pulsar RIGHT
    btn_right <= '1';
    wait for clk_period;
    btn_right <= '0';
    wait for 20*clk_period;

    -- Pulsar DOWN
    btn_down <= '1';
    wait for clk_period;
    btn_down <= '0';
    wait for 20*clk_period;

    wait; -- detener simulación
  end process;

  -- Proceso de monitorización (para ver cambios de tablero)
  monitor : process(clk)
  begin
    if rising_edge(clk) then
      report "Tablero actualizado:";
      for r in 0 to 3 loop
        report integer'image(tablero_salida(r)(0)) & " "
             & integer'image(tablero_salida(r)(1)) & " "
             & integer'image(tablero_salida(r)(2)) & " "
             & integer'image(tablero_salida(r)(3));
      end loop;
    end if;
  end process;

end sim;

