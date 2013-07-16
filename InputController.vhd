library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.custom_flow.all;


entity InputController is
    Port( 
        Reset,clk : in std_logic;
        enter,valid_start,valid_end : in std_logic;
		key_used : in std_logic;
		level_complete : in std_logic;
		space : in std_logic;
		valid_delete : in std_logic;
		mode : out std_logic;
		str_block : out std_logic;
		str_flow : out std_logic;
		key_ack : out std_logic;
		ld_dyn_reg : out std_logic;
		reset_dynamic : out std_logic;
		reset_main_mem : out std_logic;
		calculate : out std_logic;
		calculate_final : out std_logic;
		reset_pipe : out std_logic;
		del_pipe : out std_logic			-- this signal goes to the main mem unit after we identify the pipe we want to delete

          );
end InputController;

architecture Behavioral of InputController is

type ctrl_state is (A,B,C,D,E,F,G,J,K,H,L,Z,X,V,T,R);
signal State, Next_state : ctrl_state;
signal div_clk : std_logic := '0';
signal frame_clk_div : std_logic_vector(10 downto 0) := "00000000000";

begin
	

  div_clk <= clk;


Assign_Next_State : process (div_clk, Reset)
begin
  if (Reset = '1') then
   State <= A;
  elsif (rising_edge(div_clk)) then
    State <= Next_state;
  end if;
end process;

Get_Next_State : process (State, key_used, enter, valid_start, valid_end, valid_delete,space,level_complete)
begin
  case State is
	--- WIN STATE
	when R =>
  		if(key_used = '1') then
			Next_state <= A;
		else
			Next_state <= R;
		end if;
	--------------------------------- DELETE PIPE STATES
	when X =>
		if(key_used = '0') then
			Next_state <= A;
		else
			Next_state <= X;
		end if;
	when T =>
		Next_state <= X;
	when Z =>
		Next_state <= T;
	--------------------------------
	-- complete level state / send signals and load the next level
--	when K =>
--		Next_state <= A;
	-- wait here until a key is used
    when A => 
      if (key_used='1' and enter='1' and valid_start ='1' and level_complete = '0') then
        Next_state <= C;
	  elsif(key_used = '1' and space = '1' and valid_delete='1' and level_complete = '0' ) then
		Next_state <= Z;
	  elsif(level_complete = '1') then
		Next_state <= R;
	  else
        Next_state <= A;
	  end if;
	-- store block we are current processing.
    when C =>
		if(key_used ='0') then
			Next_state <= D;
		else
			Next_state <= C;
		end if;
		
	--------------------------------
	-- in state D : incoming X,Y and prevX,Y determine which to route
	when D =>
		-- if exiting fl ow mode
		if( enter = '1' and key_used='1' and valid_end = '1') then
			Next_state <= J;
		-- if I want to delete the current flow I'm working and enter back into spec mode.
		elsif(key_used = '1' and space = '1') then
			Next_state <= E;
		-- capture any keys pressed and process them
		elsif(key_used = '1') then
			Next_state <= H;
		else
			Next_state <= D;
		end if;
	-- Intermediate state that checks if on own snake or if on a existing flow
	when H =>
		Next_state <= L;
	-- Intermediate state that checks if on block
	when L =>
		Next_state <= F;
	--- Load into reg state ---
	when F =>
		Next_state <= G;
	-- send and debounce the key
	when G =>
		if(key_used = '0') then
			Next_state <= D;
		else
			Next_state <= G;
		end if;
--------------------------------

		
-- in this state we store the valid pipe into memory --
	when J =>
		Next_state <= E;
-- Reset dynamc memory state
	when E =>
		if(enter ='0' and space = '0') then
			Next_state <= A;
		else
			Next_state <= E;
		end if;
	when others =>
      NULL;
  end case;
end process;

Assign_Control_Signals : process  (State)
begin
  str_block <= '0';
  mode <= '0';
  str_flow <= '0';
  ld_dyn_reg <= '0';
  key_ack <= '1';
  reset_dynamic <= '0';
  reset_main_mem <= '0';
  calculate <= '0';
  calculate_final <= '0';
  reset_pipe <= '0';
  del_pipe <= '0';
  case State is
--------DELETE PIPE STATE--------
	when X =>
	  key_ack <= '0';			-- active low (unitil the key is released move onto next state)
	when T =>
	  del_pipe <= '1';
    when Z =>
	  reset_pipe <= '1';
---------------------------------	  
	  
	when A =>
	when C =>
		str_block <= '1';
		key_ack <= '0';
	when D =>
		mode <= '1';
	
	-----------------------------------------
	-- first do the check to see if on any existing flows/ on itself
	when H =>
		mode <= '1';
		calculate <= '1';
	-- next do the check to see if on any blocks/ process blocks
	when L =>
		mode <= '1';
		calculate_final <= '1';
	-- state to store the flow
	when F =>
		ld_dyn_reg <= '1';
		mode <= '1';
	-- state that sends acknowledgement back that we processed key
	when G =>
		key_ack <= '0';			-- active low (unitil the key is released move onto next state)
		mode <= '1';
	-----------------------------------------
	
	when J =>
		str_flow <= '1';
	when E =>
		reset_dynamic <= '1';
--		key_ack <= '0';
	when R =>
		reset_dynamic <= '1';
		reset_main_mem <= '1';
    when others =>  
      NULL;
  end case;
end process;

end Behavioral;