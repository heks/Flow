library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control is
	Port(
		Reset, Clk : in std_logic;
		CurrentCode, PreviousCode : in std_logic_vector(7 downto 0);
		Shift : out std_logic;
		KeycodeOut : out std_logic_vector(7 downto 0);
		Newkeyrdy : out std_logic
	);
end control;

architecture Behavioral of control is
	type cntrl_state is (A, B, C, D, E, F, G, H, I, J, K);
	signal state, next_state : cntrl_state;
	begin
	control_reg : process(Reset, Clk)
	begin
		if (Reset = '1') then
			state <= A;
		elsif(rising_edge(Clk)) then
			state <= next_state;
		end if;
	end process;
	
	get_next_state : process(state)
	begin
		case state is
			when A =>
				next_state <= B; --go onto the next state
			when B =>
				next_state <= C; --go onto the next state
			when C =>
				next_state <= D; --go onto the next state
			when D =>
				next_state <= E; --go onto the next state
			when E =>
				next_state <= F; --go onto the next state
			when F =>
				next_state <= G; --go onto the next state
			when G =>
				next_state <= H; --go onto the next state
			when H =>
				next_state <= I; --go onto the next state
			when I =>
				next_state <= J; --go onto the next state
			when J =>
				next_state <= K; --go onto the next state
			when K =>
				next_state <= A; --go onto the next state
		end case;
	end process;
	
	get_cntrl_out : process(state, CurrentCode, PreviousCode)
	begin
		Shift <= '0';
		Newkeyrdy <= '0';
			case state is
				when B|C|D|E|F|G|H|I =>
					Shift <= '1';
				when J => --parity bit so dont shift // not ready
					Shift <= '0';
				when K =>
					if( CurrentCode /= "11110000" AND PreviousCode /= "11110000" ) then
						KeycodeOut <= CurrentCode;
						Newkeyrdy <= '1';
					end if;
				when A =>
					Shift <= '0';
			end case;
	end process;

end Behavioral;