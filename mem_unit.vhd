library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.custom_flow.all;


entity mem_unit is
	Port( Load_En, clk, Reset : in std_logic;
		Data_In_x, Data_In_y : in REG;
		valid_coords_index : in integer;
		chosen_block	: in integer;
		
		--data for flows
		Data_Out_x_0, Data_Out_y_0,Data_Out_x_1, Data_Out_y_1, Data_Out_x_2, Data_Out_y_2 : out REG;
		Data_Out_x_3, Data_Out_y_3,Data_Out_x_4, Data_Out_y_4,Data_Out_x_5, Data_Out_y_5 : out REG;
		Data_Out_x_6, Data_Out_y_6,Data_Out_x_7, Data_Out_y_7,Data_Out_x_8, Data_Out_y_8 : out REG;
		Data_Out_x_9, Data_Out_y_9,Data_Out_x_10, Data_Out_y_10,Data_Out_x_11, Data_Out_y_11 : out REG;	
		out_valid_coords_index : out COORDS;
		--bit vector (ON/OFF)
		mask : out std_logic_vector(11 downto 0)

		);
end mem_unit;

architecture Behavioral of mem_unit is

type DATA_UNIT is array (0 to 11) of REG;
signal memory_x : DATA_UNIT := (others=>(others=> (others=>'0')));
signal memory_y : DATA_UNIT := (others=>(others=> (others=>'0')));

signal valid_coords_storage : COORDS;
signal mask_sig : std_logic_vector(11 downto 0) := "000000000000";

begin
	operate_reg : process(clk, Load_En, Reset, chosen_block, Data_In_x, Data_In_y, valid_coords_index, valid_coords_storage, mask_sig, memory_x, memory_y)
	begin
		if(Reset = '1') then
			memory_x <= (others=>(others=> (others=>'0')));
			memory_y <= (others=>(others=> (others=>'0')));
			mask_sig <= "000000000000";
			valid_coords_storage <= (0,0,0,0,0,0,0,0,0,0,0,0);
		else
			if(rising_edge(clk)) then
				if(Load_En = '1') then
					memory_x(chosen_block) <= Data_In_x;
					memory_y(chosen_block) <= Data_In_y;
					valid_coords_storage(chosen_block) <= CONV_STD_LOGIC_VECTOR(valid_coords_index,6);
					mask_sig(chosen_block) <= '1';
				else
					memory_x <= memory_x;
					memory_y <= memory_y;
					valid_coords_storage <= valid_coords_storage;
					mask_sig <= mask_sig;
				end if;	
			end if;
		end if;
	end process;
	
	-- map to outputs
	Data_Out_x_0 <= memory_x(0); Data_Out_x_1 <= memory_x(1); Data_Out_x_2 <= memory_x(2); Data_Out_x_3 <= memory_x(3);
	Data_Out_x_4 <= memory_x(4); Data_Out_x_5 <= memory_x(5); Data_Out_x_6 <= memory_x(6); Data_Out_x_7 <= memory_x(7);
	Data_Out_x_8 <= memory_x(8); Data_Out_x_9 <= memory_x(9); Data_Out_x_10 <= memory_x(10); Data_Out_x_11 <= memory_x(11);

	Data_Out_y_0 <= memory_y(0); Data_Out_y_1 <= memory_y(1); Data_Out_y_2 <= memory_y(2); Data_Out_y_3 <= memory_y(3);
	Data_Out_y_4 <= memory_y(4); Data_Out_y_5 <= memory_y(5); Data_Out_y_6 <= memory_y(6); Data_Out_y_7 <= memory_y(7);
	Data_Out_y_8 <= memory_y(8); Data_Out_y_9 <= memory_y(9); Data_Out_y_10 <= memory_y(10); Data_Out_y_11 <= memory_y(11);
	
	out_valid_coords_index <= valid_coords_storage;
	mask <= mask_sig;

end Behavioral;