library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_8 is
	Port(Shift_In, Load, Shift_En, Clk, Reset : in std_logic;
		D : in std_logic_vector(7 downto 0);
		Shift_Out : out std_logic;
		Data_Out : out std_logic_vector(7 downto 0) );
end reg_8;

architecture Behavioral of reg_8 is
signal reg_value: std_logic_vector(7 downto 0);
begin
		operate_reg: process(Load, Shift_En, Clk, Shift_In)
		begin
		
		if(rising_edge(Clk)) then				
			if(Reset ='1') then
				reg_value <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0'; --reset the regesters	
			elsif(Shift_En='1') then
				reg_value <= Shift_In & reg_value(7 downto 1);
			elsif(Load ='1') then
				reg_value <= D;
			else
				reg_value <= reg_value;
			end if;
		end if;
		end process;
	Data_Out <= reg_value;	
	Shift_Out <= reg_value(0);
end Behavioral;