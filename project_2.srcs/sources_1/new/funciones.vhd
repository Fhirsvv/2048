library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.game_library.all;

Package funciones is
type IntArray is array(3 downto 0) of integer;
function move(TabIn:t_tablero;Dir:std_logic_vector(1 downto 0)) return t_tablero;
function join(TabIn:t_tablero;Dir:std_logic_vector(1 downto 0))return t_tablero;

function moveEdu (tablero : t_tablero ; dir : std_logic_vector(3 downto 0)) return t_tablero;
end package;

Package Body funciones is

function join(TabIn:t_tablero;Dir:std_logic_vector(1 downto 0)) return t_tablero is
    variable Tab:t_tablero:=TabIn;
begin
    case Dir is
        when "00"=>--DERECHA
            for i in 0 to 3 loop
                for j in 1 to 3 loop
                    if Tab(i)(j) = Tab(i)(j-1) then
                        if Tab(i)(j)/=0 then
                            Tab(i)(j-1) := Tab(i)(j)+1; 
                            Tab(i)(j):=0; 
                        end if;                      
                    end if;
                end loop;
            end loop;
       when "01"=>--IZQUIERDA
            for i in 0 to 3 loop
                for j in 2 downto 0 loop
                    if Tab(i)(j) = Tab(i)(j+1) then
                        if Tab(i)(j)/=0 then
                            Tab(i)(j+1) := Tab(i)(j)+1; 
                            Tab(i)(j):=0; 
                        end if;                      
                    end if;
                end loop;
            end loop;
       when "10"=>--ABAJO
            for i in 0 to 3 loop
                for j in 1 to 3 loop
                    if Tab(j)(i) = Tab(j-1)(i) then
                        if Tab(j)(i)/=0 then
                            Tab(j-1)(i) := Tab(j)(i)+1; 
                            Tab(j)(i):=0;   
                        end if;                    
                    end if;
                end loop;
            end loop;
       when others=>--ARRIBA
            for i in 0 to 3 loop
                for j in 2 downto 0 loop
                    if Tab(j)(i) = Tab(j+1)(i) then
                        if Tab(j)(i)/=0 then
                            Tab(j+1)(i) := Tab(j)(i)+1; 
                            Tab(j)(i):=0; 
                        end if;                      
                    end if;
                end loop;
            end loop;
    end case;
    return Tab;
end function join;

function move
    (
    TabIn:t_tablero;
    Dir:std_logic_vector(1 downto 0)) 
    return t_tablero is
    variable Tab:t_tablero:=(others=>(others=>0));
    variable idx1:IntArray:=(0,0,0,0);
    variable idx2:IntArray:=(3,3,3,3);
begin
    case Dir is
        when "00"=>--DERECHA
            for i in 0 to 3 loop
                for j in 0 to 3 loop
                    if TabIn(i)(j) /= 0 then
                        Tab(i)(idx1(i)) := TabIn(i)(j);
                        idx1(i) := idx1(i) + 1;
                    end if;
                end loop;
            end loop;
       when "01"=>--IZQUIERDA
            for i in 0 to 3 loop
                for j in 3 downto 0 loop
                    if TabIn(i)(j) /= 0 then
                        Tab(i)(idx2(i)) := TabIn(i)(j);
                        idx2(i) := idx2(i) - 1;
                    end if;
                end loop;
            end loop;
       when "10"=>--ABAJO
            for i in 0 to 3 loop
                for j in 0 to 3 loop
                    if TabIn(j)(i) /= 0 then
                        Tab(idx1(i))(i) := TabIn(j)(i);
                        idx1(i) := idx1(i) + 1;
                    end if;
                end loop;
            end loop;
       when others=>--ARRIBA
            for i in 0 to 3 loop
                for j in 3 downto 0 loop
                    if TabIn(j)(i) /= 0 then
                        Tab(idx2(i))(i) := TabIn(j)(i);
                        idx2(i) := idx2(i) - 1;
                    end if;
                end loop;
            end loop;
    end case;
    return Tab;
end function move;

function moveEdu (tablero : t_tablero ; dir : std_logic_vector(3 downto 0)) return t_tablero is
  variable aux : t_tablero := (others => (others => 0));
  variable tab_aux : t_tablero := (others => (others => 0));
begin
  case dir is
    when right =>
      tab_aux := tablero;
      for i in 0 to 3 loop
        for j in 0 to 3 loop
          if tab_aux(i)(j) /= 0 then
            aux(i)(j) := tab_aux(i)(j);
          end if;
        end loop;
      end loop;
    when others =>
        aux := tablero;
  end case;
  return aux;
end function moveEdu;

end package body;
