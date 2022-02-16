library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity RegFile is
    Port ( clk : in STD_LOGIC;
           ra1 : in STD_LOGIC_VECTOR (7 downto 0);
           ra2 : in STD_LOGIC_VECTOR (7 downto 0);
           wa : in STD_LOGIC_VECTOR (7 downto 0);
           wd : in STD_LOGIC_VECTOR (31 downto 0);
           RegWr : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));
end RegFile;

architecture Behavioral of RegFile is
type reg_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
signal reg_file : reg_array := (
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
    x"00000011",
    x"00000012",
    x"00000013",
    x"00000014",
    x"00000015",
    x"00000016",
    x"00000017",
    x"00000018",
    x"00000019",
    x"00000010",
    x"0000001A",
    x"0000001B",
    x"0000001C",
    others => x"00000000"
    );
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if RegWr = '1' then
                reg_file(conv_integer(wa)) <= wd;
            end if;
        end if;
    end process;
    
    rd1 <= reg_file(conv_integer(ra1));
    rd2 <= reg_file(conv_integer(ra2));

end Behavioral;