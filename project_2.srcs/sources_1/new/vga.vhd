----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2025 18:04:33
-- Design Name: 
-- Module Name: vga - Behavioral
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

entity vga is
  Port (
    clk : in std_logic;
    reset : in std_logic;
    color : in std_logic_vector(2 downto 0);
    
    hsync, vsync : out std_logic;
    R, G, B : out std_logic;
    x, y : out std_logic_vector(9 downto 0)
  );
end vga;

architecture Behavioral of vga is
--pdf 2007
--AH 25,60 us 640 AV 15,360 ms 480
--BH 26,16 us 654 BV 15,680 ms 490
--CH 30,08 us 752 CV 15,744 ms 492
--DH 32,00 us 800 DV 16,672 ms 521
  constant AH : integer := 640-1;
  constant BH : integer := 654-1;
  constant CH : integer := 752-1;
  constant DH : integer := 800-1;
  
  constant AV : integer := 480-1;
  constant BV : integer := 490-1;
  constant CV : integer := 492-1;
  constant DV : integer := 521-1;

-- clk divisor for 25MHz
  signal sclk : std_logic := '0';
  signal count_divisor : std_logic;

-- counters
  signal countx : integer range 0 to DH;
  signal endcx : std_logic;
  signal county : integer range 0 to DV;
  signal endcy : std_logic;
  
begin

--sclk <= count_divisor(1);
  clk_divisor : process(clk, reset)
  begin
    if reset = '1' then
      count_divisor <= '0';
    elsif rising_edge(clk) then
        if count_divisor = '1' then
            count_divisor <= '0';
            sclk <= '1';
        else
            count_divisor <= '1';
            sclk <= '0';
        end if;
    end if;
  end process;
  
  contadorX : process(clk, reset)
  begin
    if reset = '1' then
      countx <= 0;
    elsif rising_edge(clk) then
     if sclk = '1' then
      if countx = DH then
        countx <= 0;
      else
        countx <= countx + 1;
      end if;
    end if;
    end if;
  end process;
  endcx <= '1' when countx = DH else '0';
  
  contadorY : process(clk, reset)
  begin
    if reset = '1' then
      county <= 0;
    elsif rising_edge(clk) then
    if sclk = '1' then
     if endcx = '1' then
      if county = DV then
        county <= 0;
      else
        county <= county + 1;
      end if;
     end if;
    end if;
    end if;
  end process;
  
  endcy <= '1' when county = DV else '0';

  hsync <= '0' when countx >= BH and countx <= CH else '1';
  vsync <= '0' when county >= BV and county <= CV else '1';
  x <= std_logic_vector(TO_UNSIGNED(countx, 10));
  y <= std_logic_vector(TO_UNSIGNED(county, 10));
  
  blanq : process(countx, county, color)
  begin
    if countx > AH or county > AV then
      R <= '0';
      G <= '0';
      B <= '0';
    else
      R <= color(2);
      G <= color(1);
      B <= color(0);
    end if;
  end process;


end Behavioral;
