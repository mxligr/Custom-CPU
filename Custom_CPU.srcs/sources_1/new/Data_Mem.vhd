library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Data_Mem is
    Port ( clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in std_logic_vector(31 downto 0);
           MemWrite : in STD_LOGIC;
           MemRead : in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (31 downto 0));
end Data_Mem;

architecture Behavioral of Data_Mem is

type ram_type is array (0 to 255) of std_logic_vector(31 downto 0);
signal RAM:ram_type:=(
        x"00000000",
        x"00000001",
        x"00000002",
        x"00000003",
        x"00000004",
        x"00000005",
        x"00000006",
        x"00000007",
        x"00000008",
        x"00000009",
        x"0000000A",
        x"0000000B",
        x"0000000C",
        x"0000000D",
        x"0000000E",
        x"0000000F",
        x"00000010",
        others => x"00000000");
        
begin

    process(clk, addr, MemWrite, MemRead)
    begin
        if(falling_edge(clk)) then
            if MemWrite = '1' then
                RAM(conv_integer(addr)) <= WriteData;
            end if;
            if MemRead = '1' then
                data <= RAM(conv_integer(addr));
            end if;
        end if;
    end process;

end Behavioral;
