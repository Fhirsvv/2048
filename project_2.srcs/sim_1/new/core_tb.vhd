library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- NOTA: Asume que game_library.all no es necesario para el testbench si solo contiene tipos internos.
-- use work.game_library.all; 

entity core_tb is
end core_tb;

architecture Behavioral of core_tb is

    -- Componente a probar (Unit Under Test - UUT)
    component core is
    port(
        clk, reset : in std_logic;
        btn_up, btn_down, btn_left, btn_right : in std_logic;
        end_merge1, end_compact, end_merge2, end_aleatorio : in std_logic;
        enable_merge1, enable_compact, enable_merge2, enable_aleatorio : out std_logic;
        movimientos : out std_logic_vector(3 downto 0)
    );
    end component;

    -- Constantes para el reloj (ej. 100 MHz, Periodo de 10ns)
    constant CLK_PERIOD : time := 10 ns;

    -- Señales para el UUT
    signal clk_s, reset_s : std_logic := '0';
    signal btn_up_s, btn_down_s, btn_left_s, btn_right_s : std_logic := '0';
    signal end_merge1_s, end_compact_s, end_merge2_s, end_aleatorio_s : std_logic := '0';

    -- Señales de salida (Observables)
    signal enable_merge1_s, enable_compact_s, enable_merge2_s, enable_aleatorio_s : std_logic;
    signal movimientos_s : std_logic_vector(3 downto 0);

begin

    -- Instanciación del UUT (Device Under Test)
    uut: core port map (
        clk => clk_s,
        reset => reset_s,
        btn_up => btn_up_s,
        btn_down => btn_down_s,
        btn_left => btn_left_s,
        btn_right => btn_right_s,
        end_merge1 => end_merge1_s,
        end_compact => end_compact_s,
        end_merge2 => end_merge2_s,
        end_aleatorio => end_aleatorio_s,
        enable_merge1 => enable_merge1_s,
        enable_compact => enable_compact_s,
        enable_merge2 => enable_merge2_s,
        enable_aleatorio => enable_aleatorio_s,
        movimientos => movimientos_s
    );

    -- Generador de Clock
    clk_process : process
    begin
        clk_s <= '0';
        wait for CLK_PERIOD/2;
        loop
            clk_s <= '1';
            wait for CLK_PERIOD/2;
            clk_s <= '0';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Generador de Estímulos (El Escenario de Prueba)
    stim_process : process
    begin
        -- 1. Estado Inicial: Reset Asíncrono
        reset_s <= '1';
        wait for CLK_PERIOD * 2;
        reset_s <= '0';
        wait for CLK_PERIOD * 2; 

        -- FSM está en 'esperar'. mov_reg = "0000".

        ---------------------------------------------------
        -- 2. Iniciar Secuencia: Capturar movimiento (btn_up)
        ---------------------------------------------------
        -- Pulso de botón corto
        btn_up_s <= '1';
        wait for CLK_PERIOD; 
        btn_up_s <= '0';
        -- En el siguiente flanco de subida, mov_reg debe ser "1000",
        -- y el siguiente estado será 'merge1'.
        
        
        
        wait for CLK_PERIOD * 3;
        -- Ahora 'estado' es 'merge1', 'movimientos_s' es "1000", 'enable_merge1_s' es '1'.
        
        ---------------------------------------------------
        -- 3. Transición a 'compact'
        ---------------------------------------------------
        -- Forzar finalización de merge1
        end_merge1_s <= '1';
        wait for CLK_PERIOD; 
        end_merge1_s <= '0';
        -- El siguiente estado será 'compact'.

        wait for CLK_PERIOD * 3;
        -- Ahora 'estado' es 'compact', 'enable_compact_s' es '1'.

        ---------------------------------------------------
        -- 4. Transición a 'merge2'
        ---------------------------------------------------
        -- Forzar finalización de compact
        end_compact_s <= '1';
        wait for CLK_PERIOD; 
        end_compact_s <= '0';
        -- El siguiente estado será 'merge2'.

        wait for CLK_PERIOD * 3;
        -- Ahora 'estado' es 'merge2', 'enable_merge2_s' es '1'.

        ---------------------------------------------------
        -- 5. Transición a 'aleatorio'
        ---------------------------------------------------
        -- Forzar finalización de merge2
        end_merge2_s <= '1';
        wait for CLK_PERIOD; 
        end_merge2_s <= '0';
        -- El siguiente estado será 'aleatorio'.

        wait for CLK_PERIOD * 3;
        -- Ahora 'estado' es 'aleatorio', 'enable_aleatorio_s' es '1'.
        
        ---------------------------------------------------
        -- 6. Transición de vuelta a 'esperar' y borrado de 'mov_reg'
        ---------------------------------------------------
        -- Forzar finalización de aleatorio
        end_aleatorio_s <= '1';
        wait for CLK_PERIOD; 
        end_aleatorio_s <= '0';
        -- El siguiente estado será 'esperar'. mov_reg se borrará.

        wait for CLK_PERIOD * 3;
        -- Ahora 'estado' es 'esperar', 'movimientos_s' es "0000".

        ---------------------------------------------------
        -- 7. FIN DE LA SIMULACIÓN
        ---------------------------------------------------
        wait; -- Detiene el proceso de estímulos
    end process;

end Behavioral;