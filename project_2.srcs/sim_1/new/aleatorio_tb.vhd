----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.10.2025 10:59:33
-- Design Name: 
-- Module Name: aleatorio_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;

entity aleatorio_tb is
--  Port ( );
end aleatorio_tb;

architecture Behavioral of aleatorio_tb is
    component aleatorio is
     Port (
      clk : in std_logic;
      reset : in std_logic;
      enable : in std_logic;
      in_tablero : in t_tablero;
      end_aleatorio : out std_logic;
      out_tablero : out t_tablero
      ); end component;
      
      constant CLK_PERIOD : time := 10 ns;
       signal clk_s, reset_s : std_logic := '0';
        signal tablero : t_tablero := ((2,2,4,0),(0,2,4,2),(1,0,1,1),(2,2,0,0));
       --signal tablero : t_tablero := (others =>(others => 0));
       signal enable : std_logic := '0';
       signal out_tablero : t_tablero;
       signal fin : std_logic;
begin
    dut : aleatorio
    port map(
        clk => clk_s,
        reset => reset_s,
        enable => enable,
        in_tablero => tablero,
        out_tablero => out_tablero,
        end_aleatorio => fin
    );
    
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
    
    process
    begin
        reset_s <= '1';
        wait for CLK_period;
        reset_s <= '0';
        wait for clk_period;
        
        wait for 38 * clk_period;
        enable <= '1';
        wait for clk_period;
        enable <= '0';
        
        wait for 5 * clk_period;
        enable <= '1';
        wait for clk_period;
        enable <= '0';
        wait;
    end process;

end Behavioral;
