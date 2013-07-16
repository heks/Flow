library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyboard_interface is
	Port(Clk,NewKey,Data_Ready_In : in std_logic;
		Data_Ready,NewKeyACK,LD_DATA : out std_logic
		);
end keyboard_interface;

architecture Behavioral of keyboard_interface is
begin
		operate_reg: process(Clk, Data_Ready_In, NewKey)
		begin
		Data_Ready <= '0';
		if(rising_edge(Clk) AND Data_Ready_In = '0' AND NewKey='1' ) then				
			Data_Ready <= '1';
			NewKeyACK <= '0';
			LD_DATA <= '1';
		end if;
		
		end process;
end Behavioral;