library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2 is
    Port ( sel : in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (31 downto 0);
           in2 : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end MUX_2;

architecture Behavioral of MUX_2 is

begin

    process(sel, in1, in2)
    begin
        case sel is
            when '0' => output <= in1;
            when '1' => output <= in2;
            when others => output <= x"00000000";
        end case;
    end process;

end Behavioral;
