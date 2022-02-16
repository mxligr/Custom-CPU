library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_tb is
  --Port ( );
end CPU_tb;

architecture Behavioral of CPU_tb is

component CPU is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component;

signal clk, rst: std_logic := '0';

begin
l1: CPU port map(
    clk => clk,
    rst => rst);

process
    begin
        rst <= '1';
        wait for 1 us;
        rst <= '0';
        wait;
    end process;

 process 
    begin
        clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
    end process;
end Behavioral;


