library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Dreg is
	Port(
		D, Clk, reset: in std_logic; -- load connected to shift
		Q: out std_logic
	);
end Dreg;

architecture Behavioral of Dreg is
begin
	operate : process(reset, Clk, D)
	begin
		if reset = '1' then
			Q <= '0';
		elsif(rising_edge(clk)) then 
				Q <= D; -- Q is unchanged
		end if;
	end process;
end Behavioral;