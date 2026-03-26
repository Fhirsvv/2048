library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;

entity logic is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    up, down, left, right : in std_logic;
    board : out t_tablero
  );
end logic;

architecture Behavioral of logic is

    component core is
        port(
        clk, reset : in std_logic;
        btn_up, btn_down, btn_left, btn_right : in std_logic;
        end_merge1, end_compact, end_merge2, end_aleatorio : in std_logic;

        enable_merge1, enable_compact, enable_merge2, enable_aleatorio : out std_logic;
        movimientos : out std_logic_vector(3 downto 0)
     ); end component;
     
    component merge is
      Port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        in_tablero : in t_tablero;
        movimiento : in std_logic_vector(3 downto 0);
        
        out_tablero : out t_tablero;
        fin : out std_logic
      );end component;
  
    component compact is
      Port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        in_tablero : in t_tablero;
        movimiento : in std_logic_vector(3 downto 0);
        
        out_tablero : out t_tablero;
        fin : out std_logic
      );end component;
      
      component aleatorio is
      Port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        in_tablero : in t_tablero;
        
        end_aleatorio : out std_logic;
        out_tablero : out t_tablero
      );end component;

    signal tablero : t_tablero := (others =>(others=> 0));
    signal movimientos : std_logic_vector(3 downto 0);
    
    signal tablero_merge1 : t_tablero := (others =>(others=> 0));  
    signal tablero_compact : t_tablero := (others =>(others=> 0));  
    signal tablero_merge2 : t_tablero := (others =>(others=> 0));
    signal out_tablero : t_tablero := (others =>(others=> 0));
    
    
    signal end_merge1, end_compact, end_merge2, end_aleatorio : std_logic := '0';
    signal enable_merge1, enable_compact, enable_merge2, enable_aleatorio : std_logic := '0';
begin
    
    fsm : core
    port map(
        --ins
        clk => clk,
        reset => reset,
        btn_up => up,
        btn_down => down,
        btn_left => left,
        btn_right => right,
        end_merge1 => end_merge1,
        end_compact => end_compact,
        end_merge2 => end_merge2,
        end_aleatorio => end_aleatorio,
        --outs
        movimientos => movimientos,
        enable_merge1 => enable_merge1,
        enable_compact => enable_compact,
        enable_merge2 => enable_merge2,
        enable_aleatorio => enable_aleatorio
    );
    
    merge1 : merge
    port map(
        --in
        clk => clk,
        reset => reset,
        enable => enable_merge1,
        in_tablero => tablero,
        movimiento => movimientos,
        --out
        out_tablero => tablero_merge1,
        fin => end_merge1
    );
    
    f_compact : compact
    port map(
        --in
        clk => clk,
        reset => reset,
        enable => enable_compact,
        in_tablero => tablero_merge1,
        movimiento => movimientos,
        --out
        out_tablero => tablero_compact,
        fin => end_compact
    );
    
    merge2 : merge
    port map(
        --in
        clk => clk,
        reset => reset,
        enable => enable_merge2,
        in_tablero => tablero_compact,
        movimiento => movimientos,
        --out
        out_tablero => tablero_merge2,
        fin => end_merge2
    );
    
    gen_numeros : aleatorio
    port map(
        --in
        clk => clk,
        reset => reset,
        enable => enable_aleatorio,
        in_tablero => tablero_merge2,
        --out
        end_aleatorio => end_aleatorio,
        out_tablero => tablero
    );
    
    board <= out_tablero;

end Behavioral;
