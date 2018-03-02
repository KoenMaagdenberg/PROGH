----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2018 13:35:01
-- Design Name: 
-- Module Name: sprite - Behavioral
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

entity square is
    Port ( vgahcount, vgavcount : in integer; --STD_LOGIC_VECTOR(9 downto 0);
           altRed, altGreen, altBlue : in STD_LOGIC_VECTOR(3 downto 0);
           squareLocH, squareLocV : in integer; --in STD_LOGIC_VECTOR(9 downto 0);
           squaresize : in integer;
           squareRed : out STD_LOGIC_VECTOR(3 downto 0);
           squareGreen : out STD_LOGIC_VECTOR(3 downto 0);
           squareBlue : out STD_LOGIC_VECTOR(3 downto 0));  
end square;

architecture Behavioral of square is

begin


squareRed <= "1111" when (vgahcount >= squareLocH) and (vgahcount < (squareLocH + squaresize)) and (vgavcount >= squareLocV) and (vgavcount < (squareLocV + squaresize)) else altRed;
squareGreen <= "0000"when (vgahcount >= squareLocH) and (vgahcount < (squareLocH + squaresize)) and (vgavcount >= squareLocV) and (vgavcount < (squareLocV + squaresize)) else altGreen;
squareBlue <= "0000"when (vgahcount >= squareLocH) and (vgahcount < (squareLocH + squaresize)) and (vgavcount >= squareLocV) and (vgavcount < (squareLocV + squaresize)) else altBlue;


end Behavioral;
