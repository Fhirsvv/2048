library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package game_library is
    type t_columna is array (0 to 3) of integer range 0 to 11;
    type t_tablero is array (0 to 3) of t_columna;
    
    type t_img is array (0 to 15) of std_logic_vector(15 downto 0);
    type t_img_32 is array(0 to 31) of std_logic_vector(31 downto 0);
    
    constant nulo  : std_logic_vector(3 downto 0) := "0000";
    constant up    : std_logic_vector(3 downto 0) := "1000";
    constant down  : std_logic_vector(3 downto 0) := "0100";
    constant left  : std_logic_vector(3 downto 0) := "0010";
    constant right : std_logic_vector(3 downto 0) := "0001";
    
    constant cero : t_img := (
    "1111111111111111",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1000000000000001",
"1111111111111111");
    constant dos : t_img := (
"1111111111111111",
"1000000000000001",
"1000111111110001",
"1000000000010001",
"1000000000010001",
"1000000000010001",
"1000000000010001",
"1000111111110001",
"1000100000000001",
"1000100000000001",
"1000100000000001",
"1000100000000001",
"1000111111110001",
"1000000000000001",
"1000000000000001",
"1111111111111111");

    constant cuatro : t_img := (
"1111111111111111",
"1000000000000001",
"1000000000000001",
"1000010001000001",
"1000010001000001",
"1000010001000001",
"1000010001000001",
"1000011111000001",
"1000000001000001",
"1000000001000001",
"1000000001000001",
"1000000001000001",
"1000000001000001",
"1000000001000001",
"1000000000000001",
"1111111111111111");


    constant ocho : t_img := (
"1111111111111111",
"1000000000000001",
"1000011111100001",
"1000010000100001",
"1000010000100001",
"1000010000100001",
"1000010000100001",
"1000011111100001",
"1000011111100001",
"1000010000100001",
"1000010000100001",
"1000010000100001",
"1000010000100001",
"1000011111100001",
"1000000000000001",
"1111111111111111");


   constant uno_seis : t_img := (
"1111111111111111",
"1000000000000001",
"1000000000000001",
"1000100111110001",
"1000100100000001",
"1000100100000001",
"1000100100000001",
"1000100100000001",
"1000100111110001",
"1000100100010001",
"1000100100010001",
"1000100100010001",
"1000100111110001",
"1000000000000001",
"1000000000000001",
"1111111111111111");


   constant tres_dos : t_img := (
"1111111111111111",
"1000000000000001",
"1000000000000001",
"1011111001111101",
"1000001000000101",
"1000001000000101",
"1000001000000101",
"1001111001111101",
"1000001001000001",
"1000001001000001",
"1000001001000001",
"1000001001000001",
"1011111001111101",
"1000000000000001",
"1000000000000001",
"1111111111111111");


   constant seis_cuatro : t_img := (
"1111111111111111",
"1000000000000001",
"1000000000000001",
"1011111001000101",
"1010000001000101",
"1010000001000101",
"1010000001000101",
"1011111001111101",
"1010001000000101",
"1010001000000101",
"1010001000000101",
"1010001000000101",
"1011111000000101",
"1000000000000001",
"1000000000000001",
"1111111111111111");


  constant uno_dos_ocho : t_img_32 := (
"11111111111111111111111111111111",
"11111111111111111111111111111111",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000100111111100001111110000011",
"11000100000000110010000001000011",
"11000100000000010010000001000011",
"11000100000000010010000001000011",
"11000100000000010010000001000011",
"11000100000000010010000001000011",
"11000100000000010010000001000011",
"11000100000000010010000001000011",
"11000100000000110010000001000011",
"11000100011111100001111110000011",
"11000100110000000010000001000011",
"11000100100000000010000001000011",
"11000100100000000010000001000011",
"11000100100000000010000001000011",
"11000100100000000010000001000011",
"11000100100000000010000001000011",
"11000100100000000010000001000011",
"11000100110000000000000000000011",
"11000100011111110000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11111111111111111111111111111111",
"11111111111111111111111111111111");
  
  constant dos_cinco_seis : t_img_32 := (
"11111111111111111111111111111111",
"11111111111111111111111111111111",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11011111111001111111001111111011",
"11000000001011000000011000000011",
"11000000001010000000010000000011",
"11000000001010000000010000000011",
"11000000001010000000010000000011",
"11000000001010000000010000000011",
"11000000001010000000010000000011",
"11000000001011000000010000000011",
"11001111111001111110011111110011",
"11011000000000000011011000011011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11010000000000000001010000001011",
"11011000000000000011011000011011",
"11001111111011111110001111110011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11000000000000000000000000000011",
"11111111111111111111111111111111",
"11111111111111111111111111111111");


--    constant cinco_uno_dos : t_img;
--    constant mil_dos_cuatro : t_img;
--    constant dos_mil_cuatro_ocho : t_img;

    
      procedure mover_izquierda(variable t : inout t_tablero ;signal puntuacion : inout integer);
      procedure mover_derecha(variable t : inout t_tablero ;signal puntuacion : inout integer);
      procedure mover_arriba(variable t : inout t_tablero ;signal puntuacion : inout integer);
      procedure mover_abajo(variable t : inout t_tablero ;signal puntuacion : inout integer);
      
      procedure insertar_ficha_simple(variable t : inout t_tablero);
      
end package game_library;



package body game_library is
  
procedure mover_izquierda(variable t : inout t_tablero; signal puntuacion : inout integer) is
  variable fila_tmp : t_columna;
  variable fila_res : t_columna;
  variable pos, i   : integer;
begin
  for r in 0 to 3 loop
    fila_tmp := (others => 0);
    pos := 0;
    for c in 0 to 3 loop
      if t(r)(c) /= 0 then
        fila_tmp(pos) := t(r)(c);
        pos := pos + 1;
      end if;
    end loop;

    for c in 0 to 2 loop
      if fila_tmp(c) /= 0 and fila_tmp(c) = fila_tmp(c+1) then
        puntuacion <= puntuacion + 2 * fila_tmp(c);
        fila_tmp(c)   := fila_tmp(c) + 1;
        fila_tmp(c+1) := 0;
      end if;
    end loop;

    fila_res := (others => 0);
    pos := 0;
    for c in 0 to 3 loop
      if fila_tmp(c) /= 0 then
        fila_res(pos) := fila_tmp(c);
        pos := pos + 1;
      end if;
    end loop;

    for c in 0 to 3 loop
      t(r)(c) := fila_res(c);
    end loop;
  end loop;
end procedure;

  
procedure mover_derecha(
    variable t : inout t_tablero ; signal puntuacion : inout integer
) is
    variable fila_tmp : t_columna;
    variable pos, i   : integer;
begin

    for r in 0 to 3 loop
        fila_tmp := (others => 0);
        pos := 3;
        for c in 3 downto 0 loop
            if t(r)(c) /= 0 then
                fila_tmp(pos) := t(r)(c);
                pos := pos - 1;
            end if;
        end loop;

    for i in 3 downto 1 loop
     if fila_tmp(i) /= 0 and fila_tmp(i) = fila_tmp(i-1) then
         puntuacion <= puntuacion + 2 * fila_tmp(i);
        fila_tmp(i)   := fila_tmp(i) + 1; 
        fila_tmp(i-1) := 0;
        end if;
    end loop;


        pos := 3;
        for c in 3 downto 0 loop
            if fila_tmp(c) /= 0 then
                t(r)(pos) := fila_tmp(c);
                pos := pos - 1;
            end if;
        end loop;
        for c in 0 to 3 loop
            if c <= pos then
                t(r)(c) := 0;
            end if;
        end loop;

    end loop;
end procedure;


procedure mover_arriba(
  variable t : inout t_tablero; signal puntuacion : inout integer
) is
  variable col_tmp : t_columna;
  variable pos, i  : integer;
begin
  for c in 0 to 3 loop
    col_tmp := (others => 0);
    pos := 0;
    for r in 0 to 3 loop
      if t(r)(c) /= 0 then
        col_tmp(pos) := t(r)(c);
        pos := pos + 1;
      end if;
    end loop;

    for i in 0 to 2 loop
      if col_tmp(i) /= 0 and col_tmp(i) = col_tmp(i+1) then
         puntuacion <= puntuacion + 2 * col_tmp(i);
        col_tmp(i)   := col_tmp(i) + 1; 
        col_tmp(i+1) := 0;
      end if;
    end loop;

    pos := 0;
    for r in 0 to 3 loop
      if col_tmp(r) /= 0 then
        t(pos)(c) := col_tmp(r);
        pos := pos + 1;
      end if;
    end loop;

    for r in 0 to 3 loop
      if r >= pos then
        t(r)(c) := 0;
      end if;
    end loop;
  end loop;
end procedure;


procedure mover_abajo(
  variable t : inout t_tablero ; signal puntuacion : inout integer
) is
  variable col_tmp : t_columna;
  variable pos, i  : integer;
begin
  for c in 0 to 3 loop
    col_tmp := (others => 0);
    pos := 3; 
    for r in 3 downto 0 loop
      if t(r)(c) /= 0 then
        col_tmp(pos) := t(r)(c);
        pos := pos - 1;
      end if;
    end loop;

   
    for i in 3 downto 1 loop
      if col_tmp(i) /= 0 and col_tmp(i) = col_tmp(i-1) then
         puntuacion <= puntuacion + 2 * col_tmp(c);
        col_tmp(i)   := col_tmp(i) + 1; 
        col_tmp(i-1) := 0;
      end if;
    end loop;

    pos := 3;
    for r in 3 downto 0 loop
      if col_tmp(r) /= 0 then
        t(pos)(c) := col_tmp(r);
        pos := pos - 1;
      end if;
    end loop;

    for r in 0 to 3 loop
      if r <= pos then
        t(r)(c) := 0;
      end if;
    end loop;

  end loop;
end procedure;

procedure insertar_ficha_simple(
  variable t : inout t_tablero
) is
variable x : boolean := true;
begin
x := true;
  for r in 0 to 3 loop
    for c in 0 to 3 loop
      if (t(r)(c) = 0) and x then
        t(r)(c) := 1;
        x := false;
      end if;
    end loop;
  end loop;
end procedure;



end package body game_library;
