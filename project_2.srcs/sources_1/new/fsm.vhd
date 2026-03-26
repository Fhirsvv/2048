library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;
use work.funciones.all;

entity fsm is
  Port (
     clk, reset : in std_logic;
     btn_up, btn_down, btn_left, btn_right : in std_logic;
     tablero_salida : out t_tablero
  );
end fsm;

architecture Behavioral of fsm is
    type t_estado is (start, espera, mover, aleatorios);
    signal estado, siguiente : t_estado;
    
    signal tablero : t_tablero := ((2,0,0,0), (0,2,2,0), (2,0,0,2), (0,0,0,0));
    signal mov_reg : std_logic_vector(3 downto 0) := (others => '0');
    
    signal puntuacion : integer := 0;

begin

  seq : process(clk, reset)
    variable tab_temp : t_tablero := (others => (others => 0));
    variable no_aleatorio : boolean := false;
  begin
    if reset = '1' then
      estado      <= start;
      mov_reg     <= nulo;
      tab_temp     := ((0,0,0,0), (0,0,1,0), (0,0,0,0), (0,0,0,0));
      puntuacion <= 0;
    elsif rising_edge(clk) then
      estado <= siguiente;
     --tab_temp := tablero;
      case estado is
        when start =>
             
        when espera =>
            if btn_up = '1' then
                mov_reg <= up;
            elsif btn_down = '1' then
                mov_reg <= down;
            elsif btn_right = '1' then
                mov_reg <= right;
            elsif btn_left = '1' then
                mov_reg <= left;
            end if;

        when mover =>
         --tab_temp := tablero;
          if mov_reg = right then
            mover_derecha(tab_temp, puntuacion);
            --tablero <= tab_temp;
          elsif mov_reg = left then
            mover_izquierda(tab_temp, puntuacion);
            --tablero <= tab_temp;
          elsif mov_reg = up then
            mover_arriba(tab_temp, puntuacion);
             --tablero <= tab_temp;
          elsif mov_reg = down then
            mover_abajo(tab_temp, puntuacion);
            --insertar_ficha_simple(tab_temp);
          tablero <= tab_temp;  
          end if;
          
        when aleatorios =>
           --tab_temp := tablero;
           insertar_ficha_simple(tab_temp);
           
           mov_reg <= nulo;
        when others =>
          null;
      end case;
    end if;
    tablero <= tab_temp;
  end process;


  comb : process(estado, mov_reg)
  begin
    case estado is
      when start =>
        siguiente <= aleatorios;
      when espera =>
        if mov_reg /= nulo then
          siguiente <= mover;
        else
          siguiente <= espera;
        end if;

      when mover =>
        siguiente <= aleatorios;

      when others => --aleatorios
        siguiente <= espera;
    end case;
  end process;

 tablero_salida <= tablero;

end Behavioral;


