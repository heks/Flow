library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity clk_div is				-- this entity takes in our system clock and divides it by 512
port( clk, reset		: in std_logic;
	  clkout	: out std_logic;
	  clkout_kb : out std_logic;
	  clkout_kb_driver : out std_logic;
	  clkout_vga : out std_logic
	  );
end clk_div;

architecture behavior of clk_div is
	  	signal frame_clk_div : std_logic_vector(22 downto 0);  


  begin
  process(clk, Reset)
  begin
    if (Reset = '1') then
      frame_clk_div <= "00000000000000000000000";
    elsif (rising_edge(clk)) then
      frame_clk_div <= frame_clk_div + '1';
    end if;
  end process;
  clkout <= frame_clk_div(14);
  clkout_kb <= frame_clk_div(22);
  clkout_kb_driver <= frame_clk_div(9); 
  clkout_vga <= frame_clk_div(0);
end behavior; 