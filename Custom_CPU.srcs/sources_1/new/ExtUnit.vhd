library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.ALL;

entity ExtUnit is
    Port ( ExtOp : in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (31 downto 0));
end ExtUnit;

architecture Behavioral of ExtUnit is

begin

process(ExtOp, Instruction)
       begin
           case ExtOp is
               when '0' => Ext_Imm <= x"0000"&Instruction(15 downto 0);
               when '1' => Ext_Imm <= std_logic_vector(resize(signed(Instruction(15 downto 0)), Ext_Imm'length));
               when others => Ext_Imm <= x"00000000";
           end case;
        end process;

end Behavioral;
