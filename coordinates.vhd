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
assign_motion : process(w,a,s,d,PosX_sig,PosY_sig,X_Motion,Y_Motion)
begin
    Y_Motion <= "0000000000";
	X_Motion <= "0000000000";
	
	if(w = '1') then
		Y_Motion <= not(Step)+1;
	elsif(a = '1') then
		X_Motion <= not(Step)+1;
	elsif(s = '1') then
		Y_Motion <= Step;
	elsif(d = '1') then
		X_Motion <= Step;
	end if;
	
	if( PosX_sig + X_Motion >= X_Min and PosX_sig + X_Motion <= X_Max) then
		PosX_sig <= PosX_sig + X_Motion; -- save previous position
	end if;
		
	if( PosY_sig + Y_Motion >= Y_Min and PosY_sig + Y_Motion <= Y_Max ) then
		PosY_sig <= PosY_sig + Y_Motion; -- save previous position
	end if;
end process;

PosX <= PosX_sig;
PosY <= PosY_sig;

end Behavioral;