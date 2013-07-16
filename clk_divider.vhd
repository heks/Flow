library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.custom_flow.all;

entity clock_div is
   Port ( 
         Reset : in std_logic;
         clk : in std_logic;
         clk_div : out std_logic -- first set of blocks (recieved from the level)          
           ); 
end clock_div;

architecture Behavioral of clock_div is
signal frame_clk_div : std_logic_vector(8 downto 0) := "00000000";
begin 
  
   process(clk, Reset)
  begin
    if (Reset = '1') then
      frame_clk_div <= "00000000";
    elsif (rising_edge(clk)) then
      frame_clk_div <= frame_clk_div + '1';
    end if;
  end process;

  clk_div <= frame_clk_div(8);
end Behavioral;