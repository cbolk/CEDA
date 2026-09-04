

--first test: iteration #1
--wait for the led to light up
-- i_start_stop signal bounces for less than  20 ms

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb1 is
--  Port ( );
end tb1;

architecture Behavioral of tb1 is
component reflex_tester is 
Port(
clk: in std_logic;
rst: in std_logic;
i_start_stop: in std_logic;
o_led: out std_logic;
display: out std_logic_vector(6 downto 0);
anode: out std_logic_vector(7 downto 0)
);
end component;
signal clk, rst, i_start_stop, o_led: std_logic;
signal seg: std_logic_vector(6 downto 0);
signal anode: std_logic_vector(7 downto 0);
constant clk_period: time :=10 ns;

begin
cmp: reflex_tester
port map(clk, rst, i_start_stop, o_led, seg, anode);


clk_process: process
begin
clk<='0';
wait for clk_period/2;
clk<='1';
wait for clk_period/2;
end process;

process 
begin
i_start_stop<='0';
rst<='0';
wait for 1ms;

-- rst signal bounces
rst<='1';
wait for 1ms;
rst<='0';       -- reset alto
wait for 2000ns;
rst<='1';
wait for 5 ms;
rst<='0';       -- reset alto
wait for 2000ns;
rst<='1';
wait for 3 ms;
rst<='0';       -- reset alto
wait for 2000ns;
rst<='1';
wait for 3 ms;
rst<='0';


-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- start!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';

--wait for the led to light up
wait until rising_edge(o_led);

--reaction time
wait for 234 ms;

-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- stop!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';


--shows the result for 50 ms before starting new test
wait for 50 ms;

-- next test: timeout


-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- start!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';


--wait for the led to light up
wait until rising_edge(o_led);

--no reaction after 1 s
wait for 1000 ms;

--shows tout for 50 ms
wait for 50 ms;

--next: start button pressed before led lights up

-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- start!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';


--reaction time is less than the minimum wait time for the led to light up
wait for 500 ms;

-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- stop!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';

--shows err for 50 ms
wait for 50 ms;

--next test: check that after err a regular test can still be done

-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- start!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';

-- wait for the led to light up
wait until rising_edge(o_led);

--reaction time
wait for 234 ms;

-- i_start_stop signal bounces for less than  20 ms
i_start_stop<='1';   -- stop!
wait for 1ms;
i_start_stop<='0';
wait for 1001 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 2003 ns;
i_start_stop<='1';
wait for 4 ms;
i_start_stop<='0';
wait for 1506 ns;
i_start_stop<='1';
wait for 2 ms;
i_start_stop<='0';


--shows result for 50 ms
wait for 50 ms;
assert(false) report "ok" severity failure;
end process;
end Behavioral;

