----------------------------------------------------------------------------------
-- Company:        Avans 
-- Engineer:       J.vd.Heuvel
-- 
-- Create Date:    14:13:20 04/11/2009 
-- Module Name:    VGA - Behavioral 
-- Target Devices: Xilinx Artix 7
-- Description: 
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

entity VGA is
    Port ( 	clk25 : in STD_LOGIC;
            inR, inG, inB : in STD_LOGIC_VECTOR(3 downto 0);
			prefRed, prefGreen, prefBlue : out  STD_LOGIC_VECTOR(3 downto 0);
			hsync, vsync : out  STD_LOGIC;
			hloc, vloc : out integer; --STD_LOGIC_VECTOR(9 downto 0);
			refreshCLK : out STD_LOGIC;
			outR, outG, outB : out STD_LOGIC_VECTOR(3 downto 0));
end VGA;

architecture Behavioral of VGA is
  signal hcount: integer; --STD_LOGIC_VECTOR(9 downto 0);
  signal vcount: integer; --STD_LOGIC_VECTOR(9 downto 0);
  signal trynottousehcount : STD_LOGIC_VECTOR(9 downto 0);
  signal trynottousevcount : STD_LOGIC_VECTOR(9 downto 0);
  signal refresh: STD_LOGIC := '0';
  
  
begin

trynottousehcount <= std_logic_vector(to_unsigned(hcount, 10));     -- nobody likes you STD_LOGIC_VECTOR, go home.
trynottousevcount <= std_logic_vector(to_unsigned(vcount, 10));     -- nobody likes you STD_LOGIC_VECTOR, go home.

hloc <= hcount;
vloc <= vcount;
refreshCLK <= refresh;

outR <= inR;
outG <= inG;
outB <= inB;


process (clk25) 
begin
    if rising_edge(clk25) then
       
	   if (hcount >= 144) and (hcount < 784) and (vcount >= 31) and (vcount < 511) then
        prefRed <= "1111";
        prefGreen <= "1111";
        prefBlue <= trynottousehcount(5) & trynottousehcount(5) & trynottousehcount(5) & trynottousehcount(5);         --hcount(5) & hcount(5) & hcount(5) & hcount(5);
      else
        prefRed <= "0000";
        prefGreen <= "0000";
        prefBlue <= "0000";
      end if;
      
	 
      if hcount < 97 then
        hsync <= '0';
      else
        hsync <= '1';
      end if;

      if vcount < 3 then
        vsync <= '0';
      else
        vsync <= '1';
      end if;
	 
      hcount <= hcount + 1;
	 
      if hcount = 800 then
        vcount <= vcount + 1;
        hcount <= 0; --(others => '0');      
      end if;
	 
      if vcount = 521 then		    
        vcount <= 0; --(others => '0');
        refresh <= '1';
      else
        refresh <= '0';
      end if;
            
	 end if;
	 
	 -- hcount <= hcount;
	 -- vcount <= vcount;
end process;

end Behavioral;

