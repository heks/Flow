---------------------------------------------------------------------------
---------------------------------------------------------------------------
--    Ball.vhd                                                           --
--    Viral Mehta                                                        --
--    Spring 2005                                                        --
--                                                                       --
--    Modified by Stephen Kempf 03-01-2006                               --
--                              03-12-2007                               --
--    Fall 2012 Distribution                                             --
--                                                                       --
--    For use with ECE 385 Lab 9                                         --
--    UIUC ECE Department                                                --
---------------------------------------------------------------------------
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity movement is
   Port ( Reset,w,a,s,d : in std_logic;
        
        outX : out std_logic_vector(9 downto 0); --connected to input of dynamic register
        outY : out std_logic_vector(9 downto 0); -- connected to input dynamic register
        ld_dynamic_reg : out std_logic;
        
        inX, inY : in std_logic_vector(9 downto 0);
        check_level_signal : out std_logic; -- mux select to valid input checker
        valid_move : in std_logic;
        Clk : in std_logic;
        flow_signal : in std_logic
        );

end movement;

architecture Behavioral of movement is

signal X_pos, Y_pos : std_logic_vector(9 downto 0);

begin
-------------------------------------------------

--  process(frame_clk, reset)
--  begin
--    if (reset = '1') then
--      frame_clk_div <= "000000";
--    elsif (rising_edge(frame_clk)) then
--      frame_clk_div <= frame_clk_div + '1';
--    end if;
--  end process;


  Move_Ball: process(Reset, inX, inY)
  begin
    if(Reset = '1') then   --Asynchronous Reset
      Y_Motion <= "0000000000";
      X_Motion <= "0000000000";
      Y_Pos <= "0000000000";
      X_pos <= "0000000000";

    elsif( rising_edge(Clk) ) then
    
	--check if inbounds (kind of redundant here)
	if( (inY + Y_Motion >= Y_Min) AND (inY+Y_Motion <= Y_Max) AND (valid_move = '1') ) then
      Y_pos <= inY + Ball_Y_Motion;
    else  
	  Y_pos <= inY;
	end if;
	
	--check if inbounds (kind of redundant here)
	if( (inX + X_Motion >= X_Min) AND (inX+X_Motion <= X_Max) AND (valid_move = '1') ) then
      X_pos <= inX + X_Motion;
    else  
	  X_pos <= inX;
	end if;
	
	-- way to check against own snake -- also need to check against snakes already placed on the board
	
end process Move;

  outX <= X_Pos;
  outY <= Y_Pos;
  
 
end Behavioral;      
