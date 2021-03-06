library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.custom_flow.all;


entity levelunit is
   Port ( 
         level : in std_logic_vector(2 downto 0);
         blk0_x, blk0_y, blk1_x, blk1_y : out BLOCKS; -- first set of blocks (recieved from the level)      
         pairs : out integer range 10 to 15		-- in my implementation can have either 12 flows or less.    
           ); 
end levelunit;

architecture Behavioral of levelunit is
begin
	operate: process(level)
	begin
	case level is
	when "001" =>
	-- first set of blocks in level 22 on iphone game
	   --1st gray block
--	   blk0_x(0) <= "0001111000"; -- 120 
--	   blk0_y(0) <= "0000101000"; -- 40
	   -- 2nd gray block
--	   blk1_x(0) <= "0011110000"; -- 240
--	   blk1_y(0) <= "0101101000"; -- 360
	   -- 1st red block
--	   blk0_x(1) <= "0010100000"; -- 160
--	   blk0_y(1) <= "0000101000"; -- 40
	   -- 2nd red block
--	   blk1_x(1) <= "0100011000"; -- 280
--	   blk1_y(1) <= "0001010000"; -- 80
	   -- 1st dark red block
--	   blk0_x(2) <= "0110010000"; -- 400
--	   blk0_y(2) <= "0001111000"; -- 120
	   -- 2nd dark red block
--	   blk1_y(2) <= "0110111000"; -- 440
--	   blk1_x(2) <= "0101101000"; -- 360
	   --1st pink block 
--	   blk0_x(3) <= "0001010000"; -- 80
--	   blk0_y(3) <= "0010100000"; -- 160
	   --2nd pink block 
--	   blk1_x(3) <= "0010100000"; -- 160
--	   blk1_y(3) <= "0010100000"; -- 160
	   --1st blue block
--	   blk0_x(4) <= "0101000000"; -- 320
--	   blk0_y(4) <= "0010100000"; -- 160
	   --2nd blue block
--	   blk1_x(4) <= "0100011000"; -- 280
--	   blk1_y(4) <= "0101000000"; -- 320
	   --1st white block
--	   blk0_x(5) <= "0001111000"; -- 120
--	   blk0_y(5) <= "0011110000"; -- 240
	   --2nd white block
--	   blk1_x(5) <= "0010100000"; -- 160
--	   blk1_y(5) <= "0101101000"; -- 360
	   --1st orange block
--	   blk0_x(6) <= "0010100000"; -- 160
--	   blk0_y(6) <= "0011110000"; -- 240
	   --2nd orange block
--	   blk1_x(6) <= "0011110000"; -- 240
--	   blk1_y(6) <= "0101000000"; -- 320
	   --1st green block
--	   blk0_x(7) <= "0101000000"; -- 320
--	   blk0_y(7) <= "0011110000"; -- 240
	   --2nd green block
--	   blk1_x(7) <= "0010100000"; -- 160
--	   blk1_y(7) <= "0110010000"; -- 400
	   --1st light blue block
--	   blk0_x(8) <= "0010100000"; -- 160
--	   blk0_y(8) <= "0100011000"; -- 280
	   --2nd light blue block
--	   blk1_x(8) <= "0001010000"; -- 80
--	   blk1_y(8) <= "0110111000"; -- 440
	   --1st yellow block
--	   blk0_x(9) <= "0110010000"; -- 400
--	   blk0_y(9) <= "0100011000"; -- 280
	   --2nd yellow block
--	   blk1_x(9) <= "0100011000"; -- 280
--	   blk1_y(9) <= "0110010000"; -- 400
	   --1st purple block
--	   blk0_x(10) <= "0101000000"; -- 320
--	   blk0_y(10) <= "0101000000"; -- 320
	   --2nd purple block
--	   blk1_x(10) <= "0110010000"; -- 400
--	   blk1_y(10) <= "0101000000"; -- 320
	   -- only 11 flows in this so we put this off the screen
--	   blk0_x(11) <= "1010000000"; -- map to no where
--	   blk0_y(11) <= "1010000000"; -- map to no where
	   --2nd purple block
--	   blk1_x(11) <= "1010000000"; -- map to no where
--	   blk1_y(11) <= "1010000000"; -- map to no where
--	   pairs <= 11;
	when "000" =>
		-- first set of blocks in level 21 on iphone game
	   --1st pink block
	   blk0_x(0) <= "0100011000"; -- 120 
	   blk0_y(0) <= "0000000000"; -- 0
	   -- 2nd pink block
	   blk1_x(0) <= "0110010000"; -- 240
	   blk1_y(0) <= "0110010000"; -- 360
	   -- 1st yellow block
	   blk0_x(1) <= "0001111000"; -- 160
	   blk0_y(1) <= "0000101000"; -- 40
	   -- 2nd yellow block
	   blk1_x(1) <= "0101000000"; -- 280
	   blk1_y(1) <= "0001010000"; -- 80
	   -- 1st blue block
	   blk0_x(2) <= "0100011000"; -- 400
	   blk0_y(2) <= "0000101000"; -- 120
	   -- 2nd blue block
	   blk1_y(2) <= "0011001000"; -- 440
	   blk1_x(2) <= "0101000000"; -- 360
	   --1st green block 
	   blk0_x(3) <= "0110010000"; -- 80
	   blk0_y(3) <= "0000101000"; -- 160
	   --2nd green block 
	   blk1_x(3) <= "0111100000"; -- 160
	   blk1_y(3) <= "0101101000"; -- 160
	   --1st dark red block
	   blk0_x(4) <= "0001111000"; -- 320
	   blk0_y(4) <= "0001010000"; -- 160
	   --2nd dark red block
	   blk1_x(4) <= "0010100000"; -- 280
	   blk1_y(4) <= "0011001000"; -- 320
	   --1st purple block
	   blk0_x(5) <= "0010100000"; -- 120
	   blk0_y(5) <= "0001010000"; -- 240
	   --2nd purple block
	   blk1_x(5) <= "0001111000"; -- 120
	   blk1_y(5) <= "0110010000"; -- 400
	   --1st white block
	   blk0_x(6) <= "0110111000"; -- 160
	   blk0_y(6) <= "0001010000"; -- 240
	   --2nd white block
	   blk1_x(6) <= "0110111000"; -- 240
	   blk1_y(6) <= "0011001000"; -- 320  
	   --1st red block
	   blk0_x(7) <= "0101000000"; -- 320
	   blk0_y(7) <= "0010100000"; -- 240
	   --2nd red block
	   blk1_x(7) <= "0011110000"; -- 160
	   blk1_y(7) <= "0101101000"; -- 400
	   --1st gray block
	   blk0_x(8) <= "0011110000"; -- 160
	   blk0_y(8) <= "0011110000"; -- 280
	   --2nd gray block
	   blk1_x(8) <= "0111100000"; -- 80
	   blk1_y(8) <= "0110010000"; -- 440	   
	   --1st orange block
	   blk0_x(9) <= "0011001000"; -- 400
	   blk0_y(9) <= "0100011000"; -- 280
	   --2nd orange block
	   blk1_x(9) <= "0010100000"; -- 280
	   blk1_y(9) <= "0110010000"; -- 400
	   --1st light blue block
	   blk0_x(10) <= "0101000000"; -- 320
	   blk0_y(10) <= "0101101000"; -- 320
	   --2nd light blue block
	   blk1_x(10) <= "0110010000"; -- 400
	   blk1_y(10) <= "0101101000"; -- 320
	   
	   -- only 11 flows in this so we put this off the screen
	   blk0_x(11) <= "1010000000"; -- map to no where
	   blk0_y(11) <= "1010000000"; -- map to no where
	   --2nd purple block
	   blk1_x(11) <= "1010000000"; -- map to no where
	   blk1_y(11) <= "1010000000"; -- map to no where
		pairs <= 11;
--	when "010" =>
	-- first set of blocks in level 24 on iphone game
	   --1st purple block
--	   blk0_x(0) <= "0101000000"; -- 6*40+80 
--	   blk0_y(0) <= "0000000000"; -- 0
	   -- 2nd purple block
--	   blk1_x(0) <= "0111100000"; -- 10*40+80
--	   blk1_y(0) <= "0010100000"; -- 4*40
	   -- 1st yellow block
---	   blk0_x(1) <= "0011110000"; -- 4*40+80
--	   blk0_y(1) <= "0000101000"; -- 1*40
	   -- 2nd yellow block
--	   blk1_x(1) <= "0000101000"; -- 1*40+80
--	   blk1_y(1) <= "0101101000"; -- 9*40
	   -- 1st green block
--	   blk0_x(2) <= "0011001000"; -- 3*40+80
--	   blk0_y(2) <= "0001010000"; -- 2*40
	   -- 2nd green block
--	   blk1_y(2) <= "0101000000"; -- 440
--	   blk1_x(2) <= "0010100000"; -- 360
	   
	   
	   --1st light blue block 
--	   blk0_x(3) <= "0101101000"; -- 80
--	   blk0_y(3) <= "0000101000"; -- 160
	   --2nd light blue block 
--	   blk1_x(3) <= "0111100000"; -- 160
--	   blk1_y(3) <= "0101101000"; -- 160
	   --1st dark red block
--	   blk0_x(4) <= "0001111000"; -- 320
--	   blk0_y(4) <= "0001010000"; -- 160
	   --2nd dark red block
--	   blk1_x(4) <= "0010100000"; -- 280
--	   blk1_y(4) <= "0011001000"; -- 320
	   --1st purple block
--	   blk0_x(5) <= "0001111000"; -- 120
--	   blk0_y(5) <= "0011110000"; -- 240
	   --2nd purple block
--	   blk1_x(5) <= "0001111000"; -- 120
--	   blk1_y(5) <= "0110010000"; -- 400
	   --1st white block
--	   blk0_x(6) <= "0110010000"; -- 160
--	   blk0_y(6) <= "0001010000"; -- 240
	   --2nd white block
--	   blk1_x(6) <= "0110010000"; -- 240
--	   blk1_y(6) <= "0011001000"; -- 320  
	   --1st red block
--	   blk0_x(7) <= "0010100000"; -- 320
--	   blk0_y(7) <= "0101000000"; -- 240
	   --2nd red block
--	   blk1_x(7) <= "0011110000"; -- 160
--	   blk1_y(7) <= "0101101000"; -- 400
	   --1st gray block
--	   blk0_x(8) <= "0011110000"; -- 160
--	   blk0_y(8) <= "0011110000"; -- 280
	   --2nd gray block
--	   blk1_x(8) <= "0111100000"; -- 80
--	   blk1_y(8) <= "0110010000"; -- 440	   
	   --1st orange block
--	   blk0_x(9) <= "0011001000"; -- 400
--	   blk0_y(9) <= "0100011000"; -- 280
	   --2nd orange block
--	   blk1_x(9) <= "0010100000"; -- 280
--	   blk1_y(9) <= "0110010000"; -- 400
	   --1st light blue block
--	   blk0_x(10) <= "0101000000"; -- 320
--	   blk0_y(10) <= "0101000000"; -- 320
	   --2nd light blue block
--	   blk1_x(10) <= "0110010000"; -- 400
--	   blk1_y(10) <= "0101000000"; -- 320
	   
	   -- only 11 flows in this so we put this off the screen
--	   blk0_x(11) <= "1010000000"; -- map to no where
--	   blk0_y(11) <= "1010000000"; -- map to no where
	   --2nd purple block
--	   blk1_x(11) <= "1010000000"; -- map to no where
--	   blk1_y(11) <= "1010000000"; -- map to no where
--	when "011" =>
--	when "100" =>
--	when "101" =>
--	when "110" =>
	when others =>
		NULL;
	end case;
	end process;
end Behavioral;