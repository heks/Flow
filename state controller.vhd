library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.custom_flow.all;


entity InputController is
    Port( clk           : in std_logic;
          Reset         : in std_logic;
          PosX, PosY	: out std_logic_vector(9 downto 0);
          w,a,s,d,enter		: out std_logic;
		  key_code	 : in std_logic_vector(7 downto 0);
          key_used : out std_logic; -- output back to keybaord
          key_used_snake : in std_logic;
          ld_spectate		: out std_logic;	-- spectate mode or flow mode
          ld_flow :	out std_logic; 	-- output into snake movement
          valid_input_check		: in std_logic; -- input from valid_input_checker
          flow_complete : in std_logic -- level complete OR flow complete from flow checker
          );
end InputController;

architecture Behavioral of InputController is

type ctrl_state is (X, Y, Z);
signal State, Next_state : ctrl_state;
signal w_sig,a_sig,s_sig,d_sig : std_logic;
signal PosX_sig : std_logic_vector(9 downto 0) := X_Min;
signal PosY_sig : std_logic_vector(9 downto 0) := Y_Min;
signal enter_sig : std_logic;


begin

Assign_Next_State : process (clk, reset)
begin
  if (Reset = '1') then
   PosX_sig <= X_Min;
   PosY_sig <= Y_Min;
   State <= X;
  elsif (rising_edge(clk)) then
    State <= Next_state;
  end if;
end process;

Get_Next_State : process (State)
begin
  case State is
    when X => 
      if (enter_sig = '1' AND valid_input_check = '1') then -- when enter pressed and on a valid pos_x, pos_y
        Next_state <= Y;
      else
        Next_state <= X;
	  end if;
	when Y =>
      if(flow_complete = '1') then
        Next_state <= X;
      else
        Next_state <= Z;
	  end if;
    when Z =>
		-- key synchronization
		if( key_used_snake = '1' ) then
			Next_state <= Y;
		else
			Next_state <= Z;
		end if;
    when others =>
      NULL;
  end case;
end process;

Assign_Control_Signals : process (State)
begin
  key_used <= key_used_snake;
  ld_spectate <= '0';
  ld_flow <= '0';
  PosX <= PosX_sig;
  PosY <= PosY_sig;
  case State is
	when X =>
		ld_spectate <= '1';
	when Y =>
	    ld_flow <= '1';
	when Z =>
    when others =>
      NULL;
  end case;
end process;

Assign_w_a_s_d : process(key_code)
begin
	PosX_sig <= PosX_sig;
	PosY_sig <= PosY_sig;
	w <= '0';
	a <= '0';
	s <= '0';
	d <= '0';
	enter_sig <= '0';
	key_used <= '1';
	case key_code is
		when "00011101" =>  --w scan code subtract stepsize
		   w <= '1';
		   if( PosY_sig - "0000101000" > Y_Min ) then
		       PosY_sig <= PosY_sig - "0000101000";
		   end if;
		when "00011100" =>  -- a scan code subract stepsize
		   a <= '1';
		   if( PosX_sig - "0000101000" > X_Min ) then 
		       PosX_sig <= PosX_sig - "0000101000";
			end if;
		when "00011011" =>	-- s scan code
		   s <= '1';
		   if( PosY_sig + "0000101000" < Y_Max ) then
		       PosY_sig <= PosY_sig + "0000101000";
			end if;
		when "00100011" =>	-- d scan code
		   d <= '1';	
		   if( PosY_sig + "0000101000" < X_Max ) then
		       PosX_sig <= PosX_sig + "0000101000";
		       end if;
		when "01011010" => -- enter pressed
			enter <= '1';
		when others =>
		   NULL;
	end case;
end process;
 
enter <= enter_sig; 
 
end Behavioral;