library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlagReg is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           FlagEn : in STD_LOGIC;
           Carry : in STD_LOGIC;
           Zero : in STD_LOGIC;
           Sign : in STD_LOGIC;
           Overflow : in STD_LOGIC;
           CF : out STD_LOGIC;
           ZF : out STD_LOGIC;
           SF : out STD_LOGIC;
           OvF : out STD_LOGIC);
end FlagReg;

architecture Behavioral of FlagReg is

begin

    process(clk, rst, FlagEn)
    begin
        if (rst = '1') then
            CF <= '0';
            ZF <= '0';
            SF <= '0';
            OvF <= '0';
        elsif (rising_edge(clk)) then
            if(FlagEn = '1') then
                CF <= Carry;
                ZF <= Zero;
                SF <= Sign;
                OvF <= Overflow;
            end if;
        end if;
    end process;

end Behavioral;
