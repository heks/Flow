library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.custom_flow.all;


entity logic_control is
    Port( clk           : in std_logic;
          Reset         : in std_logic;
          str_block		: in std_logic;
          str_flow 		: in std_logic;		-- did we make a flow connection?
          valid_begin_flow, valid_end_flow : out std_logic;
          flow_mode : in std_logic;
--          blk0_x, blk0_y, blk1_x, blk1_y : in BLOCKS; -- input blocks to check valid          
          PosX, PrevPosX, PosY, PrevPosY : in std_logic_vector(9 downto 0);
          F_PosX, F_PosY	: out std_logic_vector(9 downto 0);
          valid_coords : out integer range 0 to 11;
          ld_reg : in std_logic;
          --INPUT FROM DYNAMIC REG
--          	Data_in_x, Data_in_y : in REG;
--			in_coords_reg : in integer range 0 to 50;
			--OUTPUT INTO DYNAMIC REG
          actual_ld_reg : out std_logic;
 --         pairs : in integer range 10 to 15;
          --INPUT FROM STORAGE MEMORY
--         pipe0_x, pipe1_x,pipe2_x, pipe3_x,pipe4_x, pipe5_x, pipe6_x, pipe7_x,pipe8_x, pipe9_x,pipe10_x, pipe11_x : in REG;--
--		  pipe0_y, pipe1_y,pipe2_y, pipe3_y,pipe4_y, pipe5_y, pipe6_y, pipe7_y,pipe8_y, pipe9_y,pipe10_y, pipe11_y : in REG;
--		  coordinate_storage : in COORDS;
          --OUTPUT TO CONTROL LEVELS
          level_complete : out std_logic;		--level complete flag
          delete : out std_logic;
          calculate : in std_logic;
          valid_delete_flow : out std_logic;
          delete_pipe : in std_logic;
          str_flag_color, del_flag_color : in std_logic;
          flows : out std_logic_vector(3 downto 0)
          );
          end logic_control;



architecture Behavioral of logic_control is
signal chosen_block : integer := 16;
signal temp_block : integer := 16;
signal proc_blocks : std_logic_vector(11 downto 0) := "000000000000";
signal chosen_pair : std_logic := '0';
signal temp_chosen_pair : std_logic := '0';
signal str_flag : std_logic;
signal valid_start : std_logic;
signal valid_end : std_logic;
signal flow_count : std_logic_vector(3 downto 0) := "0000";
--helper funtion signals
signal block_number : integer;
signal on_block,del_flag : std_logic;

begin	

Store_block_pos : process( str_block, clk, temp_block, ld_reg)
begin
	if(rising_edge(clk)) then
		actual_ld_reg <= '0';
		delete <= '0';
		if(ld_reg = '1') then
		actual_ld_reg <= not str_flag;
		delete <= del_flag;
		end if;
	end if;
end process;


Store_coordinate : process( str_block, clk, temp_block,delete_pipe)
begin
	if(rising_edge(clk) and str_block = '1') then
		chosen_block <= temp_block;
		chosen_pair <= temp_chosen_pair;
	elsif(rising_edge(clk) and delete_pipe = '1') then
		chosen_block <= temp_block;
	end if;
end process;

level_complete_logic : process(flow_mode, clk, proc_blocks)
begin
	if(rising_edge(clk) and flow_mode = '0' ) then
		if((proc_blocks = "011111111111")) then
			level_complete <= '1';
		else
			level_complete <= '0';
		end if;
	end if;
end process;

store_flow : process( str_flow, clk, proc_blocks,Reset, delete_pipe)
begin
	if(Reset = '1') then
		proc_blocks <= "000000000000";
		flow_count <= "0000";
	elsif(rising_edge(clk) and str_flow = '1') then
		proc_blocks(chosen_block) <= '1';		-- update to indicate we processed the block pair
		flow_count <= flow_count + '1';
	elsif(rising_edge(clk) and delete_pipe = '1') then
		proc_blocks(temp_block) <= '0';
		flow_count <= flow_count - '1';
	end if;
end process;	



DetermineXY : process(PosX,ld_reg,calculate, PosY, chosen_block,flow_mode, on_block,clk,PrevPosX,PrevPosY,str_flag)
begin
		if(rising_edge(clk) and calculate ='1') then
			-- these get overwritte later
			str_flag <= '0';
			del_flag <= '0';
			F_PosX <= PosX;
			F_PosY <= PosY;
			valid_end <= '0';
			--check for a move backward on initial block.
			if(PrevPosX = PosX and PrevPosY=PosY) then
				str_flag <= '1';
				del_flag <= '0';
			-- check for a move backwards
--			elsif((PosX = Data_in_x(in_coords_reg-2) and PosY = Data_in_y(in_coords_reg-2))
--			OR (PosX = blk1_x(chosen_block) AND PosY = blk1_y(chosen_block) AND chosen_pair = '1')
--			OR (PosX = blk0_x(chosen_block) AND PosY = blk0_y(chosen_block) and chosen_pair = '0')) then
--				del_flag <= '1';
--				str_flag <= '1';
			-- check for any stable blocks on the map
			elsif( (PosX = blk0_x(chosen_block) AND PosY = blk0_y(chosen_block) and chosen_pair = '1')
			 OR (PosX = blk1_x(chosen_block) AND PosY = blk1_y(chosen_block) and chosen_pair = '0') ) then
				str_flag <= '1';	-- active low
				del_flag <= '0';
				F_PosX <= PrevPosX;
				F_PosY <= PrevPosY;
				valid_end <= '1';
			elsif(del_flag_color = '1' OR (PosX = blk1_x(chosen_block) AND PosY = blk1_y(chosen_block) AND chosen_pair = '1')
					OR (PosX = blk0_x(chosen_block) AND PosY = blk0_y(chosen_block) and chosen_pair = '0')) then
				del_flag <= '1';
				str_flag <= '1';
			elsif(str_flag_color = '1') then
				F_PosX <= PrevPosX;
				F_PosY <= PrevPosY;
				str_flag <= '1';
			else
				for I in 0 to 11 loop
					if(((PosX = blk0_x(I) AND PosY = blk0_y(I)) OR (PosX = blk1_x(I) AND PosY = blk1_y(I))) AND I /= chosen_block) then
						F_PosX <= PrevPosX;
						F_PosY <= PrevPosY;
						str_flag <= '1';
						exit;
					end if;
				end loop;
			end if;
		-- FLOW MODE = 0 
		elsif(rising_edge(clk) and flow_mode = '0') then
			F_PosX <= PosX;
			F_PosY <= PosY;
			valid_start <= '0';
			valid_delete_flow <= '0';
			-- this right here checks if we are on a valid starting position
			for I in 0 to 11 loop
				if(proc_blocks(I) = '0' AND (PosX = blk0_x(I) AND PosY = blk0_y(I))) then
					temp_block <= I;
					valid_start <= '1';
					temp_chosen_pair <= '0';
					exit;
				elsif(proc_blocks(I) = '0' AND ((PosX  = blk1_x(I) AND PosY = blk1_y(I)))) then
					temp_block <= I;
					valid_start <= '1'; -- wont let you transition to the next state if not on a valid start block
					temp_chosen_pair <= '1';
					exit;
				elsif(proc_blocks(I) = '1' AND ((PosX  = blk1_x(I) AND PosY = blk1_y(I)) OR (PosX  = blk0_x(I) AND PosY = blk0_y(I)))) then
					valid_delete_flow <= '1';
					temp_block <= I;
					exit;
				end if;
			end loop;
--		elsif(rising_edge(clk) and ld_reg = '1') then
--			actual_ld_reg <= not str_flag;
--			delete <= del_flag;
		end if;
end process;
	
valid_begin_flow <= valid_start; 
valid_end_flow <= valid_end;
valid_coords <= chosen_block;
flows <= flow_count;

end Behavioral;