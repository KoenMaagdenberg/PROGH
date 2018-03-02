----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2018 11:50:01
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR(3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR(3 downto 0);
           Vsync : out STD_LOGIC;
           Hsync : out STD_LOGIC);
end top;

architecture Behavioral of top is

component clockDivider is
 Port ( clk_out1 : out STD_LOGIC;
        clk_in1 : in STD_LOGIC
        );
end component clockDivider;
 
component VGA is
 Port ( 	clk25 : in STD_LOGIC;
            inR, inG, inB : in STD_LOGIC_VECTOR(3 downto 0);
			prefRed, prefGreen, prefBlue : out  STD_LOGIC_VECTOR(3 downto 0);
			hsync, vsync : out  STD_LOGIC;
			hloc, vloc : out integer; --STD_LOGIC_VECTOR(9 downto 0);
			refreshCLK : out STD_LOGIC;
			outR, outG, outB : out STD_LOGIC_VECTOR(3 downto 0));
end component VGA;

component square is
Port ( vgahcount, vgavcount : in integer; --STD_LOGIC_VECTOR(9 downto 0);
       altRed, altGreen, altBlue : in STD_LOGIC_VECTOR(3 downto 0);
       squareLocH, squareLocV : in integer; --in STD_LOGIC_VECTOR(9 downto 0);
       squaresize : in integer;
       squareRed : out STD_LOGIC_VECTOR(3 downto 0);
       squareGreen : out STD_LOGIC_VECTOR(3 downto 0);
       squareBlue : out STD_LOGIC_VECTOR(3 downto 0)); 
end component square;

signal divided25clock : STD_LOGIC;
signal backRed, backGreen, backBlue : STD_LOGIC_VECTOR(3 downto 0);
signal hlocation, vlocation : integer; --STD_LOGIC_VECTOR(9 downto 0);
signal inthlocation, intvlocation : integer;
signal refresh : STD_LOGIC;

signal sq1hloc, sq1vloc : integer := 200;
signal sq1hdir, sq1vdir : boolean := true;
signal sq1size : integer := 10;
signal sprite1R, sprite1G, sprite1B : STD_LOGIC_VECTOR(3 downto 0);

signal sq2hloc, sq2vloc : integer := 300;
signal sq2hdir, sq2vdir : boolean := false;
signal sq2size : integer := 30;
signal sprite2R, sprite2G, sprite2B : STD_LOGIC_VECTOR(3 downto 0);


begin



-- inthlocation <= conv_integer(unsigned(hlocation));      -- werkt niet. conv_integer ook niet. signed ook niet. lengte aangeven ook niet. := werkt niet. shared variable werkt niet.


clkdiv: clockDivider port map (divided25clock, clk);
VGAscreen: VGA port map (divided25clock, sprite1R, sprite1G, sprite1B, backRed, backGreen, backBlue, Hsync, Vsync, hlocation, vlocation, refresh, vgaRed, vgaGreen, vgaBlue);
square1sprite: square port map (hlocation, vlocation, sprite2R, sprite2G, sprite2B, sq1hloc, sq1vloc, sq1size, sprite1R, sprite1G, sprite1B);
square2sprite: square port map (hlocation, vlocation, backRed, backGreen, backBlue, sq2hloc, sq2vloc, sq2size, sprite2R, sprite2G, sprite2B);


--sqhdir <= true when (sqhloc <= hl) else                  --  144
--          false when (sqhloc >= (hh - sqsize)) else      --  784
--          sqhdir;
          
--sqvdir <= true when (sqvloc <= vl) else                   -- 31
--          false when (sqvloc >= (vh - sqsize)) else      -- 511
--          sqvdir;

process (divided25clock, refresh) -- , sqhdir, sqvdir, sqhloc, sqvloc)  -- ik geef toe: dit had best een eigen file mogen zijn.
begin

    if ((rising_edge(divided25clock)) and (refresh = '1')) then
        if (sq1hloc <= 144) then
            sq1hdir <= true;
        elsif (sq1hloc >= (784 - sq1size)) then
            sq1hdir <= false;
        end if;
        if (sq1vloc <= 31) then
            sq1vdir <= true;
        elsif (sq1vloc >= (511 - sq1size)) then
            sq1vdir <= false;
        end if;
        if (sq1hdir = true) then
            sq1hloc <= (sq1hloc + 2);
        else
            sq1hloc <= (sq1hloc - 2);
        end if;
        if (sq1vdir = true) then
            sq1vloc <= (sq1vloc + 3);
        else
            sq1vloc <= (sq1vloc - 3);
        end if;
        
        
        
        if (sq2hloc <= 144) then
            sq2hdir <= true;
        elsif (sq2hloc >= (784 - sq2size)) then
            sq2hdir <= false;
        end if;
        if (sq2vloc <= 31) then
            sq2vdir <= true;
        elsif (sq2vloc >= (511 - sq2size)) then
            sq2vdir <= false;
        end if;
        if (sq2hdir = true) then
            sq2hloc <= (sq2hloc + 1);
        else
            sq2hloc <= (sq2hloc - 1);
        end if;
        if (sq2vdir = true) then
            sq2vloc <= (sq2vloc + 1);
        else
            sq2vloc <= (sq2vloc - 1);
        end if;
        -- sqvloc <= sqvloc;
        -- sqhloc <= sqhloc;
                                 
    end if;
end process;  
     
end Behavioral;
