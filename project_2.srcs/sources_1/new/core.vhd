library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;

entity core is
port(
    clk, reset : in std_logic;
    btn_up, btn_down, btn_left, btn_right : in std_logic;
    end_merge1, end_compact, end_merge2, end_aleatorio : in std_logic;
    enable_merge1, enable_compact, enable_merge2, enable_aleatorio : out std_logic;
    movimientos : out std_logic_vector(3 downto 0)
);
end core;

architecture Behavioral of core is
    type testado is (esperar, merge1, compact, merge2, aleatorio); -->controlador ->vga
    signal estado, siguiente : testado := esperar;
    signal mov_reg : std_logic_vector(3 downto 0) := (others => '0');
begin
  seq : process(clk, reset)
  begin
    if reset = '1' then
      estado <= esperar;
      mov_reg <= (others => '0');
     -- siguiente <= esperar;
    elsif clk'event and clk = '1' then
      estado <= siguiente;
      
      if estado = aleatorio and end_aleatorio = '1' then
         mov_reg <= (others => '0');
       elsif mov_reg = "0000" then
         if btn_up = '1' then
            mov_reg <= "1000";
         elsif btn_down = '1' then
            mov_reg <= "0100";
         elsif btn_left = '1' then
            mov_reg <= "0010";
         elsif btn_right = '1' then
            mov_reg <= "0001";
         end if;
       end if;
    end if;
  end process;
  
   enable_merge1 <= '1' when estado = merge1 else '0';
   enable_merge2 <= '1' when estado = merge2 else '0';
   enable_compact <= '1' when estado = compact else '0';
   enable_aleatorio <= '1' when estado = aleatorio else '0';
  
  process(estado, end_merge1, end_compact, end_merge2, end_aleatorio, mov_reg)
  begin
    case estado is
      when esperar =>
        if mov_reg /= "0000" then
          siguiente <= merge1;
        else
          siguiente <= estado;
        end if;
      when merge1 =>
        if end_merge1 = '1' then
          siguiente <= compact;
        else
          siguiente <= estado;
        end if;
      when compact =>
        if end_compact = '1' then
          siguiente <= merge2;
        else
          siguiente <= estado;
        end if;
      when merge2 =>
        if end_merge2 = '1' then
          siguiente <= aleatorio;
        else
          siguiente <= estado;
        end if;
      when aleatorio =>
        if end_aleatorio = '1' then
          siguiente <= esperar;
        else
          siguiente <= estado;
        end if;
    end case;
  end process;
  movimientos <= mov_reg;

end Behavioral;
