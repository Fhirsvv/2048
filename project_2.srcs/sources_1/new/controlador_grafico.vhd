library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.game_library.all;

entity controlador_grafico is
  Port(
--    clk : in std_logic;
--    reset : in std_logic;
    x, y : in std_logic_vector(9 downto 0);
    tablero : in t_tablero;
   -- out_tablero : out t_tablero;
    color : out std_logic_vector(2 downto 0)
  );
end controlador_grafico;

architecture beh of controlador_grafico is
  
  constant bordeH1: integer := 2;
  constant bordeH2 : integer := 6;
  constant bordeV1 : integer := 1;
  constant bordeV2 : integer := 5;
  constant size_bloque : integer := 1;
  
  constant negro : std_logic_vector(2 downto 0) := "000";
  constant azul : std_logic_vector(2 downto 0) := "001";
  constant verde : std_logic_vector(2 downto 0) := "010";
  constant cyan : std_logic_vector(2 downto 0) := "011";
  constant rojo : std_logic_vector(2 downto 0) := "100";
  constant magenta : std_logic_vector(2 downto 0) := "101";
  constant amarillo : std_logic_vector(2 downto 0) := "110";
  constant blanco : std_logic_vector(2 downto 0) := "111";

  signal bloquex : integer range 0 to 19 := 0;
  signal bloquey : integer range 0 to 14 := 0;
  signal casillax : integer range 0 to 3 := 0;
  signal casillay : integer range 0 to 3 := 0;
  signal pos_bmpx : std_logic_vector(6 downto 0) := (others => '0');
  signal pos_bmpy : std_logic_vector(6 downto 0) := (others => '0');
  signal pos_bmpx_16, pos_bmpy_16 : std_logic_vector(4 downto 0) := (others => '0'); --esta como to y no downto
begin

  bloquex <= TO_INTEGER(unsigned(x(9 downto 6)));
  bloquey <= TO_INTEGER(unsigned(y(9 downto 6)));
  
  process(bloquex)
  begin
    if bloquex < 4 then
        casillax <= 0;
    elsif bloquex < 5 then
        casillax <= 1;
    elsif bloquex < 6 then
        casillax <= 2;
     elsif bloquex < 7 then
        casillax <= 3;
     else
        casillax <= 0;
    end if;
  end process;
  
  process(bloquey)
  begin
    if bloquey < 3 then
        casillay <= 0;
    elsif bloquey < 4 then
        casillay <= 1;
    elsif bloquey < 5 then
        casillay <= 2;
     elsif bloquey < 6 then
        casillay <= 3;
     else
        casillay <= 0;
    end if;
  end process;
  
  pos_bmpy_16 <= y(6 downto 2); --en 6 downto 0 numero al reves
  pos_bmpx_16 <= x(6 downto 2);
  
  process(bloquex, bloquey, tablero, casillay, casillax, pos_bmpy_16, pos_bmpx_16, pos_bmpy, pos_bmpx) --añadido tablero a lista sensibliidd
  begin
    if bloquex <= 2 or bloquex > 2 + 4  or bloquey <= 1 or bloquey > 1 + 4then
        color <= amarillo;
    else
        if tablero(casillay)(casillax) = 1 then
                if dos(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= azul;
                end if;
            elsif tablero(casillay)(casillax) = 2 then
                if cuatro(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= verde;
                end if;
            elsif tablero(casillay)(casillax) = 3 then
                if ocho(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= cyan;
                end if;
            elsif tablero(casillay)(casillax) = 4 then
               if uno_seis(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= rojo;
                end if;
            elsif tablero(casillay)(casillax) = 5 then
                if tres_dos(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= magenta;
                end if;
            elsif tablero(casillay)(casillax) = 6 then
                if seis_cuatro(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= blanco;
                end if;
            elsif tablero(casillay)(casillax) = 7 then
                 if uno_dos_ocho(TO_INTEGER(unsigned(pos_bmpy)))(TO_INTEGER(unsigned(pos_bmpx))) = '1' then
                     color <= negro;
                   else
                      color <= azul;
                    end if;
            elsif tablero(casillay)(casillax) = 8 then
                 if dos_cinco_seis(TO_INTEGER(unsigned(pos_bmpy)))(TO_INTEGER(unsigned(pos_bmpx))) = '1' then
                    color <= negro;
                 else
                   color <= verde;
                 end if;
            elsif tablero(casillay)(casillax) = 9 then
--                 if cinco_uno_seis(TO_INTEGER(unsigned(pos_bmpy)))(TO_INTEGER(unsigned(pos_bmpx))) = '1' then
--                  color <= negro;
--                else
                  color <= cyan;
--                end if;
            elsif tablero(casillay)(casillax) = 10 then
--                 if mil_dos_cuatro(TO_INTEGER(unsigned(pos_bmpy)))(TO_INTEGER(unsigned(pos_bmpx))) = '1' then
--                  color <= negro;
--                else
                  color <= rojo;
--                end if;
            elsif tablero(casillay)(casillax) = 11 then
--                 if dos_mil_cuatro_ocho(TO_INTEGER(unsigned(pos_bmpy)))(TO_INTEGER(unsigned(pos_bmpx))) = '1' then
--                  color <= negro;
--                else
                  color <= magenta;
--                end if;
            else
               if cero(TO_INTEGER(unsigned(pos_bmpy_16)))(15 - TO_INTEGER(unsigned(pos_bmpx_16))) = '1' then
                  color <= negro;
                else
                  color <= blanco;
                end if;
            end if;
    end if;
  end process;
end beh;