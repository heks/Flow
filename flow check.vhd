
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity flow_check is
   Port (
        reset : in std_logic;
        inPosX : in std_logic_vector(9 downto 0);
        inPosY : in std_logic_vector(9 downto 0);
        --block coordinates to check dependent on level
		x_b0_0, y_b0_0, x_b1_0, y_b1_0, x_b2_0, y_b2_0, x_b3_0, y_b3_0, x_b4_0, y_b4_0, x_b5_0, y_b5_0, x_b6_0, y_b6_0, x_b7_0, y_b7_0, x_b8_0, y_b8_0, x_b9_0, y_b9_0, x_b10_0, y_b10_0, x_b11_0, y_b11_0 : in std_logic_vector(9 downto 0); --location of first block
        x_b0_1, y_b0_1, x_b1_1, y_b1_1, x_b2_1, y_b2_1, x_b3_1, y_b3_1, x_b4_1, y_b4_1, x_b5_1, y_b5_1, x_b6_1, y_b6_1, x_b7_1, y_b7_1, x_b8_1, y_b8_1, x_b9_1, y_b9_1, x_b10_1, y_b10_1, x_b11_1, y_b11_1 : in std_logic_vector(9 downto 0)
        flow_complete : out std_logic -- determines if a flow is connected
        level_complete : out std_logic -- determines if level is complete
        start_point : in std_logic; -- enter AND valid_input_check, load start block symbol
        end_point : in std_logic -- load end point block (determines if flows have been connected)
        );

end flow_check;

architecture Behavioral of flow_check is
begin
	signal block0_0, block0_ 1, block0_2, block0_3, block0_4, block0_5,block0_6, block0_7, block0_8, block0_9,  block0_10,  block0_11 : std_logic;
	signal block1_0, block1_ 1, block1_2, block1_3, block1_4, block1_5,block1_6, block1_7, block1_8, block1_9,  block1_10,  block1_11 : std_logic;
	signal flow_complete_signal : std_logic_vector(11 downto 0);
	operate: process(checkX, checkY, start_point, end_point)
	begin
	
	--save the previous input 
	level_complete <= '0';
	flow_complete_signal <= flow_complete_signal;
	block0_0 <= block0_0; block0_1 <= block0_1; block0_2 <= block0_2; block0_3 <= block0_3; block0_4 <= block0_4;
	block0_5 <= block0_5; block0_6 <= block0_6; block0_7 <= block0_7; block0_8 <= block0_8; block0_8 <= block0_8;
	block0_9 <= block0_9; block0_10 <= block0_10; block0_11 <= block0_11;
	
	block1_0 <= block1_0; block1_1 <= block1_1; block1_2 <= block1_2; block1_3 <= block1_3; block1_4 <= block1_4;
	block1_5 <= block1_5; block1_6 <= block1_6; block1_7 <= block1_7; block1_8 <= block1_8; block1_8 <= block1_8;
	block1_9 <= block1_9; block1_10 <= block1_10; block1_11 <= block1_11;
	 
	if(start_point = '1' | end_point = '1') then
		if((inPosX = x_b0_0 AND inPosY = y_b0_0))then
			block0_0 <= '1';
		elsif (inPosX = x_b1_0 AND inPosY = y_b1_0) then
			block0_1 <= '1';
		elsif (inPosX = x_b2_0 AND inPosY = y_b2_0) then
			block0_2 <= '1';
		elsif (inPosX = x_b3_0 AND inPosY = y_b3_0) then
			block0_3 <= '1';
		elsif (inPosX = x_b4_0 AND inPosY = y_b4_0) then
			block0_4 <= '1';
		elsif (inPosX = x_b5_0 AND inPosY = y_b5_0) then
			block0_5 <= '1';
		elsif (inPosX = x_b6_0 AND inPosY = y_b6_0) then
			block0_6 <= '1';
		elsif (inPosX = x_b7_0 AND inPosY = y_b7_0) then
			block0_7 <= '1';
		elsif (inPosX = x_b8_0 AND inPosY = y_b8_0) then
			block0_8 <= '1';
		elsif (inPosX = x_b9_0 AND inPosY = y_b9_0) then
			block0_9 <= '1';
		elsif (inPosX = x_b10_0 AND inPosY = y_b10_0) then
			block0_10 <= '1';
		elsif (inPosX = x_b11_0 AND inPosY = y_b11_0) then
			block0_11 <= '1';
		elsif (inPosX = x_b0_1 AND inPosY = y_b0_1) then
			block1_0 <= '1';
		elsif (inPosX = x_b1_1 AND inPosY = y_b1_1) then
			block1_1 <= '1';
		elsif (inPosX = x_b2_1 AND inPosY = y_b2_1) then
			block1_2 <= '1';
		elsif (inPosX = x_b3_1 AND inPosY = y_b3_1) then
			block1_3 <= '1';
		elsif (inPosX = x_b4_1 AND inPosY = y_b4_1) then
			block1_4 <= '1';
		elsif (inPosX = x_b5_1 AND inPosY = y_b5_1) then
			block1_5 <= '1';
		elsif (inPosX = x_b6_1 AND inPosY = y_b6_1) then
			block1_6 <= '1';
		elsif (inPosX = x_b7_1 AND inPosY = y_b7_1) then
			block1_7 <= '1';
		elsif (inPosX = x_b8_1 AND inPosY = y_b8_1) then
			block1_8 <= '1';
		elsif (inPosX = x_b9_1 AND inPosY = y_b9_1) then
			block1_9 <= '1';
		elsif (inPosX = x_b10_1 AND inPosY = y_b10_1) then
			block1_10 <= '1';
		elsif inPosX = x_b11_1 AND inPosY = y_b11_11)) then
			block1_11 <= '1';
		else
			NULL;
		end if;
	end if;
	end process;
	
	check_connection : process( block0_0, block0_1, block0_2, block0_3, block0_4, block0_5,block0_6, block0_7, block0_8, block0_9,  block0_10,  block0_11, block1_0, block1_ 1, block1_2, block1_3, block1_4, block1_5,block1_6, block1_7, block1_8, block1_9,  block1_10,  block1_11 )
	begin
		flow_complete_signal(11 downto 0) <= flow_complete_signal(11 downto 0);
		if(block0_0 = '1' AND block1_0 ='1') then
			flow_complete_signal(0) <= '1';
		elsif(block0_1 = '1' AND block1_1 ='1') then
			flow_complete_signal(1) <= '1';
		elsif(block0_2 = '1' AND block1_2 ='1') then
			flow_complete_signal(2) <= '1';
		elsif(block0_3 = '1' AND block1_3 ='1') then
			flow_complete_signal(3) <= '1';
		elsif(block0_4 = '1' AND block1_4 ='1') then
			flow_complete_signal(4) <= '1';
		elsif(block0_5 = '1' AND block1_5 ='1') then
			flow_complete_signal(5) <= '1';
		elsif(block0_6 = '1' AND block1_6 ='1') then
			flow_complete_signal(6) <= '1';
		elsif(block0_7 = '1' AND block1_7 ='1') then
			flow_complete_signal(7) <= '1';
		elsif(block0_8 = '1' AND block1_8 ='1') then
			flow_complete_signal(8) <= '1';
		elsif(block0_9 = '1' AND block1_9 ='1') then
			flow_complete_signal(9) <= '1';
		elsif(block0_10 = '1' AND block1_10 ='1') then
			flow_complete_signal(10) <= '1';
		elsif(block0_11 = '1' AND block1_11 ='1') then
			flow_complete_signal(11) <= '1';
		else
			NULL;
		end if;
	end process;
	
	end_of_level : process(flow_complete_signal(11 downto 0))
	begin
		if(flow_complete_signal(11 downto 0) = "111111111111") then
			level_complete <= '1';
		else
			level_complete <= '0';
		end if;
	end process;
	
	reset : process( reset, level_complete )
	begin
		-- restart all the signals
		if(reset ='1' | level_complete = '1' ) then
			level_complete <= '0';
			flow_complete_signal(11 downto 0) = "000000000000";
		
			block0_0 <= '0'; block0_1 <= '0'; block0_2 <= '0'; block0_3 <= '0'; block0_4 <= '0';
			block0_5 <= '0'; block0_6 <= '0'; block0_7 <= '0'; block0_8 <= '0'; block0_8 <= '0';
			block0_9 <= '0'; block0_10 <= '0'; block0_11 <= '0';
		
			block1_0 <= '0'; block1_1 <= '0'; block1_2 <= '0'; block1_3 <= '0'; block1_4 <= '0';
			block1_5 <= '0'; block1_6 <= '0'; block1_7 <= '0'; block1_8 <= '0'; block1_8 <= '0';
			block1_9 <= '0'; block1_10 <= '0'; block1_11 <= '0';
		end if;
	end process;
end Behavioral;