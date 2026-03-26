library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;


entity game_v1 is
  Port (
    clk, reset : in std_logic;
    --fsm
    up, down, left, right : in std_logic;
    --vga
    hsync, vsync : out std_logic;
    R, G, B : out std_logic
  );
end game_v1;

architecture Behavioral of game_v1 is

  component clk_wiz_0 is
  port (
  clk_out1 : out std_logic;
  reset : in std_logic;
  clk_in1 : in std_logic
  ); end component;
  
  component fsm is
    Port (
      clk, reset : in std_logic;
      btn_up, btn_down, btn_left, btn_right : in std_logic;
      tablero_salida : out t_tablero
    ); end component;
    
   component controlador_grafico is
     Port(
      x, y : in std_logic_vector(9 downto 0);
      tablero : in t_tablero;
      color : out std_logic_vector(2 downto 0)
    ); end component;
    
    component vga is
      Port (
        clk : in std_logic;
        reset : in std_logic;
        color : in std_logic_vector(2 downto 0);
        
        hsync, vsync : out std_logic;
        R, G, B : out std_logic;
        x, y : out std_logic_vector(9 downto 0)
      ); end component;
      
      component detector_flanco is
       Port (
        clk, reset, s : in std_logic;
        sout : out std_logic
      ); end component;
      
      signal color : std_logic_vector(2 downto 0);
      signal x, y : std_logic_vector(9 downto 0);
      
      signal tablero : t_tablero;
      signal tablero_2 : t_tablero := ((0,1,2,3),(4,5,6,7),(8,9,10,11),(0,1,2,3));
      
      signal  sup, sdown, sleft, sright, sclk :  std_logic;
  
begin
  clk1 : clk_wiz_0
  port map (
    clk_in1 => clk,
    reset => reset,
    clk_out1 => sclk
  );
  vga0 : vga
  port map(
    clk => sclk,
    reset => reset,
    color => color,
    --color => "111",
    hsync => hsync,
    vsync => vsync,
    R => R,
    G => G,
    B => B,
    x => x,
    y => y
  );
  contr_grafico : controlador_grafico
  port map(
     x => x,
     y => y,
     --tablero => tablero_2,
     tablero => tablero,
     color => color
  );
  
  fsm0 : fsm
  port map(
    clk => sclk,
    reset => reset,
    btn_up => sup,
    btn_down => sdown,
    btn_right => sright,
    btn_left => sleft,
    tablero_salida => tablero
  );
  
  arriba : detector_flanco
  port map(
       clk => sclk,
    reset => reset,
    s => up,
    sout => sup
  );
  
    abajo : detector_flanco
  port map(
       clk => sclk,
    reset => reset,
    s => down,
    sout => sdown
  );
  
    deercha : detector_flanco
  port map(
       clk => sclk,
    reset => reset,
    s => right,
    sout => sright
  );
  
    izq : detector_flanco
  port map(
       clk => sclk,
    reset => reset,
    s => left,
    sout => sleft
  );

end Behavioral;
