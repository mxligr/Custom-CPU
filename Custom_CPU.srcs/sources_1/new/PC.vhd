library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( clk : in STD_LOGIC;
           PC_Reset : in STD_LOGIC;
           PC_D : in STD_LOGIC_VECTOR (31 downto 0);
           PC_Q : out STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is
begin

    process(clk, PC_Reset)
     begin 
        if(rising_edge(clk)) then
            PC_Q <= PC_D; 
        end if;
        if(PC_Reset = '1') then
            PC_Q <= x"00000000";
        end if;       
    end process;

end Behavioral;
