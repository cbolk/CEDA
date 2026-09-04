-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    generic (
        LOCK_MS   : integer := 20            -- ms during which oscillations of the btn_in signal are ignored after a high front
    );
    port (
        clk       : in  std_logic;
        tick      : in  std_logic;
        rst       : in  std_logic;
        btn_in    : in  std_logic;
        btn_pulse : out std_logic            -- high only for one clock cycle after the first rising edge
    );
end  debounce;
 
architecture Behavioral of debounce is
 
    signal ff1, ff2  : std_logic := '0';
    signal rising    : std_logic;
    signal locked    : std_logic := '0';
    signal lock_cnt  : integer range 0 to LOCK_MS := 0;
 
begin
 
    -- rising edge search with two FFs
    process(clk)
    begin
        if rising_edge(clk) then
            ff1 <= btn_in;
            ff2 <= ff1;
        end if;
    end process;
 
    rising <= ff1 and (not ff2);
 
    -- lock logic
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                locked    <= '0';
                lock_cnt  <= 0;
                btn_pulse <= '0';
            else
                btn_pulse <= '0'; 
 
                if locked = '0' then
                    if rising = '1' then
                        btn_pulse <= '1';   -- high one for one clock cycle
                        locked    <= '1';   -- starts lock
                        lock_cnt  <= 0;
                    end if;
                else
                    if lock_cnt = LOCK_MS then
                        locked   <= '0';    -- lock time has ended
                        lock_cnt <= 0;
                    else
                        if tick='1' then
                        lock_cnt <= lock_cnt + 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
 
end architecture Behavioral;
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity prescaler is
    generic(
    fclk: integer:= 100000000 -- overwritten when component is instantiated
    );
    Port(
    rst: in std_logic;
    clk: in std_logic;
    tick: out std_logic
    );
end prescaler;

architecture Behavioral of prescaler is
signal counter: integer;
constant tick_per_ms: integer:=fclk/1000; -- number of clock cycles in a millisecond
begin

process(clk)
begin
if rising_edge(clk) then
    if rst='1' then
    counter<=0;
    tick<='0';
    elsif counter<tick_per_ms then
            tick<='0';
            counter<=counter+1;
    else 
         counter<=0;
         tick<='1';
    end if;
end if;
end process;

end Behavioral;
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_multiplexer is
port(
	clk: in std_logic;
	rst: in std_logic;
	tick: in std_logic;
    	an	: in std_logic_vector(7 downto 0);
	anode 	: out std_logic_vector(7 downto 0);
	digit 	: out std_logic_vector(3 downto 0);
	digit0	: in std_logic_vector(3 downto 0);
	digit1	: in std_logic_vector(3 downto 0);
	digit2	: in std_logic_vector(3 downto 0);
	digit3	: in std_logic_vector(3 downto 0);
	digit4	: in std_logic_vector(3 downto 0);
	digit5	: in std_logic_vector(3 downto 0);
	digit6	: in std_logic_vector(3 downto 0);
	digit7	: in std_logic_vector(3 downto 0)
);
end display_multiplexer;

architecture behavioral of display_multiplexer is
	signal counter: unsigned(2 downto 0);	
begin
	mux: process(clk, rst, tick, counter)
	begin
	if rst='1' then
		anode<=(others=>'1');
		counter<=(others=>'0');
	end if;
	if rising_edge(clk) then
	if tick='1' then
		anode<=(others=>'1');
		counter<=counter+1;
		case counter is
		when "000" =>
		digit<=digit0;
		anode(0 downto 0)<=an(0 downto 0);
		when "001" =>
		digit<=digit1;
		anode(1 downto 1)<=an(1 downto 1);
		when "010" =>
		digit<=digit2;
		anode(2 downto 2)<=an(2 downto 2);
		when "011" =>
		digit<=digit3;
		anode(3 downto 3)<=an(3 downto 3);
		when "100" =>
		digit<=digit4;
		anode(4 downto 4)<=an(4 downto 4);
		when "101" =>
		digit<=digit5;
		anode(5 downto 5)<=an(5 downto 5);
		when "110" =>
		digit<=digit6;
		anode(6 downto 6)<=an(6 downto 6);
		when "111" =>
		digit<=digit7;
		anode(7 downto 7)<=an(7 downto 7);
		when others=>
		null;
		end case;
	end if;
	end if;
	end process;
end Behavioral;
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lfsr is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        result : out std_logic_vector(12 downto 0)
    );
end lfsr;

architecture behavioral of lfsr is
    signal reg_lfsr : std_logic_vector(11 downto 0);
begin

    lfsr : process(rst, clk)
    begin
        if rst = '1' then
            reg_lfsr <= (others => '1');
        elsif rising_edge(clk) then
            reg_lfsr(11 downto 1) <= reg_lfsr(10 downto 0);
            reg_lfsr(0) <= reg_lfsr(11) xor reg_lfsr(5) xor reg_lfsr(3) xor reg_lfsr(0);
        end if;
    end process;

    result <= std_logic_vector(unsigned('0'&reg_lfsr) + to_unsigned(1000, 13)); -- output is (random number between 0 and 4095)+1000

end architecture behavioral;
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_segment is
    Port ( 
           binary_input : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is
begin
    process(binary_input)
    begin
        case binary_input is
            when "0000" => segments <= "0000001"; -- 0/O
            when "0001" => segments <= "1001111"; -- 1
            when "0010" => segments <= "0010010"; -- 2
            when "0011" => segments <= "0000110"; -- 3
            when "0100" => segments <= "1001100"; -- 4
            when "0101" => segments <= "0100100"; -- 5/S
            when "0110" => segments <= "0100000"; -- 6/G
            when "0111" => segments <= "0001111"; -- 7
            when "1000" => segments <= "0000000"; -- 8
            when "1001" => segments <= "0000100"; -- 9
            when "1010" => segments <= "1111010"; -- r
            when "1011" => segments <= "0110000"; -- E
            when "1100" => segments <= "0001000"; -- A
            when "1101" => segments <= "1001000"; -- H
            when "1110" => segments <= "1110000"; -- t
            when "1111" => segments <= "1100011"; -- u
            when others => segments <= "1111111"; -- Blank
        end case;
    end process;
end Behavioral;
-----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reflex_tester is 
Port(
clk: in std_logic;
rst: in std_logic;
i_start_stop: in std_logic;
o_led: out std_logic;
display: out std_logic_vector(6 downto 0);
anode: out std_logic_vector(7 downto 0)
);
end reflex_tester;

architecture Behavioral of reflex_tester is 
type state_type is (idle, sstart, swait, sgo, scount, send, serr, stout);
signal state: state_type;
signal wait_time: unsigned (12 downto 0);
signal counter: unsigned (12 downto 0);
signal start_stop: std_logic; 
signal digit0, digit1, digit2, digit3, digit4, digit5, digit6, digit7: std_logic_vector(3 downto 0);
signal tick: std_logic;
signal random_num: std_logic_vector (12 downto 0);
signal digit: std_logic_vector(3 downto 0);
signal an: std_logic_vector(7 downto 0);
component debounce is
    generic (
        LOCK_MS   : integer := 20            
    );
    port (
        clk       : in  std_logic;
        tick      : in  std_logic;
        rst       : in  std_logic;
        btn_in    : in  std_logic;
        btn_pulse : out std_logic           
    );
end component;

component prescaler is
    generic(
    fclk: integer:= 100000000
    );
    Port(
    rst: in std_logic;
    clk: in std_logic;
    tick: out std_logic
    );
end component;

component lfsr is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        result : out std_logic_vector(12 downto 0)
    );
end component;

component seven_segment is
    Port ( 
           binary_input : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component display_multiplexer is
port(
	clk: in std_logic;
	rst: in std_logic;
	tick: in std_logic;
    an	: in std_logic_vector(7 downto 0);
	anode 	: out std_logic_vector(7 downto 0);
	digit 	: out std_logic_vector(3 downto 0);
	digit0	: in std_logic_vector(3 downto 0);
	digit1	: in std_logic_vector(3 downto 0);
	digit2	: in std_logic_vector(3 downto 0);
	digit3	: in std_logic_vector(3 downto 0);
	digit4	: in std_logic_vector(3 downto 0);
	digit5	: in std_logic_vector(3 downto 0);
	digit6	: in std_logic_vector(3 downto 0);
	digit7	: in std_logic_vector(3 downto 0)
);
end component;

begin
stop_debounce: debounce
port map(clk, tick, rst, i_start_stop, start_stop);
prescaler_cmp: prescaler
generic map(fclk => 100000000)
port map(rst, clk, tick);
lfsr_random_gen: lfsr
port map(clk, rst, random_num);
mux: display_multiplexer
port map(clk, rst, tick, an, anode, digit, digit0, digit1, digit2, digit3, digit4, digit5, digit6, digit7);
display_map: seven_segment
port map(digit, display);

process(clk, rst, start_stop, counter, state )
variable c0,c1,c2: std_logic_vector(0 downto 0);
begin
 if rising_edge(clk) then
     if(rst='1') then
        state<=idle;
     else
     case(state) is
      --------------------------------------
     when idle=>
     o_led<='0';
     digit7<="1101"; -- displays HI
     digit6<="0001";
     an<="00111111";
     wait_time<=(others=>'0');
     counter<=(others=>'0');
     if(start_stop='1') then
     state<=sstart;
     end if;
	--------------------------------------
     when sstart=>
     o_led<='0';
     digit7<="0110";  -- displays GO
     digit6<="0000";
     an<="00111111";
     wait_time<=unsigned(random_num);
     counter<=(others=>'0');
     state<=swait;
	--------------------------------------
     when swait=>
     o_led<='0';
     if(counter<wait_time) then
        if(tick='1') then
        counter<=counter+1;
        end if;
     else
     state<=sgo;
     end if;
     if start_stop='1' then
     state<=serr;
     end if;
	--------------------------------------
     when sgo=>
     digit7<="0110"; --displays GO
     digit6<="0000";
     an<="00110000"; -- displays null counter digits
     o_led<='1'; -- led stays on until start_stop button is pressed
     state<=scount;
     digit0<="0001"; -- reset digits to 1
     digit1<="0000";
     digit2<="0000";
     digit3<="0000";
	--------------------------------------
     when scount=>
     digit7<="0110"; --displays GO
     digit6<="0000";
     an<="00110000"; 
     o_led<='1';
     if(tick='1') then
         c0:="0";
         c1:="0";
         c2:="0";
         if digit0="1001" then 
            c0:="1";
            digit0<="0000";
         else
            digit0<=std_logic_vector(unsigned(digit0)+1);
         end if;
         if digit1="1001" and c0="1" then
            c1:="1";
            digit1<=(others=>'0');
         else
            digit1<=std_logic_vector(unsigned(digit1)+unsigned(c0));
         end if;
         if digit2="1001" and c1="1" then
            c2:="1";
            digit2<=(others=>'0');
         else
            digit2<=std_logic_vector(unsigned(digit2)+unsigned(c1));
         end if;
         if c2="1" then
            digit3<="0001";
            state<=stout; -- more that one second has passed, time out
         end if;
     end if;
     if start_stop='1' then
        state<=send;
     end if;
	--------------------------------------
     when send=>
     o_led<='0';
     digit7<="1010"; --displays res
     digit6<="1011";
     digit5<="0101";
     an<="00010000";
     if start_stop='1' then
     state<=sstart;
     end if;
     when stout=>
     o_led<='0';
     digit7<="1110"; --displays tout
     digit6<="0000";
     digit5<="1111";
     digit4<="1110";
     an<="00000000";
     if start_stop='1' then
     state<=sstart;
     end if;
	--------------------------------------
     when serr=>
     o_led<='0';
     digit7<="1011"; -- displays err
     digit6<="1010";
     digit5<="1010";
     an<="00011111";
     if start_stop='1' then
     state<=sstart;
     end if;
	--------------------------------------
     when others=>
        null;
     end case;
     end if;
 end if;
end process;

end Behavioral;
