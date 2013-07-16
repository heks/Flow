library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.custom_flow.all;


entity coordinate_controller is
    Port( w,a,s,d,enter           : in std_logic;
		PosX : out std_logic_vector(9 downto 0);
        PosY : out std_logic_vector(9 downto 0)
          );
end coordinate_controller;

architecture Behavioral of coordinate_controller is
	
signal PosX_sig : std_logic_vector(9 downto 0) := X_Min;
signal PosY_sig : std_logic_vector(9 downto 0) := Y_Min;
signal Y_Motion : std_logic_vector(9 downto 0) := "0000000000";
signal X_Motion : std_logic_vector(9 downto 0) := "0000000000";

begin
assign_motion : process(w,a,s,d,PosY_sig,PosX_sig)
begin
    Y_Motion <= "0000000000";
	X_Motion <= "0000000000";
	if(w = '1') then
		PosY_sig <= Y_Min + Step;
		Y_Motion <= -1*Step;
	elsif(a = '1') then
		PosX_sig <= X_Min;
		X_Motion <= -1*Step;
	elsif(s = '1') then
		PosY_sig <= Y_Min+Step;
		Y_Motion <= Step;
	elsif(d = '1') then
		PosX_sig <= X_Min+Step;
		X_Motion <= Step;
	end if;
	
--	if( PosX_sig + X_Motion >= X_Min and PosX_sig + X_Motion <= X_Max) then
--		PosX_sig <= X_Min+Step+X_Motion; -- save previous position
--	else
--		PosX_sig <= X_Min+X_Motion+Step+Step;
--	end if;
		
--	if( PosY_sig + Y_Motion >= Y_Min and PosY_sig + Y_Motion <= Y_Max ) then
--		PosY_sig <= Y_Min+Step+Y_Motion; -- save previous position
--	else
--		PosY_sig <= Y_Min+Y_Motion+Step+Step;
--	end if;
end process;

PosX <= PosX_sig;
PosY <= PosY_sig;

end Behavioral;